import type * as vscode from "vscode";
import { workspace, window } from "vscode";
import {
	LanguageClient,
	type LanguageClientOptions,
	type ServerOptions,
	TransportKind,
} from "vscode-languageclient/node";

let client: LanguageClient;

export function activate(context: vscode.ExtensionContext) {
	const serverModule = require.resolve("@surrealdb/lsp/node");

	const serverOptions: ServerOptions = {
		run: { module: serverModule, transport: TransportKind.ipc },
		debug: {
			module: serverModule,
			transport: TransportKind.ipc,
			options: { execArgv: ["--nolazy", "--inspect=6009"] },
		},
	};

	const clientOptions: LanguageClientOptions = {
		documentSelector: [{ scheme: "file", language: "surrealql" }],
		synchronize: {
			fileEvents: workspace.createFileSystemWatcher("**/*.{surql,surrealql}"),
			configurationSection: "surrealql",
		},
	};

	client = new LanguageClient(
		"surrealql",
		"SurrealQL Language Server",
		serverOptions,
		clientOptions,
	);

	// Start the language client
	client.start().catch((err) => {
		window.showInformationMessage(
			`SurrealQL Language Server failed to start: ${err.message}`,
		);
	});
}

export function deactivate(): Thenable<void> | undefined {
	return client?.stop();
}

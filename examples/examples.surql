-- Define a global function which can be used in any query
DEFINE FUNCTION fn::get_person($first: string, $last: string, $birthday: string) {

	LET $person = SELECT * FROM person WHERE [first, last, birthday] = [$first, $last, $birthday];

	RETURN IF $person[0].id THEN
		$person[0]
	ELSE
		CREATE person SET first = $first, last = $last, birthday = $birthday
	END;

};

function
// arguments
(
	-- test
	(SELECT * FROM test),
	-- other
	record:id,
	123,
	"bla",
	-- Wow, lot's of subqueries
	-- This will actually slow down parsing immensely haha
	(((((123))))),
	$test.test
) 

// Body
{
	// Javascript!!!
	const test = 123;
	const obj = {
		test: 'cool'
	}

	const query = surrealql`
		function() {
			const test = surql`
				select * from test
				function() {
					const test = surql`
						select * from test
						function() {
							const test = surrealql`
								select * from test
							`;
						}
					`;
				}
			`;
		}
	`
}

-- Call the global custom function, receiving the returned result
LET $person = fn::get_person('Tobie', 'Morgan Hitchcock', '2022-09-21');

{
	abc: 123
	SELECT * FROM something
}

RETURN {
	return {
		abc: 123
		test: "string"
		SELECT * FROM something
	}
}

DEFINE TABLE test SCHEMAFULL;

DEFINE FUNCTION fn::test($arg: string) {
	RETURN 123;
};

IF (true) THEN
	return 123;
IF ELSE (false) THEN
	return 456;
ELSE
	return 789;
END;

let $test = 123;

SLEEP 1s;

SELECT
    id,
    title,
    search::highlight('<b>', '</b>', 6) AS content,
    search::score(0) * 7.1 + search::score(1) * 6 + search::score(2) * 5 + search::score(3) * 4
    + search::score(4) * 3 + search::score(5) * 2 + search::score(6) AS score
FROM page
	WHERE title @0@ 'install linux'
		OR path @1@ 'install linux'
		OR h1 @2@ 'install linux'
		OR h2 @3@ 'install linux'
		OR h3 @4@ 'install linux'
		OR h4 @5@ 'install linux'
		OR content @6@ 'install linux'
	ORDER BY score DESC
	LIMIT 10;

DEFINE ANALYZER simple TOKENIZERS blank,class,camel,punct FILTERS snowball(english);
DEFINE INDEX page_title ON page FIELDS title SEARCH ANALYZER simple BM25(1.2,0.75);
DEFINE INDEX page_path ON page FIELDS path SEARCH ANALYZER simple BM25(1.2,0.75);
DEFINE INDEX page_h1 ON page FIELDS h1 SEARCH ANALYZER simple BM25(1.2,0.75);
DEFINE INDEX page_h2 ON page FIELDS h2 SEARCH ANALYZER simple BM25(1.2,0.75);
DEFINE INDEX page_h3 ON page FIELDS h3 SEARCH ANALYZER simple BM25(1.2,0.75);
DEFINE INDEX page_h4 ON page FIELDS h4 SEARCH ANALYZER simple BM25(1.2,0.75);
DEFINE INDEX page_content ON page FIELDS content SEARCH ANALYZER simple BM25(1.2,0.75) HIGHLIGHTS;
DEFINE INDEX page_code ON page FIELDS code SEARCH ANALYZER simple BM25(1.2,0.75);

-- Ensure that function names don't get mistaken for object keys :)
RETURN {
	RETURN string::lowercase("ABC");
}
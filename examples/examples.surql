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
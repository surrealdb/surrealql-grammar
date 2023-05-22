-- Define a global function which can be used in any query
DEFINE FUNCTION fn::get_person($first: string, $last: string, $birthday: string) {

	LET $person = SELECT * FROM person WHERE [first, last, birthday] = [$first, $last, $birthday];

	RETURN IF $person[0].id THEN
		$person[0]
	ELSE
		CREATE person SET first = $first, last = $last, birthday = $birthday
	END;

};

-- Call the global custom function, receiving the returned result
LET $person = fn::get_person('Tobie', 'Morgan Hitchcock', '2022-09-21');
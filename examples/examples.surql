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
};

-- Ensure that record IDs are highlighted properly
RETURN {
	test: 123,
	test:123,
	test: test:123
};

-- Make sure that object keys do not get highlighted as keywords, constants, etc...
-- Exception to the rule is strings
RETURN {
	select: 123,
	true: false,
	"double": "quoted",
	'single': 'quoted'
};

-- And one big complex single line object to round it off
RETURN { test: 123, test:123, test: test:123, 'single': 'quote', "double": "quote", func: string::lowercase("ABC") };


###############################################
### lib/test.surql FROM surrealdb/surrealdb ### 
###############################################


// A raw mathematical expression at the base of the query
3 * 5 = 15;

// A raw record expression at the base of the query
person:tobie->knows->?;

-- CREATE a new table record with a random id
CREATE person;

-- CREATE a new table record with a specific integer id
CREATE person:13059;

-- CREATE a new table record with a backtick escaped string
CREATE person:`some record id`;

-- CREATE a new table record with a angle bracket escaped string
CREATE person:⟨some record id⟩;

-- CREATE a new table record with an complex array based id
CREATE person:['London', time::now()];

-- CREATE a new table record with an complex object based id
CREATE person:{ city: 'London', time: time::now() };

-- CREATE a new table record with a randomly generated id
CREATE person:rand();

-- CREATE a new table record with a randomly generated ULID
CREATE person:ulid();

-- CREATE a new table record with a randomly generated UUID
CREATE person:uuid();

-- CREATE a new table record with a random id, and set the record content
CREATE person CONTENT { name: { first: 'Tobie', last: 'Morgan Hitchcock'} };

-- CREATE a new table record with a specific string id, and set the record content
CREATE person:tobie CONTENT { name: 'Tobie', siblings: [person:jaime] };

-- Define a new custom namespaced function for lowercasing a string
DEFINE FUNCTION fn::my::custom::namespaced::lowercase($name: string) {
	-- The following doesn't parse, as we don't yet support function chaining
    -- RETURN $name.lowercase();
	RETURN string::lowercase($name);
};

-- A really complex query
SELECT
    *,
	# This is a single line comment using hash
    tags[0].value,
	-- This is a single line comment using dashes
    tags[$].value,
	// This is a single line comment using slashes
    3s as duration,
	/*
		this is an multiline block comment, that
		can be used an interspersed within sql
	*/
    1.345 AS number,
	100000f AS float_number,
	100000dec AS decimal_number,
	<array<string, 5>> ["a", "b", "c", "d", "e"],
	-- The following doesn't parse, as we don't yet support function chaining
    -- tags[*].contains('database') AS has_tag,
    tags[*] CONTAINS 'database' AS `has-tag`,
    1749284739243842973049283492847029475.294874902847590284 AS decimal,
	->purchased->(phone, laptop WHERE new = true)<-purchased<-person.emails->sent->email.subject AS email_subjects,
	<-knows->person AS people_who_know_me,
    [
        test,
        <float> 13456,
        <decimal> 13456,
        {
            LET $people = (SELECT * FROM person);
			LET $animals = SELECT * FROM cat, dog;
            RETURN array::combine($people, $animals);
        },
        person:tobie->purchased->(phone, laptop WHERE new = true).sku,
        math::PI > 3.14,
		-- The following doesn't parse, as we don't yet support function chaining
        -- <future> { person:tobie.tags.reverse().slice(0, 4) },
        <future> { array::slice(array::reverse(person:tobie.tags), 0, 4) },
        fn::my::custom::namespaced::function('Tobie'),
    ],
	math::PI > 3.14 AS check_constant,
    test AS `some thing`,
    '2012-04-23T18:25:43.511Z' AS utctime,
    '2012-04-23T18:25:43.511-08:00' AS pacifictime,
    {
        key: (3 + 1 + 2),
        other: 9 * 7,
        'some thing': {
            otherkey: 'text',
        }
    } AS object,
    rand::uuid::v4() AS a_uuid_field,
    "ff36afd6-6689-4c02-8c8c-7df478924645" AS ⟨another id field⟩,
	if true {
		'Yay'
	} else {
		'Oops'
	} AS if_else
FROM
	$param,
	test,
	temp,
	test:thingy,
	|test:10|,
	|test:1..10|,
	user:4104810..,
	user:4104810..96830483,
	user:..96830483,
	temperature:['London', NONE]..=['London', time::now()]
WHERE IF true THEN 'YAY' ELSE 'OOPS' END
    AND (0.1341, 0.5719) INSIDE {
        type: 'Polygon',
        coordinates: [
            [[0.1341, 0.5719], [0.1341, 0.5719]]
        ]
    }
    AND (3 + 3 * 4) = 6
    AND 3 + 3 * 4 = 6
    AND ages CONTAINS 18
    AND if IS true
    AND 346 <= 789
    AND 678 >= 345
    AND (
        then = true
        OR if = true
        OR create is NONE
        OR delete = NULL
        OR delete INSIDE ['one', 'two', 'three']
    )
SPLIT test.things
VERSION '2019-01-01T08:00:00Z'
TIMEOUT 2w;

record:⟨another id field⟩;
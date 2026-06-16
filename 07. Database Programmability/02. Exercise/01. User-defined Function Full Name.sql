DROP FUNCTION IF EXISTS fn_full_name;
--
CREATE OR REPLACE FUNCTION fn_full_name("first_name" VARCHAR(50), "last_name" VARCHAR(50))
    RETURNS VARCHAR(101) AS
$$
DECLARE
    "full_name" VARCHAR(101);
BEGIN
    IF "first_name" IS NULL AND "last_name" IS NULL THEN
        "full_name" := NULL;
    ELSIF "last_name" IS NULL THEN
        "full_name" := INITCAP("first_name");
    ELSIF "first_name" IS NULL THEN
        "full_name" := INITCAP("last_name");
    ELSE
        "full_name" := CONCAT(INITCAP(LOWER("first_name")), ' ', INITCAP(LOWER("last_name")));
    END IF;

    RETURN "full_name";
END;
$$
    LANGUAGE plpgsql;
--
SELECT fn_full_name('John', 'Smith');

SELECT fn_full_name('fred', 'sanford');

SELECT fn_full_name('', 'SIMPSONS');

SELECT fn_full_name('JOHN', '');

SELECT fn_full_name(NULL, NULL)
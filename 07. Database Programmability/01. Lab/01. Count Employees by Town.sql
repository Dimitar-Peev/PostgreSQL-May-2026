CREATE OR REPLACE FUNCTION fn_count_employees_by_town("town_name" VARCHAR(20))
    RETURNS INT AS
$$
DECLARE
    "count" INT;
BEGIN
    SELECT COUNT("employee_id")
    INTO "count"
    FROM "employees"
             INNER JOIN "addresses"
                        USING ("address_id")
             INNER JOIN "towns"
                        USING ("town_id")
    WHERE "name" = "town_name";
    RETURN "count";
END;
$$
    LANGUAGE plpgsql;

SELECT fn_count_employees_by_town('Sofia') AS "count"; -- 3

SELECT fn_count_employees_by_town('Berlin') AS "count"; -- 1

SELECT fn_count_employees_by_town(NULL) AS "count"; -- 0
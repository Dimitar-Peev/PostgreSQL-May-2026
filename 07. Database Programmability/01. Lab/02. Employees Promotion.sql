DROP PROCEDURE IF EXISTS sp_increase_salaries;
--
CREATE OR REPLACE PROCEDURE sp_increase_salaries("department_name" VARCHAR(50))
AS
$$
BEGIN
    UPDATE "employees" AS e
    SET "salary" = "salary" * 1.05
    WHERE e."department_id" = (SELECT "department_id"
                               FROM "departments"
                               WHERE "name" = "department_name");
END;
$$
    LANGUAGE plpgsql;
--
CALL sp_increase_salaries('Sales');
SELECT "employee_id", "salary"
FROM "employees"
ORDER BY "employee_id";

CALL sp_increase_salaries('Finance');
SELECT "first_name", "salary"
FROM "employees"
WHERE "department_id" = (SELECT "department_id"
                         FROM "departments"
                         WHERE "name" = 'Finance')
ORDER BY "first_name";

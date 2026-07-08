CREATE OR REPLACE FUNCTION fn_courses_by_client("phone_num" VARCHAR(20))
    RETURNS INT
AS
$$
DECLARE
    "course_count" INT;
BEGIN
    SELECT COUNT(*)
    FROM "clients" AS c
             INNER JOIN "courses" AS co
                        ON c."id" = co."client_id"
    WHERE c."phone_number" = "phone_num"
    INTO "course_count";

    RETURN "course_count";
END;
$$
    LANGUAGE plpgsql;
--
SELECT fn_courses_by_client('(803) 6386812'); -- 5
SELECT fn_courses_by_client('(831) 1391236'); -- 3
SELECT fn_courses_by_client('(704) 2502909'); -- 0


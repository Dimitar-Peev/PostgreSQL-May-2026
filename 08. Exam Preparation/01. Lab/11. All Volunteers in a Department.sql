CREATE OR REPLACE FUNCTION fn_get_volunteers_count_from_department("searched_volunteers_department" VARCHAR(30))
    RETURNS INT
AS
$$
DECLARE
    "volunteer_count" INT;
BEGIN
    "volunteer_count" := (SELECT COUNT(*)
                          FROM "volunteers" AS v
                                   INNER JOIN "volunteers_departments" AS vd
                                              ON v."department_id" = vd."id"
                          WHERE vd."department_name" = "searched_volunteers_department");

    RETURN "volunteer_count";
END;
$$
    LANGUAGE plpgsql;
--
SELECT fn_get_volunteers_count_from_department('Education program assistant'); -- 6
SELECT fn_get_volunteers_count_from_department('Guest engagement'); -- 4
SELECT fn_get_volunteers_count_from_department('Zoo events'); --	5

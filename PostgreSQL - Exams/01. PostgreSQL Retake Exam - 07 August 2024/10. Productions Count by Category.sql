DROP FUNCTION IF EXISTS udf_category_productions_count(VARCHAR(50));
--
CREATE OR REPLACE FUNCTION udf_category_productions_count("category_name" VARCHAR(50))
    RETURNS VARCHAR(100) AS
$$
DECLARE
    "productions_count" INTEGER;
BEGIN
    SELECT COUNT(cp."production_id")
    INTO "productions_count"
    FROM "categories" AS c
             INNER JOIN "categories_productions" AS cp
                        ON c."id" = cp."category_id"
    WHERE c."name" = "category_name";

    RETURN CONCAT('Found ', "productions_count", ' productions.');
END;
$$
    LANGUAGE plpgsql;
--
SELECT udf_category_productions_count('Nonexistent') AS "message_text"; -- Found 0 productions.
SELECT udf_category_productions_count('History') AS "message_text"; -- Found 3 productions.
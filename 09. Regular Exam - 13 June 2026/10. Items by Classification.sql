DROP FUNCTION IF EXISTS udf_classification_items_count("classification_name_param" VARCHAR(30));
--
CREATE OR REPLACE FUNCTION udf_classification_items_count("classification_name_param" VARCHAR(30))
    RETURNS TEXT
AS
$$
DECLARE
    "items_count" INT;
BEGIN
    "items_count" := (SELECT COUNT(i."id")
                      FROM "items" AS i
                               INNER JOIN "classifications" AS c
                                          ON i."classification_id" = c."id"
                      WHERE c."name" = "classification_name_param");

    IF "items_count" > 0 THEN
        RETURN CONCAT('Found ', "items_count", ' items.');
    ELSE
        RETURN 'No items found.';
    END IF;
END;
$$
    LANGUAGE plpgsql;
--
SELECT udf_classification_items_count('Nonexistent') AS message_text;
SELECT udf_classification_items_count('Laptops') AS message_text;
DROP PROCEDURE IF EXISTS sp_animals_with_owners_or_not;
--
CREATE OR REPLACE PROCEDURE sp_animals_with_owners_or_not(IN "animal_name" VARCHAR(30), OUT "owner_name" VARCHAR(150))
AS
$$
BEGIN
    SELECT o."name"
    FROM "animals" AS a
             INNER JOIN "owners" AS o
                        ON a."owner_id" = o."id"
    WHERE a."name" = "animal_name"
    INTO "owner_name";

    IF "owner_name" IS NULL THEN
        "owner_name" := 'For adoption';
    END IF;
END;
$$
    LANGUAGE plpgsql;
--
CALL sp_animals_with_owners_or_not('Pumpkinseed Sunfish', NULL);
-- Kamelia Yancheva

-- Call procedure using an OUT parameter
DO
$$
    DECLARE
        owner_name_result VARCHAR(150);
    BEGIN
        CALL sp_animals_with_owners_or_not('Pumpkinseed Sunfish', owner_name_result);
        RAISE NOTICE '%', owner_name_result;
    END;
$$; -- Kamelia Yancheva

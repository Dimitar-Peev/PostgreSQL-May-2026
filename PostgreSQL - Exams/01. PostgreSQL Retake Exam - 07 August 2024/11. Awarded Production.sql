DROP PROCEDURE IF EXISTS udp_awarded_production;
--
CREATE OR REPLACE PROCEDURE udp_awarded_production("production_title" VARCHAR(70))
AS
$$
DECLARE
    "production_id" INTEGER;
BEGIN
    SELECT p."id"
    INTO "production_id"
    FROM "productions" AS p
    WHERE p."title" = "production_title";

    IF "production_id" IS NOT NULL THEN
        UPDATE "actors"
        SET "awards" = "awards" + 1
        WHERE "id" IN (SELECT "actor_id"
                       FROM "productions_actors");
    END IF;
END;
$$
    LANGUAGE plpgsql;

-- before
SELECT a."first_name", a."last_name", a."awards"
FROM "actors" AS a
         INNER JOIN "productions_actors" AS pa
                    ON a."id" = pa."actor_id"
         INNER JOIN "productions" AS p
                    ON p."id" = pa."production_id"
WHERE p."title" = 'Tea For Two'
ORDER BY a."first_name";
--  first_name | last_name  | awards
-- ------------+------------+--------
--  Brandon    | Eykelhof   |      0
--  Flem       | Loomis     |     19
--  Jared      | Di Batista |      0
--  Wolfgang   | Vowdon     |      7

CALL udp_awarded_production('Tea For Two');

-- after
SELECT a."first_name", a."last_name", a."awards"
FROM "actors" AS a
         INNER JOIN "productions_actors" AS pa
                    ON a."id" = pa."actor_id"
         INNER JOIN "productions" AS p
                    ON p."id" = pa."production_id"
WHERE p."title" = 'Tea For Two'
ORDER BY a."first_name";
--  first_name | last_name  | awards
-- ------------+------------+--------
--  Brandon    | Eykelhof   |      1
--  Flem       | Loomis     |     20
--  Jared      | Di Batista |      1
--  Wolfgang   | Vowdon     |      8
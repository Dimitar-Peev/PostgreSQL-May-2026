INSERT INTO "actors" ("first_name", "last_name", "birthdate", "height", "awards", "country_id")
SELECT REVERSE(a."first_name")                                 AS "first_name",
       REVERSE(a."last_name")                                  AS "last_name",
       (a."birthdate" - INTERVAL '2 days')::DATE               AS "birthdate",
       COALESCE(a."height", 0) + 10                            AS "height",
       a."country_id"                                          AS "awards",
       (SELECT "id" FROM "countries" WHERE "name" = 'Armenia') AS "country_id"
FROM "actors" AS a
WHERE a."id" BETWEEN 10 AND 20;

-- Check after insert
SELECT * FROM "actors"
WHERE "id" > (SELECT MAX("id") - 11 FROM "actors")
ORDER BY "id"
LIMIT 11;

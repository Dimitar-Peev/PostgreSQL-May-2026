-- check before DELETE
SELECT id, name
FROM "countries";

-- Execute the DELETE statement
DELETE
FROM "countries"
WHERE "id" NOT IN (SELECT a."country_id"
                   FROM "actors" a)
  AND "id" NOT IN (SELECT p."country_id"
                   FROM "productions" p);

-- check after DELETE
SELECT id, name
FROM "countries";
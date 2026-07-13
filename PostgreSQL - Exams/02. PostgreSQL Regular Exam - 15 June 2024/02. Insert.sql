INSERT INTO "addresses" ("street", "town", "country", "account_id")
SELECT a."username" AS "street",
       a."password" AS "town",
       a."ip"       AS "country",
       a."age"      AS "account_id"
FROM "accounts" a
WHERE a."gender" = 'F';

-- check
SELECT "id",
       "street",
       "town",
       "country",
       "account_id"
FROM "addresses"
ORDER BY "id";
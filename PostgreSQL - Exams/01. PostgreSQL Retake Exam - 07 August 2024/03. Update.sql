-- Check before UPDATE
SELECT "id", "duration", "synopsis"
FROM "productions_info"
ORDER BY "id";

-- Execute the UPDATE statement
UPDATE "productions_info"
SET "duration" = "duration" +
                 CASE
                     WHEN "id" < 15 THEN 15
                     WHEN "id" >= 20 THEN 20
                     ELSE 0
                     END
WHERE "synopsis" IS NULL
  AND ("id" < 15 OR "id" >= 20);

-- Check after UPDATE
SELECT "id", "duration", "synopsis"
FROM "productions_info"
ORDER BY "id";
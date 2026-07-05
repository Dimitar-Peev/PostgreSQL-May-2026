-- Prior to beginning, it is necessary to import "00. 00. 00. dataset.sql".
--
INSERT INTO "clients"("full_name", "phone_number")
SELECT CONCAT("first_name", ' ', "last_name"),
       CONCAT('(088) 9999', 2 * "id")
FROM "drivers"
WHERE "id" BETWEEN 10 AND 20;
-- checking
SELECT *
FROM "clients";
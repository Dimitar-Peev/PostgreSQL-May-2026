CREATE TABLE "gift_recipients"
(
    "id"         INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "name"       VARCHAR(75),
    "country_id" INT,
    "gift_sent"  BOOLEAN DEFAULT FALSE
);

INSERT INTO "gift_recipients" ("name", "country_id", "gift_sent")
SELECT CONCAT("first_name", ' ', "last_name") AS "name",
       "country_id",
       CASE
           WHEN "country_id" IN (7, 8, 14, 17, 26) THEN TRUE
           ELSE FALSE
           END                                AS "gift_sent"
FROM "customers";
CREATE TABLE "search_results"
(
    "id"            SERIAL PRIMARY KEY,
    "address_name"  VARCHAR(50),
    "full_name"     VARCHAR(100),
    "level_of_bill" VARCHAR(20),
    "make"          VARCHAR(30),
    "condition"     CHAR(1),
    "category_name" VARCHAR(50)
);
--
CREATE OR REPLACE PROCEDURE sp_courses_by_address("address_name" VARCHAR(100))
AS
$$
BEGIN
    TRUNCATE TABLE "search_results";

    INSERT INTO "search_results" ("address_name", "full_name", "level_of_bill", "make", "condition", "category_name")
    SELECT a."name"   AS "address_name",
           cl."full_name",
           CASE
               WHEN co."bill" <= 20 THEN 'Low'
               WHEN co."bill" <= 30 THEN 'Medium'
               ELSE 'High'
               END    AS "level_of_bill",
           c."make",
           c."condition",
           cat."name" AS "category_name"
    FROM "courses" AS co
             INNER JOIN "addresses" AS a
                        ON co."from_address_id" = a."id"
             INNER JOIN "clients" AS cl
                        ON co."client_id" = cl."id"
             INNER JOIN "cars" AS c
                        ON co."car_id" = c."id"
             INNER JOIN "categories" AS cat
                        ON c."category_id" = cat."id"
    WHERE a."name" = "address_name"
    ORDER BY c."make" ASC,
             cl."full_name" ASC;
END;
$$
    LANGUAGE plpgsql;
--
CALL sp_courses_by_address('700 Monterey Avenue');

SELECT "address_name", "full_name", "level_of_bill", "make", "condition", "category_name"
FROM "search_results";

--     address_name     |     full_name     | level_of_bill |     make      | condition | category_name
-- ---------------------+-------------------+---------------+---------------+-----------+---------------
--  700 Monterey Avenue | Kelcy Cody        | Medium        | Acura         | B         | Hatchback
--  700 Monterey Avenue | Zeke Rowston      | Medium        | GMC           | A         | Coupe
--  700 Monterey Avenue | Joyann Garrettson | High          | Lamborghini   | A         | SUV
--  700 Monterey Avenue | Courtney Gawkes   | Low           | Mercedes-Benz | B         | Cabrio
--  700 Monterey Avenue | Jeralee Tue       | Low           | Mercedes-Benz | B         | Cabrio
--  700 Monterey Avenue | Haven Seaton      | High          | Mitsubishi    | B         | Hatchback

CALL sp_courses_by_address('66 Thompson Drive');

SELECT "address_name", "full_name", "level_of_bill", "make", "condition", "category_name"
FROM "search_results";

--    address_name    |   full_name    | level_of_bill |    make    | condition | category_name
-- -------------------+----------------+---------------+------------+-----------+---------------
--  66 Thompson Drive | Kimball Deem   | High          | Pontiac    | C         | Hatchback
--  66 Thompson Drive | Kaylee Coushe  | High          | Porsche    | B         | Coupe
--  66 Thompson Drive | Gibbie Liggens | High          | Volkswagen | A         | Coupe


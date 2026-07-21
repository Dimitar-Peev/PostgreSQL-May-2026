DROP PROCEDURE IF EXISTS sp_customer_country_name;
--
CREATE OR REPLACE PROCEDURE sp_customer_country_name("customer_full_name" VARCHAR(50), OUT "country_name" VARCHAR(50))
AS
$$
BEGIN
    SELECT co."name"
    INTO "country_name"
    FROM "customers" AS c
             INNER JOIN "countries" AS co
                        ON co."id" = c."country_id"
    WHERE CONCAT(c."first_name", ' ', c."last_name") = "customer_full_name";
END;
$$
    LANGUAGE plpgsql;
--
CALL sp_customer_country_name('Betty Wallace', ''); -- South Korea
CALL sp_customer_country_name('Rachel Bishop', ''); -- Japan
CALL sp_customer_country_name('Jerry Andrews', ''); -- Bangladesh

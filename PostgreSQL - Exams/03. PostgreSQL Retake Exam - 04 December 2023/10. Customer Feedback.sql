DROP FUNCTION IF EXISTS fn_feedbacks_for_product("product_name" VARCHAR(25));
--
CREATE OR REPLACE FUNCTION fn_feedbacks_for_product("product_name" VARCHAR(25))
    RETURNS TABLE
            (
                "customer_id"          INT,
                "customer_name"        VARCHAR(75),
                "feedback_description" VARCHAR(255),
                "feedback_rate"        NUMERIC(4, 2)
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT c."id"          AS "customer_id",
               c."first_name"  AS "customer_name",
               f."description" AS "feedback_description",
               f."rate"        AS "feedback_rate"
        FROM "feedbacks" AS f
                 INNER JOIN "customers" AS c
                            ON c."id" = f."customer_id"
                 INNER JOIN "products" AS p
                            ON p."id" = f."product_id"
        WHERE p."name" = "product_name"
        ORDER BY "customer_id";
END;
$$
    LANGUAGE plpgsql;
--
SELECT *
FROM fn_feedbacks_for_product('Banitsa');
--  customer_id | customer_name |  feedback_description  | feedback_rate
-- -------------+---------------+------------------------+---------------
--           18 | Edward        | Well- it is overpriced |          5.54

SELECT *
FROM fn_feedbacks_for_product('ALCOHOL');
--  customer_id | customer_name |    feedback_description    | feedback_rate
-- -------------+---------------+----------------------------+---------------
--           15 | Randy         | Let's find some flavours   |          8.94
--           23 | Richard       | I did not like the product |          2.04
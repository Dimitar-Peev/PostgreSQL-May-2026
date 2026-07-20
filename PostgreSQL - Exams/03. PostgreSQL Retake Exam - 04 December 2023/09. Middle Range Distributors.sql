SELECT d."name"      AS "distributor_name",
       i."name"      AS "ingredient_name",
       p."name"      AS "product_name",
       AVG(f."rate") AS "average_rate"
FROM "distributors" AS d
         INNER JOIN "ingredients" AS i
                    ON i."distributor_id" = d."id"
         INNER JOIN "products_ingredients" AS pri
                    ON pri."ingredient_id" = i."id"
         INNER JOIN "products" AS p
                    ON p."id" = pri."product_id"
         INNER JOIN "feedbacks" AS f
                    ON f."product_id" = p."id"
GROUP BY d."name", i."name", p."name"
HAVING AVG(f."rate") BETWEEN 5 AND 8
ORDER BY "distributor_name" ASC,
         "ingredient_name" ASC,
         "product_name" ASC;
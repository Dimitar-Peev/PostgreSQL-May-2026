SELECT i."name" AS "ingredient_name",
       p."name" AS "product_name",
       d."name" AS "distributor_name"
FROM "ingredients" AS i
         INNER JOIN "products_ingredients" AS pri
                    ON pri."ingredient_id" = i."id"
         INNER JOIN "products" AS p
                    ON p."id" = pri."product_id"
         INNER JOIN "distributors" AS d
                    ON d."id" = i."distributor_id"
WHERE LOWER(i."name") LIKE '%mustard%'
  AND d."country_id" = 16
ORDER BY p."name" ASC;
SELECT a."name"   AS "address",
       CASE
           WHEN EXTRACT(HOUR FROM co."start") BETWEEN 6 AND 20 THEN 'Day'
           ELSE 'Night'
           END    AS "day_time",
       co."bill",
       cl."full_name",
       c."make",
       c."model",
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
ORDER BY co.id ASC;
SELECT c."name"                      AS "country_name",
       COUNT(p."id")                 AS "productions_count",
       COALESCE(AVG(pi."budget"), 0) AS "avg_budget"
FROM "countries" AS c
         INNER JOIN "productions" AS p
                    ON c."id" = p."country_id"
         INNER JOIN "productions_info" AS pi
                    ON p."production_info_id" = pi."id"
GROUP BY c."id", "country_name"
HAVING COUNT(p."id") >= 1
ORDER BY "productions_count" DESC, "country_name" ASC;
SELECT p."id"                                             AS "photo_id",
       TO_CHAR(p."capture_date", 'YYYY-MM-DD HH24:MI:SS') AS "capture_date",
       p."description",
       COUNT(c."id")                                      AS "comments_count"
FROM "photos" AS p
         INNER JOIN "comments" AS c
                    ON p."id" = c."photo_id"
WHERE p."description" IS NOT NULL
GROUP BY p."id", p."capture_date", p."description"
ORDER BY "comments_count" DESC, p."id" ASC
LIMIT 3;
SELECT CONCAT(a."first_name", ' ', a."last_name") AS "full_name",
       LOWER(LEFT(a."first_name", 1)) ||
       RIGHT(a."last_name", 2) ||
       LENGTH(a."last_name") ||
       '@sm-cast.com'                             AS "email",
       a."awards"
FROM "actors" a
         LEFT JOIN "productions_actors" pa ON a."id" = pa."actor_id"
WHERE pa."actor_id" IS NULL
ORDER BY a."awards" DESC, a."id" ASC;
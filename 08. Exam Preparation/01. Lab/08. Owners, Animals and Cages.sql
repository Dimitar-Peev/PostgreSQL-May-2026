SELECT CONCAT(o."name", ' - ', a."name") AS "owners - animals",
       o."phone_number",
       ac."cage_id"
FROM "owners" AS o
         INNER JOIN "animals" AS a
                    ON o."id" = a."owner_id"
         INNER JOIN "animal_types" AS at
                    ON a."animal_type_id" = at."id"
         INNER JOIN "animals_cages" AS ac
                    ON a."id" = ac."animal_id"
WHERE at."animal_type" = 'Mammals'
ORDER BY o."name" ASC, a."name" DESC;
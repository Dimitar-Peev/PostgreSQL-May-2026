SELECT *
FROM "departments" AS d
         INNER JOIN "employees" AS e
                    ON e."department_id" = d."id";
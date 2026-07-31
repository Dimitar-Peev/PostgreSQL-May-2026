SELECT CONCAT(c."first_name", ' ', c."last_name") AS "full_name",
       c."email",
       MAX(bg."rating")::NUMERIC                  AS "rating"
FROM "creators" AS c
         INNER JOIN "creators_board_games" AS cbg
                    ON c."id" = cbg."creator_id"
         INNER JOIN "board_games" AS bg
                    ON cbg."board_game_id" = bg."id"
WHERE c."email" LIKE '%.com'
GROUP BY c."id",
         c."first_name",
         c."last_name",
         c."email"
ORDER BY "full_name" ASC;
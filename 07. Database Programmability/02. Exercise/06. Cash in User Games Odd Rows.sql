DROP FUNCTION IF EXISTS fn_cash_in_users_games;
--
CREATE OR REPLACE FUNCTION fn_cash_in_users_games("game_name" VARCHAR(50))
    RETURNS TABLE
            (
                "total_cash" NUMERIC
            )
AS
$$
BEGIN
    RETURN QUERY
        WITH "ranked_games" AS (SELECT ug."cash",
                                       ROW_NUMBER() OVER (ORDER BY ug."cash" DESC) AS "row_num"
                                FROM "users_games" AS ug
                                         INNER JOIN "games" AS g
                                                    ON ug."game_id" = g."id"
                                WHERE g."name" = "game_name")

        SELECT ROUND(SUM("cash"), 2) AS "total_cash"
        FROM "ranked_games" AS rg
        WHERE rg."row_num" % 2 <> 0;
END;
$$
    LANGUAGE plpgsql;
--
SELECT fn_cash_in_users_games('Love in a mist'); -- 8585.00

SELECT fn_cash_in_users_games('Delphinium Pacific Giant'); -- 6921.00
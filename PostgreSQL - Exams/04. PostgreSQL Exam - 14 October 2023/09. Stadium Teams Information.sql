DROP FUNCTION IF EXISTS fn_stadium_team_name("stadium_name" VARCHAR(30));
--
CREATE OR REPLACE FUNCTION fn_stadium_team_name("stadium_name" VARCHAR(30))
    RETURNS TABLE
            (
                "team_name" VARCHAR(45)
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT DISTINCT t."name"
        FROM "teams" AS t
                 INNER JOIN "stadiums" AS s
                            ON s."id" = t."stadium_id"
        WHERE s."name" = "stadium_name"
        ORDER BY t."name" ASC;
END;
$$
    LANGUAGE plpgsql;
--
SELECT fn_stadium_team_name('BlogXS');
--  fn_stadium_team_name
-- ----------------------
--  Fiveclub

SELECT fn_stadium_team_name('Quaxo');
--  fn_stadium_team_name
-- ----------------------
--  Divavu
--  Photobug

SELECT fn_stadium_team_name('Jaxworks');
--  fn_stadium_team_name
-- ----------------------
--  Ailane
--  Feedmix
--  Jabbercube
--  Skipstorm
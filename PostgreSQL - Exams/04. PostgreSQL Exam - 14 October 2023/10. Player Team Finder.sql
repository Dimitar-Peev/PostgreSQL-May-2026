DROP PROCEDURE IF EXISTS sp_players_team_name;
--
CREATE OR REPLACE PROCEDURE sp_players_team_name("player_name" VARCHAR(50), OUT "team_name" VARCHAR(45))
AS
$$
BEGIN
    SELECT t."name"
    INTO "team_name"
    FROM "players" AS p
             LEFT JOIN "teams" AS t
                       ON t."id" = p."team_id"
    WHERE CONCAT(p."first_name", ' ', p."last_name") = "player_name";

    IF "team_name" IS NULL THEN
        "team_name" := 'The player currently has no team';
    END IF;
END;
$$
    LANGUAGE plpgsql;
--
CALL sp_players_team_name('Thor Serrels', ''); -- Ntags
CALL sp_players_team_name('Walther Olenchenko', ''); -- The player currently has no team
CALL sp_players_team_name('Isaak Duncombe', ''); --	Thoughtstorm

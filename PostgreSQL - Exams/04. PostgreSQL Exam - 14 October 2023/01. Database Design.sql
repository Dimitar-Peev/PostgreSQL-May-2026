DROP DATABASE IF EXISTS "soccer_talent_db";

CREATE DATABASE "soccer_talent_db";

CREATE TABLE "towns"
(
    "id"   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "name" VARCHAR(45) NOT NULL
);

CREATE TABLE "stadiums"
(
    "id"       INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "name"     VARCHAR(45) NOT NULL,
    "capacity" INT         NOT NULL,
    "town_id"  INT         NOT NULL,

    CONSTRAINT check_stadiums_capacity_is_greater_than_zero
        CHECK ("capacity" > 0),

    CONSTRAINT fk_stadiums_towns
        FOREIGN KEY ("town_id")
            REFERENCES "towns" ("id")
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

CREATE TABLE "teams"
(
    "id"          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "name"        VARCHAR(45)   NOT NULL,
    "established" DATE          NOT NULL,
    "fan_base"    INT DEFAULT 0 NOT NULL,
    "stadium_id"  INT           NOT NULL,

    CONSTRAINT check_teams_fan_base_is_positive
        CHECK ("fan_base" >= 0),

    CONSTRAINT fk_teams_stadiums
        FOREIGN KEY ("stadium_id")
            REFERENCES "stadiums" ("id")
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

CREATE TABLE "coaches"
(
    "id"          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "first_name"  VARCHAR(10)              NOT NULL,
    "last_name"   VARCHAR(20)              NOT NULL,
    "salary"      NUMERIC(10, 2) DEFAULT 0 NOT NULL,
    "coach_level" INT            DEFAULT 0 NOT NULL,

    CONSTRAINT check_coaches_salary_is_positive
        CHECK ("salary" >= 0),

    CONSTRAINT check_coaches_coach_level_is_positive
        CHECK ("coach_level" >= 0)
);

CREATE TABLE "skills_data"
(
    "id"        INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "dribbling" INT DEFAULT 0 NOT NULL,
    "pace"      INT DEFAULT 0 NOT NULL,
    "passing"   INT DEFAULT 0 NOT NULL,
    "shooting"  INT DEFAULT 0 NOT NULL,
    "speed"     INT DEFAULT 0 NOT NULL,
    "strength"  INT DEFAULT 0 NOT NULL,

    CONSTRAINT check_skills_data_dribbling_is_positive
        CHECK ("dribbling" >= 0),

    CONSTRAINT check_skills_data_pace_is_positive
        CHECK ("pace" >= 0),

    CONSTRAINT check_skills_data_passing_is_positive
        CHECK ("passing" >= 0),

    CONSTRAINT check_skills_data_shooting_is_positive
        CHECK ("shooting" >= 0),

    CONSTRAINT check_skills_data_speed_is_positive
        CHECK ("speed" >= 0),

    CONSTRAINT check_skills_data_strength_is_positive
        CHECK ("strength" >= 0)
);

CREATE TABLE "players"
(
    "id"             INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "first_name"     VARCHAR(10)              NOT NULL,
    "last_name"      VARCHAR(20)              NOT NULL,
    "age"            INT            DEFAULT 0 NOT NULL,
    "position"       CHAR(1)                  NOT NULL,
    "salary"         NUMERIC(10, 2) DEFAULT 0 NOT NULL,
    "hire_date"      TIMESTAMP,
    "skills_data_id" INT                      NOT NULL,
    "team_id"        INT,

    CONSTRAINT check_players_age_is_positive
        CHECK ("age" >= 0),

    CONSTRAINT check_players_salary_is_positive
        CHECK ("salary" >= 0),

    CONSTRAINT fk_players_skills_data
        FOREIGN KEY ("skills_data_id")
            REFERENCES "skills_data" ("id")
            ON DELETE CASCADE
            ON UPDATE CASCADE,

    CONSTRAINT fk_players_teams
        FOREIGN KEY ("team_id")
            REFERENCES "teams" ("id")
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

CREATE TABLE "players_coaches"
(
    "player_id" INT NOT NULL,
    "coach_id"  INT NOT NULL,

    CONSTRAINT fk_players_coaches_players
        FOREIGN KEY ("player_id")
            REFERENCES "players" ("id")
            ON DELETE CASCADE
            ON UPDATE CASCADE,

    CONSTRAINT fk_players_coaches_coaches
        FOREIGN KEY ("coach_id")
            REFERENCES "coaches" ("id")
            ON DELETE CASCADE
            ON UPDATE CASCADE
);
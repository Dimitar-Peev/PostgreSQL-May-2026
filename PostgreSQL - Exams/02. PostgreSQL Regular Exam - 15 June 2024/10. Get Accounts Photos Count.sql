DROP FUNCTION IF EXISTS udf_accounts_photos_count("account_username" VARCHAR(30));
--
CREATE OR REPLACE FUNCTION udf_accounts_photos_count("account_username" VARCHAR(30))
    RETURNS INTEGER AS
$$
DECLARE
    "photos_count" INTEGER;
BEGIN
    "photos_count" := (SELECT COUNT(ap."photo_id")
                       FROM "accounts" AS a
                                INNER JOIN "accounts_photos" AS ap
                                           ON a."id" = ap."account_id"
                       WHERE a."username" = "account_username");

    RETURN "photos_count";
END;
$$
    LANGUAGE plpgsql;
--
SELECT udf_accounts_photos_count('ssantryd') AS photos_count; -- 2
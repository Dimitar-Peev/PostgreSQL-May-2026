CREATE OR REPLACE PROCEDURE udp_modify_account("address_street" VARCHAR(30), "address_town" VARCHAR(30))
AS
$$
DECLARE
    "account_id" INTEGER;
BEGIN
    "account_id" := (SELECT a."id"
                     FROM "addresses" AS ad
                              INNER JOIN "accounts" AS a
                                         ON ad."account_id" = a."id"
                     WHERE ad."street" = "address_street"
                       AND ad."town" = "address_town");

    IF "account_id" IS NOT NULL THEN
        UPDATE "accounts"
        SET "job_title" = '(Remote) ' || "job_title"
        WHERE "id" = "account_id";
    END IF;
END;
$$
    LANGUAGE plpgsql;
--
CALL udp_modify_account('97 Valley Edge Parkway', 'Nonexistent');
SELECT a.username, a.gender, a.job_title
FROM accounts AS a
WHERE a.job_title ILIKE '(Remote)%';

CALL udp_modify_account('97 Valley Edge Parkway', 'Divinópolis');
SELECT a.username, a.gender, a.job_title
FROM accounts AS a
WHERE a.job_title ILIKE '(Remote)%';


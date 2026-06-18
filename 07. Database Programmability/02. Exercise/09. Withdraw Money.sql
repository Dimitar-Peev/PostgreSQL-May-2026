DROP PROCEDURE IF EXISTS sp_withdraw_money;
--
CREATE OR REPLACE PROCEDURE sp_withdraw_money("account_id" INT, "money_amount" NUMERIC(10, 4))
AS
$$
DECLARE
    "current_balance" NUMERIC;
BEGIN
    "current_balance" := (SELECT "balance"
                          FROM "accounts"
                          WHERE "id" = "account_id");

    IF "current_balance" - "money_amount" < 0 THEN
        RAISE NOTICE 'Insufficient balance to withdraw %', "money_amount";
    ELSE
        UPDATE "accounts"
        SET "balance" = "balance" - "money_amount"
        WHERE "id" = "account_id";
    END IF;
END;
$$
    LANGUAGE plpgsql;
--
SELECT "id", "account_holder_id", "balance"
FROM "accounts"
WHERE "id" = 3;

CALL sp_withdraw_money(3, 5050.7500);

SELECT "id", "account_holder_id", "balance"
FROM "accounts"
WHERE "id" = 3;

DROP PROCEDURE IF EXISTS sp_deposit_money;
--
CREATE OR REPLACE PROCEDURE sp_deposit_money("account_id" INT, "money_amount" NUMERIC(4))
AS
$$
BEGIN
    UPDATE "accounts"
    SET "balance" = "balance" + "money_amount"
    WHERE "id" = "account_id";
END;
$$
    LANGUAGE plpgsql;
--
CALL sp_deposit_money(1, 200); -- 323.1200
CALL sp_deposit_money(10, 500); -- 1043.3000
CALL sp_deposit_money(14, 1000); -- 1001.2300
DROP PROCEDURE IF EXISTS sp_retrieving_holders_with_balance_higher_than;
--
CREATE OR REPLACE PROCEDURE sp_retrieving_holders_with_balance_higher_than("searched_balance" NUMERIC)
AS
$$
DECLARE
    "holder_info" RECORD;
BEGIN
    FOR "holder_info" IN
        SELECT CONCAT(ah."first_name", ' ', ah."last_name") AS "full_name",
               SUM(a."balance")                             AS "total_balance"
        FROM "account_holders" AS ah
                 INNER JOIN "accounts" AS a
                            ON ah."id" = a."account_holder_id"
        GROUP BY "full_name"
        HAVING SUM(a."balance") > "searched_balance"
        ORDER BY "full_name"
        LOOP
            RAISE NOTICE '% - %', holder_info.full_name, holder_info.total_balance;
        END LOOP;
END;
$$
    LANGUAGE plpgsql;
--
CALL sp_retrieving_holders_with_balance_higher_than(200000);
-- Monika Miteva - 565649.2000
-- Petar Kirilov - 245656.2300
-- Petko Petkov Junior - 6541492.4800
-- Susan Cane - 5585551.2400
-- Zlatko Zlatyov - 1112627.9000
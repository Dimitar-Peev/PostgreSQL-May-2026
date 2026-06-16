DROP FUNCTION IF EXISTS fn_calculate_future_value(NUMERIC, NUMERIC, INT);
--
CREATE FUNCTION fn_calculate_future_value("initial_sum" NUMERIC, "yearly_interest_rate" NUMERIC, "number_of_years" INT)
    RETURNS NUMERIC AS
$$
BEGIN
    RETURN TRUNC("initial_sum" * POWER(1 + "yearly_interest_rate", "number_of_years"), 4);
END;
$$
    LANGUAGE plpgsql;
--
SELECT fn_calculate_future_value(1000, 0.1, 5); -- 1610.5100

SELECT fn_calculate_future_value(2500, 0.30, 2); -- 4225.0000

SELECT fn_calculate_future_value(500, 0.25, 10); -- 4656.6128
DROP FUNCTION IF EXISTS fn_is_word_comprised;
--
CREATE OR REPLACE FUNCTION fn_is_word_comprised("set_of_letters" VARCHAR, "word" VARCHAR)
    RETURNS BOOLEAN AS
$$
DECLARE
    "i"      INT;
    "letter" CHAR(1);
BEGIN
    FOR "i" IN 1..LENGTH("word")
        LOOP
            letter := SUBSTRING(LOWER("word"), "i", 1);

            IF POSITION(LOWER("letter") IN LOWER("set_of_letters")) = 0 THEN
                RETURN FALSE;
            END IF;

        END LOOP;

    RETURN TRUE;
END;
$$
    LANGUAGE plpgsql;
--
SELECT fn_is_word_comprised('ois tmiah%f', 'halves'); -- false

SELECT fn_is_word_comprised('ois tmiah%f', 'Sofia'); -- true
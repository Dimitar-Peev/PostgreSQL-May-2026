ALTER TABLE "continents"
    ADD CONSTRAINT unique_continent_code
        UNIQUE ("continent_code");

ALTER TABLE "countries"
    ADD CONSTRAINT unique_country_code
        UNIQUE ("country_code");

ALTER TABLE "currencies"
    ADD CONSTRAINT unique_currency_code
        UNIQUE ("currency_code");
--
ALTER TABLE "countries"

    ADD CONSTRAINT fk_countries_continents
        FOREIGN KEY ("continent_code")
            REFERENCES "continents" ("continent_code")
            ON DELETE CASCADE,

    ADD CONSTRAINT fk_countries_currencies
        FOREIGN KEY ("currency_code")
            REFERENCES "currencies" ("currency_code")
            ON DELETE CASCADE;
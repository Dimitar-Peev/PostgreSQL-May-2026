DROP DATABASE IF EXISTS "electronics_store ";
--
CREATE DATABASE "electronics_store ";
--
CREATE TABLE "brands"
(
    "id"   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "name" VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE "classifications"
(
    "id"   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "name" VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE "customers"
(
    "id"           INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "first_name"   VARCHAR(30)  NOT NULL,
    "last_name"    VARCHAR(30)  NOT NULL,
    "address"      VARCHAR(150) NOT NULL,
    "phone"        VARCHAR(30)  NOT NULL UNIQUE,
    "loyalty_card" BOOLEAN      NOT NULL DEFAULT FALSE
);

CREATE TABLE "items"
(
    "id"                INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "name"              VARCHAR(50)    NOT NULL,
    "quantity"          INT            NOT NULL,
    "price"             DECIMAL(12, 2) NOT NULL,
    "description"       TEXT,
    "brand_id"          INT            NOT NULL,
    "classification_id" INT            NOT NULL,

    CONSTRAINT check_items_quantity_is_positive
        CHECK ("quantity" >= 0),

    CONSTRAINT check_items_price_is_positive
        CHECK ("price" > 0.00),

    CONSTRAINT fk_items_brands
        FOREIGN KEY ("brand_id")
            REFERENCES "brands" ("id")
            ON DELETE CASCADE
            ON UPDATE CASCADE,

    CONSTRAINT fk_items_classifications
        FOREIGN KEY ("classification_id")
            REFERENCES "classifications" ("id")
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

CREATE TABLE "orders"
(
    "id"          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "created_at"  TIMESTAMP NOT NULL DEFAULT NOW(),
    "customer_id" INT       NOT NULL,

    CONSTRAINT fk_orders_customers
        FOREIGN KEY ("customer_id")
            REFERENCES "customers" ("id")
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

CREATE TABLE "reviews"
(
    "customer_id" INT           NOT NULL,
    "item_id"     INT           NOT NULL,
    "created_at"  TIMESTAMP     NOT NULL DEFAULT NOW(),
    "rating"      DECIMAL(3, 1) NOT NULL DEFAULT 0.0,

    CONSTRAINT check_reviews_rating_is_under_or_equal_to_ten
        CHECK ("rating" <= 10.0),

    CONSTRAINT pk_reviews
        PRIMARY KEY ("customer_id", "item_id"),

    CONSTRAINT fk_reviews_customers
        FOREIGN KEY ("customer_id")
            REFERENCES "customers" ("id")
            ON DELETE CASCADE
            ON UPDATE CASCADE,

    CONSTRAINT fk_reviews_items
        FOREIGN KEY ("item_id")
            REFERENCES "items" ("id")
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

CREATE TABLE "orders_items"
(
    "order_id" INT NOT NULL,
    "item_id"  INT NOT NULL,
    "quantity" INT NOT NULL,

    CONSTRAINT check_orders_items_quantity_is_positive
        CHECK ("quantity" >= 0),

    CONSTRAINT pk_orders_items
        PRIMARY KEY ("order_id", "item_id"),

    CONSTRAINT fk_orders_items_orders
        FOREIGN KEY ("order_id")
            REFERENCES "orders" ("id")
            ON DELETE CASCADE
            ON UPDATE CASCADE,

    CONSTRAINT fk_orders_items_items
        FOREIGN KEY ("item_id")
            REFERENCES "items" ("id")
            ON DELETE CASCADE
            ON UPDATE CASCADE
);
/* DATA PREPARATION
   Define the schema for 'The Fuzzy Factory' e-commerce database.
*/

-- 1. Table Creation

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    created_at TIMESTAMP WITHOUT TIME ZONE,
    product_name VARCHAR(255) NOT NULL
);

CREATE TABLE website_sessions (
    website_session_id INTEGER PRIMARY KEY,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    user_id INTEGER,
    is_repeat_session INTEGER,
    utm_source VARCHAR(255),
    utm_campaign VARCHAR(255),
    utm_content VARCHAR(255),
    device_type VARCHAR(50),
    http_referer VARCHAR(500)
);

CREATE TABLE website_pageviews (
    website_pageview_id INTEGER PRIMARY KEY,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    website_session_id INTEGER REFERENCES website_sessions(website_session_id),
    pageview_url VARCHAR(255)
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    website_session_id INTEGER REFERENCES website_sessions(website_session_id),
    user_id INTEGER,
    primary_product_id INTEGER REFERENCES products(product_id),
    items_purchased INTEGER,
    price_usd NUMERIC(10, 2),
    cogs_usd NUMERIC(10, 2)
);

CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    order_id INTEGER REFERENCES orders(order_id),
    product_id INTEGER REFERENCES products(product_id),
    is_primary_item INTEGER,
    price_usd NUMERIC(10, 2),
    cogs_usd NUMERIC(10, 2)
);

CREATE TABLE order_item_refunds (
    order_item_refund_id INTEGER PRIMARY KEY,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    order_item_id INTEGER REFERENCES order_items(order_item_id),
    order_id INTEGER REFERENCES orders(order_id),
    refund_amount_usd NUMERIC(10, 2)
);

-- 2. Inserting Data
-- Using \COPY for high-performance bulk loading from CSV files.

\COPY products FROM 'C:\Users\MrJes\OneDrive\Data Analysis\Projects\Toy Store E-Commerce\products.csv' DELIMITER ',' CSV HEADER;

\COPY website_sessions FROM 'C:\Users\MrJes\OneDrive\Data Analysis\Projects\Toy Store E-Commerce\website_sessions.csv' DELIMITER ',' CSV HEADER;

\COPY website_pageviews FROM 'C:\Users\MrJes\OneDrive\Data Analysis\Projects\Toy Store E-Commerce\website_pageviews.csv' DELIMITER ',' CSV HEADER;

\COPY orders FROM 'C:\Users\MrJes\OneDrive\Data Analysis\Projects\Toy Store E-Commerce\orders.csv' DELIMITER ',' CSV HEADER;

\COPY order_items FROM 'C:\Users\MrJes\OneDrive\Data Analysis\Projects\Toy Store E-Commerce\order_items.csv' DELIMITER ',' CSV HEADER;

\COPY order_item_refunds FROM 'C:\Users\MrJes\OneDrive\Data Analysis\Projects\Toy Store E-Commerce\order_item_refunds.csv' DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS products;

CREATE TABLE products (
product_id SERIAL PRIMARY KEY,
category_id INT,
price NUMERIC,
stock_quantity INT
);

INSERT INTO products (category_id, price, stock_quantity)
SELECT
(RANDOM()*10)::INT,
(RANDOM()*1000)::INT,
(RANDOM()*100)::INT
FROM generate_series(1, 100000);

CREATE INDEX idx_products_category_id
ON products(category_id);

CLUSTER products USING idx_products_category_id;

CREATE INDEX idx_products_price
ON products(price);

EXPLAIN ANALYZE
SELECT * FROM products
WHERE category_id = 5
ORDER BY price;

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
order_id SERIAL PRIMARY KEY,
customer_id INT,
order_date DATE,
total_amount NUMERIC
);

INSERT INTO orders (customer_id, order_date, total_amount)
SELECT (RANDOM()*1000)::INT, CURRENT_DATE, (RANDOM()*1000)::INT
FROM generate_series(1, 100000);

EXPLAIN ANALYZE
SELECT * FROM orders WHERE customer_id = 10;

CREATE INDEX idx_orders_customer_id
ON orders(customer_id);

EXPLAIN ANALYZE
SELECT * FROM orders WHERE customer_id = 10;

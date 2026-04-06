DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
sale_id SERIAL PRIMARY KEY,
customer_id INT,
product_id INT,
sale_date DATE,
amount NUMERIC
);

INSERT INTO sales (customer_id, product_id, sale_date, amount)
VALUES
(1, 101, CURRENT_DATE, 500),
(1, 102, CURRENT_DATE, 700),
(2, 103, CURRENT_DATE, 300),
(2, 104, CURRENT_DATE, 400),
(3, 105, CURRENT_DATE, 1500);

CREATE OR REPLACE VIEW CustomerSales AS
SELECT
customer_id,
SUM(amount) AS total_amount
FROM sales
GROUP BY customer_id;

SELECT * FROM CustomerSales WHERE total_amount > 1000;

UPDATE CustomerSales
SET total_amount = 2000
WHERE customer_id = 1;

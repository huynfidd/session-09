DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
customer_id SERIAL PRIMARY KEY,
name VARCHAR(100),
email VARCHAR(100)
);

CREATE TABLE orders (
order_id SERIAL PRIMARY KEY,
customer_id INT,
amount NUMERIC,
order_date DATE DEFAULT CURRENT_DATE
);

INSERT INTO customers (name, email)
VALUES
('Alice', '[alice@example.com](mailto:alice@example.com)'),
('Bob', '[bob@example.com](mailto:bob@example.com)');

CREATE OR REPLACE PROCEDURE add_order(
IN p_customer_id INT,
IN p_amount NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE cnt INT;
BEGIN
SELECT COUNT(*) INTO cnt
FROM customers
WHERE customer_id = p_customer_id;

```
IF cnt = 0 THEN
    RAISE EXCEPTION 'Khách hàng không tồn tại';
END IF;

INSERT INTO orders(customer_id, amount)
VALUES (p_customer_id, p_amount);
```

END;
$$;

CALL add_order(1, 500);
CALL add_order(5, 300);

SELECT * FROM orders;

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
customer_id SERIAL PRIMARY KEY,
name VARCHAR(100),
total_spent NUMERIC DEFAULT 0
);

CREATE TABLE orders (
order_id SERIAL PRIMARY KEY,
customer_id INT,
total_amount NUMERIC
);

INSERT INTO customers (name, total_spent)
VALUES
('Alice', 0),
('Bob', 1000);

CREATE OR REPLACE PROCEDURE add_order_and_update_customer(
IN p_customer_id INT,
IN p_amount NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE current_total NUMERIC;
BEGIN
SELECT total_spent INTO current_total
FROM customers
WHERE customer_id = p_customer_id;

```
IF current_total IS NULL THEN
    RAISE EXCEPTION 'Khách hàng không tồn tại';
END IF;

BEGIN
    INSERT INTO orders(customer_id, total_amount)
    VALUES (p_customer_id, p_amount);

    UPDATE customers
    SET total_spent = current_total + p_amount
    WHERE customer_id = p_customer_id;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Thêm đơn hàng thất bại';
END;
```

END;
$$;

CALL add_order_and_update_customer(1, 500);
CALL add_order_and_update_customer(5, 300);

SELECT * FROM customers;
SELECT * FROM orders;

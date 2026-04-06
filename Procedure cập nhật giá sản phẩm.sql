DROP TABLE IF EXISTS products;

CREATE TABLE products (
product_id SERIAL PRIMARY KEY,
name VARCHAR(100),
price NUMERIC,
category_id INT
);

INSERT INTO products (name, price, category_id)
VALUES
('Product A', 1000, 1),
('Product B', 2000, 1),
('Product C', 1500, 2),
('Product D', 3000, 2);

CREATE OR REPLACE PROCEDURE update_product_price(
IN p_category_id INT,
IN p_increase_percent NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE rec RECORD;
DECLARE new_price NUMERIC;
BEGIN
FOR rec IN
SELECT product_id, price
FROM products
WHERE category_id = p_category_id
LOOP
new_price := rec.price + (rec.price * p_increase_percent / 100);

```
    UPDATE products
    SET price = new_price
    WHERE product_id = rec.product_id;
END LOOP;
```

END;
$$;

CALL update_product_price(1, 10);

SELECT * FROM products;

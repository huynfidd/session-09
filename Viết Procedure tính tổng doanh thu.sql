DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
sale_id SERIAL PRIMARY KEY,
customer_id INT,
amount NUMERIC,
sale_date DATE
);

INSERT INTO sales (customer_id, amount, sale_date)
VALUES
(1, 500, '2024-01-01'),
(2, 700, '2024-01-05'),
(1, 300, '2024-02-01'),
(3, 1000, '2024-02-10');

CREATE OR REPLACE PROCEDURE calculate_total_sales(
IN start_date DATE,
IN end_date DATE,
OUT total NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
SELECT SUM(amount)
INTO total
FROM sales
WHERE sale_date BETWEEN start_date AND end_date;

```
IF total IS NULL THEN
    total := 0;
END IF;
```

END;
$$;

CALL calculate_total_sales('2024-01-01', '2024-01-31', NULL);
CALL calculate_total_sales('2024-01-01', '2024-12-31', NULL);

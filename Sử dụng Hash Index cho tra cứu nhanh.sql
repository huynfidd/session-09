DROP TABLE IF EXISTS users;

CREATE TABLE users (
user_id SERIAL PRIMARY KEY,
email VARCHAR(100),
username VARCHAR(100)
);

INSERT INTO users (email, username)
SELECT
'user' || i || '@example.com',
'user' || i
FROM generate_series(1, 100000) AS s(i);

EXPLAIN ANALYZE
SELECT * FROM users WHERE email = '[user500@example.com](mailto:user500@example.com)';

CREATE INDEX idx_users_email_hash
ON users USING HASH (email);

EXPLAIN ANALYZE
SELECT * FROM users WHERE email = '[user500@example.com](mailto:user500@example.com)';

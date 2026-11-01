CREATE TABLE lab16_accounts (
    account_id SERIAL PRIMARY KEY,
    owner_name VARCHAR(100) NOT NULL,
    balance NUMERIC(10,2) NOT NULL CHECK (balance >= 0)
);

INSERT INTO lab16_accounts (owner_name, balance) VALUES
    ('Alice', 1000.00), ('Bob', 500.00);

SELECT * FROM lab16_accounts ORDER BY account_id;

BEGIN;
UPDATE lab16_accounts SET balance = balance - 200 WHERE account_id = 1;
UPDATE lab16_accounts SET balance = balance + 200 WHERE account_id = 2;
SELECT * FROM lab16_accounts ORDER BY account_id;
ROLLBACK;
SELECT * FROM lab16_accounts ORDER BY account_id;

BEGIN;
UPDATE lab16_accounts SET balance = balance - 200 WHERE account_id = 1;
UPDATE lab16_accounts SET balance = balance + 200 WHERE account_id = 2;
COMMIT;
SELECT * FROM lab16_accounts ORDER BY account_id;
SELECT SUM(balance) AS total_balance FROM lab16_accounts;

BEGIN;
SAVEPOINT before_bonus;
UPDATE lab16_accounts SET balance = balance + 50 WHERE account_id = 2;
SELECT * FROM lab16_accounts ORDER BY account_id;
ROLLBACK TO SAVEPOINT before_bonus;
COMMIT;
SELECT * FROM lab16_accounts ORDER BY account_id;

BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SHOW transaction_isolation;
SELECT SUM(balance) AS total_balance FROM lab16_accounts;
COMMIT;

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SHOW transaction_isolation;
SELECT SUM(balance) AS total_balance FROM lab16_accounts;
COMMIT;


DROP DATABASE IF EXISTS session_14_bt1;
CREATE DATABASE session_14_bt1;
USE session_14_bt1;

CREATE TABLE accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    account_name VARCHAR(50),
    balance DECIMAL(10, 2)
);

INSERT INTO accounts (account_name, balance) VALUES 
('Nguyễn Văn An', 1000.00),
('Trần Thị Bảy', 500.00);

SELECT * FROM accounts;


DELIMITER //

DROP PROCEDURE IF EXISTS TransferMoney //

CREATE PROCEDURE TransferMoney(
    IN p_from_account INT,
    IN p_to_account INT,
    IN p_amount DECIMAL(10,2)
)
BEGIN
    DECLARE v_sender_balance DECIMAL(10,2);

    START TRANSACTION;

    SELECT balance INTO v_sender_balance 
    FROM accounts 
    WHERE account_id = p_from_account 
    FOR UPDATE;

    IF v_sender_balance >= p_amount THEN
        UPDATE accounts 
        SET balance = balance - p_amount 
        WHERE account_id = p_from_account;

        UPDATE accounts 
        SET balance = balance + p_amount 
        WHERE account_id = p_to_account;

        COMMIT;
        
        SELECT 'Giao dịch thành công' AS message;
    ELSE
        ROLLBACK;
        
        SELECT 'Giao dịch thất bại: Số dư không đủ' AS message;
    END IF;
END //

DELIMITER ;


CALL TransferMoney(1, 2, 200.00);

SELECT * FROM accounts;

CALL TransferMoney(1, 2, 5000.00);

SELECT * FROM accounts;
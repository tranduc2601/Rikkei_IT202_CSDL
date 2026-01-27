DROP DATABASE IF EXISTS session_14_bt3;
CREATE DATABASE session_14_bt3;
USE session_14_bt3;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(50),
    salary DECIMAL(10, 2)
);

CREATE TABLE company_funds (
    fund_id INT PRIMARY KEY AUTO_INCREMENT,
    balance DECIMAL(15, 2),
    bank_details VARCHAR(255)
);

CREATE TABLE payroll (
    payroll_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    amount DECIMAL(10, 2),
    pay_date DATETIME,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

INSERT INTO company_funds (balance, bank_details) VALUES (50000000, 'Vietcombank');
INSERT INTO employees (emp_name, salary) VALUES ('Nguyen Van A', 10000000);

DELIMITER //

CREATE PROCEDURE TransferSalary(IN p_emp_id INT)
BEGIN
    DECLARE v_salary DECIMAL(10,2);
    DECLARE v_balance DECIMAL(15,2);
    DECLARE v_bank_status INT DEFAULT 1;

    START TRANSACTION;

    SELECT salary INTO v_salary FROM employees WHERE emp_id = p_emp_id;

    SELECT balance INTO v_balance FROM company_funds WHERE fund_id = 1 FOR UPDATE;

    IF v_balance >= v_salary THEN
        UPDATE company_funds SET balance = balance - v_salary WHERE fund_id = 1;

        INSERT INTO payroll (emp_id, amount, pay_date) VALUES (p_emp_id, v_salary, NOW());

        IF v_bank_status = 1 THEN
            COMMIT;
        ELSE
            ROLLBACK;
        END IF;
    ELSE
        ROLLBACK;
    END IF;
END //

DELIMITER ;

CALL TransferSalary(1);

SELECT * FROM company_funds;
SELECT * FROM payroll;
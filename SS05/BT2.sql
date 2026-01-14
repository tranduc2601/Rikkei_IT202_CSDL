
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    city VARCHAR(255),
    status ENUM('active', 'inactive')
);

INSERT INTO customers (full_name, email, city, status) 
VALUES 
    ('Nguyễn Văn An', 'an@gmail.com', 'TP.HCM', 'active'),
    ('Trần Thị Bình', 'binh@gmail.com', 'Hà Nội', 'active'),
    ('Lê Văn Cường', 'cuong@gmail.com', 'Hà Nội', 'inactive'), 
    ('Phạm Thị Dung', 'dung@gmail.com', 'Đà Nẵng', 'active'),
    ('Đỗ Văn Em', 'em@gmail.com', 'TP.HCM', 'inactive');

SELECT * FROM customers;

SELECT * FROM customers 
WHERE city = 'TP.HCM';

SELECT * FROM customers 
WHERE status = 'active' AND city = 'Hà Nội';
CREATE DATABASE IF NOT EXISTS ShoppingDB;
USE ShoppingDB;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    city VARCHAR(255)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status ENUM('pending', 'completed', 'cancelled'),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (full_name, city) VALUES 
('Nguyễn Văn An', 'Hà Nội'),
('Trần Thị Bích', 'TP.HCM'),
('Lê Văn Cường', 'Đà Nẵng');

INSERT INTO orders (customer_id, order_date, status) VALUES 
(1, '2024-01-10', 'completed'),
(1, '2024-01-12', 'pending'),
(2, '2024-01-15', 'completed'),
(2, '2024-01-20', 'cancelled');

SELECT 
    o.order_id, 
    c.full_name, 
    o.order_date, 
    o.status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

SELECT 
    c.full_name, 
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;

SELECT 
    c.full_name, 
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;
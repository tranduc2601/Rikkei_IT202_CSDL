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
-- 1. Bổ sung cột total_amount vào bảng orders
ALTER TABLE orders
ADD COLUMN total_amount DECIMAL(10, 2);

-- 2. Cập nhật dữ liệu mẫu (để có số liệu mà tính toán)
UPDATE orders SET total_amount = 1500000 WHERE order_id = 1; -- Đơn của An
UPDATE orders SET total_amount = 500000  WHERE order_id = 2; -- Đơn của An
UPDATE orders SET total_amount = 2000000 WHERE order_id = 3; -- Đơn của Bích
UPDATE orders SET total_amount = 0       WHERE order_id = 4; -- Đơn hủy

-- 3. Truy vấn: Tính tổng số tiền mỗi khách hàng đã mua (JOIN + SUM + GROUP BY)
SELECT 
    c.customer_id,
    c.full_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255),
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
('Nguyen Van A', 'Ha Noi'),
('Tran Thi B', 'Ho Chi Minh'),
('Le Van C', 'Da Nang'),
('Pham Thi D', 'Can Tho'),
('Hoang Van E', 'Hai Phong');

INSERT INTO orders (customer_id, order_date, status) VALUES 
(1, '2023-11-01', 'completed'),
(1, '2023-11-02', 'pending'),
(2, '2023-11-03', 'completed'),
(3, '2023-11-04', 'cancelled'),
(3, '2023-11-05', 'completed');

SELECT 
    o.order_id, 
    o.order_date, 
    o.status, 
    c.full_name 
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

SELECT 
    c.full_name, 
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;

SELECT 
    c.full_name, 
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
HAVING COUNT(o.order_id) >= 1;
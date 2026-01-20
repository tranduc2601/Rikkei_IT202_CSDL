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
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (full_name, city) VALUES 
('Nguyen Van A', 'Ha Noi'),
('Tran Thi B', 'HCM'),
('Le Van C', 'Da Nang');

INSERT INTO orders (customer_id, order_date, status) VALUES 
(1, '2023-10-01', 'completed'),
(1, '2023-10-02', 'completed'),
(2, '2023-10-03', 'completed'),
(3, '2023-10-04', 'completed'),
(3, '2023-10-05', 'completed');

ALTER TABLE orders ADD COLUMN total_amount DECIMAL(10, 2);

UPDATE orders SET total_amount = 1500000 WHERE order_id = 1;
UPDATE orders SET total_amount = 2000000 WHERE order_id = 2;
UPDATE orders SET total_amount = 5500000 WHERE order_id = 3;
UPDATE orders SET total_amount = 1000000 WHERE order_id = 4;
UPDATE orders SET total_amount = 3000000 WHERE order_id = 5;

SELECT 
    c.full_name, 
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;

SELECT 
    c.full_name, 
    MAX(o.total_amount) AS max_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;

SELECT 
    c.full_name, 
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY total_spent DESC;
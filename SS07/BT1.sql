DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(15, 2)
);

INSERT INTO orders (order_date, amount) VALUES 
('2023-10-01', 5000000),
('2023-10-01', 6000000),
('2023-10-02', 2000000),
('2023-10-02', 1000000),
('2023-10-03', 12000000),
('2023-10-03', 500000);

SELECT 
    order_date, 
    SUM(amount) AS total_revenue
FROM orders
GROUP BY order_date;

SELECT 
    order_date, 
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_date;

SELECT 
    order_date, 
    SUM(amount) AS total_revenue
FROM orders
GROUP BY order_date
HAVING SUM(amount) > 10000000;
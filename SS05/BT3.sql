DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    total_amount DECIMAL(10,2),
    order_date DATE,
    status ENUM('pending', 'completed', 'cancelled')
);

INSERT INTO orders (customer_id, total_amount, order_date, status) 
VALUES 
    (1, 1500000, '2024-01-01', 'pending'),
    (2, 6000000, '2024-01-02', 'completed'), -- Đơn lớn > 5tr
    (3, 200000, '2024-01-03', 'cancelled'),
    (1, 5500000, '2024-01-04', 'completed'), -- Đơn lớn > 5tr
    (4, 9000000, '2024-01-05', 'completed'), -- Đơn lớn nhất
    (2, 120000, '2024-01-06', 'pending'),
    (5, 7500000, '2024-01-07', 'completed');  -- Đơn mới nhất

SELECT * FROM orders 
WHERE status = 'completed';

SELECT * FROM orders 
WHERE total_amount > 5000000;

SELECT * FROM orders 
ORDER BY order_date DESC 
LIMIT 5;

SELECT * FROM orders 
WHERE status = 'completed' 
ORDER BY total_amount DESC;
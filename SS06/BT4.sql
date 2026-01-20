DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS orders;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    price DECIMAL(10, 2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products (product_id, product_name, price) VALUES 
(1, 'Laptop', 15000000),
(2, 'Mouse', 200000),
(3, 'Keyboard', 500000),
(4, 'Monitor', 3000000),
(5, 'Headphone', 1000000);

INSERT INTO orders (order_id) VALUES (1), (2), (3), (4), (5);

INSERT INTO order_items (order_id, product_id, quantity) VALUES 
(1, 1, 1),
(1, 2, 2),
(2, 3, 5),
(3, 4, 2),
(4, 5, 10);

SELECT 
    p.product_name, 
    SUM(oi.quantity) AS total_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name;

SELECT 
    p.product_name, 
    SUM(oi.quantity * p.price) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name;

SELECT 
    p.product_name, 
    SUM(oi.quantity * p.price) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity * p.price) > 5000000;
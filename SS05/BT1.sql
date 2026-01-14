
DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2),
    stock INT,
    status ENUM('active', 'inactive')
);

INSERT INTO products (product_name, price, stock, status) 
VALUES 
    ('Laptop Dell XPS', 25000000, 10, 'active'),
    ('Chuột không dây', 150000, 50, 'active'),
    ('Bàn phím cơ cũ', 500000, 0, 'inactive'), -- Hàng ngừng bán
    ('Iphone 15 Pro Max', 30000000, 5, 'active'),
    ('Tai nghe Bluetooth', 800000, 20, 'active');

SELECT * FROM products;

SELECT * FROM products 
WHERE status = 'active';

SELECT * FROM products 
WHERE price > 1000000;

SELECT * FROM products 
WHERE status = 'active' 
ORDER BY price ASC;
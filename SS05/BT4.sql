DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2),
    sold_quantity INT, -- Số lượng đã bán (Cột mới)
    status ENUM('active', 'inactive')
);

INSERT INTO products (product_name, price, sold_quantity, status) 
VALUES 
    ('Sản phẩm A', 150000, 100, 'active'),
    ('Sản phẩm B', 500000, 90, 'active'), 
    ('Sản phẩm C', 2500000, 85, 'active'), 
    ('Sản phẩm D', 100000, 80, 'active'),
    ('Sản phẩm E', 3000000, 75, 'active'),
    ('Sản phẩm F', 50000, 70, 'active'),
    ('Sản phẩm G', 200000, 65, 'active'),
    ('Sản phẩm H', 120000, 60, 'active'),
    ('Sản phẩm I', 4500000, 55, 'active'), 
    ('Sản phẩm K', 90000, 50, 'active'),
    
    ('Sản phẩm L', 80000, 45, 'active'),   
    ('Sản phẩm M', 300000, 40, 'active'),
    ('Sản phẩm N', 1500000, 35, 'active'),
    ('Sản phẩm O', 60000, 30, 'active'),
    ('Sản phẩm P', 250000, 25, 'active');  

SELECT * FROM products 
ORDER BY sold_quantity DESC 
LIMIT 10;

SELECT * FROM products 
ORDER BY sold_quantity DESC 
LIMIT 5 OFFSET 10;
SELECT * FROM products 
WHERE price < 2000000 
ORDER BY sold_quantity DESC;
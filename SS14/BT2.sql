
DROP DATABASE IF EXISTS session_14_bt2;
CREATE DATABASE session_14_bt2;
USE session_14_bt2;

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    stock INT,
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    quantity INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products (product_name, stock, price) VALUES 
('Laptop Dell', 10, 1500.00),
('Chuột Logitech', 5, 20.00);

DELIMITER //

DROP PROCEDURE IF EXISTS Proc_PlaceOrder //

CREATE PROCEDURE Proc_PlaceOrder(
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_stock INT;
    
    START TRANSACTION;
    
    SELECT stock INTO v_stock 
    FROM products 
    WHERE product_id = p_product_id 
    FOR UPDATE;
    
    IF v_stock IS NOT NULL AND v_stock >= p_quantity THEN
        INSERT INTO orders (product_id, quantity) 
        VALUES (p_product_id, p_quantity);
        
        UPDATE products 
        SET stock = stock - p_quantity 
        WHERE product_id = p_product_id;
        
        COMMIT;
        SELECT 'Đặt hàng thành công' AS message;
        
    ELSE
        ROLLBACK;
        SELECT 'Giao dịch thất bại: Không đủ hàng trong kho' AS message;
    END IF;
END //

DELIMITER ;

CALL Proc_PlaceOrder(1, 2);

SELECT * FROM products;
SELECT * FROM orders;

CALL Proc_PlaceOrder(2, 10);

SELECT * FROM products;
SELECT * FROM orders;
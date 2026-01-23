DROP DATABASE IF EXISTS social_network_pro;
CREATE DATABASE social_network_pro;
USE social_network_pro;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    full_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO users (username, full_name, email) VALUES ('user1', 'Nguyen Van A', 'an@gmail.com');

DELIMITER $$

CREATE PROCEDURE CreatePostWithValidation(
    IN p_user_id INT,
    IN p_content TEXT,
    OUT result_message VARCHAR(255)
)
BEGIN
    IF CHAR_LENGTH(p_content) < 5 THEN
        SET result_message = 'Nội dung quá ngắn';
    ELSE
        INSERT INTO posts (user_id, content) VALUES (p_user_id, p_content);
        SET result_message = 'Thêm bài viết thành công';
    END IF;
END $$

DELIMITER ;

SET @msg = '';
CALL CreatePostWithValidation(1, 'Hi', @msg);
SELECT @msg;

SET @msg = '';
CALL CreatePostWithValidation(1, 'Hello World', @msg);
SELECT @msg;

DROP PROCEDURE IF EXISTS CreatePostWithValidation;
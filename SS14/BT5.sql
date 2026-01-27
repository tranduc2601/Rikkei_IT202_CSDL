DROP DATABASE IF EXISTS session_14_kha1;
CREATE DATABASE session_14_kha1;
USE session_14_kha1;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    posts_count INT DEFAULT 0
);

CREATE TABLE posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO users (username) VALUES ('Nguyen Van A');

DELIMITER //

CREATE PROCEDURE sp_create_post(
    IN p_user_id INT,
    IN p_content TEXT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Giao dịch thất bại: Đã ROLLBACK!' AS status;
    END;

    START TRANSACTION;
        
        IF NOT EXISTS (SELECT 1 FROM users WHERE user_id = p_user_id) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Lỗi: User ID không tồn tại';
        END IF;

        INSERT INTO posts (user_id, content) VALUES (p_user_id, p_content);

        UPDATE users 
        SET posts_count = posts_count + 1 
        WHERE user_id = p_user_id;

    COMMIT;
    SELECT 'Giao dịch thành công: Đã COMMIT!' AS status;
END //

DELIMITER ;

CALL sp_create_post(1, 'Chào mọi người, đây là bài viết đầu tiên!');

SELECT * FROM users;
SELECT * FROM posts;

CALL sp_create_post(999, 'Bài viết này sẽ bị lỗi vì user không tồn tại');

SELECT * FROM users;
SELECT * FROM posts;
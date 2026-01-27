DROP DATABASE IF EXISTS session_14_gioi3;
CREATE DATABASE session_14_gioi3;
USE session_14_gioi3;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    following_count INT DEFAULT 0,
    followers_count INT DEFAULT 0
);

CREATE TABLE followers (
    follower_id INT,
    followed_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (follower_id, followed_id),
    FOREIGN KEY (follower_id) REFERENCES users(user_id),
    FOREIGN KEY (followed_id) REFERENCES users(user_id)
);

CREATE TABLE follow_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    follower_id INT,
    followed_id INT,
    error_message VARCHAR(255),
    log_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username) VALUES 
('User A'), 
('User B'), 
('User C'); 

DELIMITER //

CREATE PROCEDURE sp_follow_user(
    IN p_follower_id INT,
    IN p_followed_id INT
)
BEGIN
    DECLARE v_count_follower INT;
    DECLARE v_count_followed INT;
    DECLARE v_already_followed INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        INSERT INTO follow_log (follower_id, followed_id, error_message) 
        VALUES (p_follower_id, p_followed_id, 'Lỗi hệ thống SQL Exception');
        SELECT 'Giao dịch thất bại: Lỗi hệ thống!' AS status;
    END;

    START TRANSACTION;

        SELECT COUNT(*) INTO v_count_follower FROM users WHERE user_id = p_follower_id;
        SELECT COUNT(*) INTO v_count_followed FROM users WHERE user_id = p_followed_id;

        IF v_count_follower = 0 OR v_count_followed = 0 THEN
            ROLLBACK;
            INSERT INTO follow_log (follower_id, followed_id, error_message) 
            VALUES (p_follower_id, p_followed_id, 'Người dùng không tồn tại');
            SELECT 'Thất bại: User ID không tồn tại' AS status;
        
        ELSEIF p_follower_id = p_followed_id THEN
            ROLLBACK;
            INSERT INTO follow_log (follower_id, followed_id, error_message) 
            VALUES (p_follower_id, p_followed_id, 'Không thể tự theo dõi chính mình');
            SELECT 'Thất bại: Không thể tự follow' AS status;

        ELSE
            SELECT COUNT(*) INTO v_already_followed 
            FROM followers 
            WHERE follower_id = p_follower_id AND followed_id = p_followed_id;

            IF v_already_followed > 0 THEN
                ROLLBACK;
                INSERT INTO follow_log (follower_id, followed_id, error_message) 
                VALUES (p_follower_id, p_followed_id, 'Đã theo dõi người này trước đó');
                SELECT 'Thất bại: Đã follow rồi' AS status;
            ELSE
                INSERT INTO followers (follower_id, followed_id) 
                VALUES (p_follower_id, p_followed_id);
                UPDATE users 
                SET following_count = following_count + 1 
                WHERE user_id = p_follower_id;

                UPDATE users 
                SET followers_count = followers_count + 1 
                WHERE user_id = p_followed_id;

                COMMIT;
                SELECT 'Follow thành công!' AS status;
            END IF;
        END IF;
END //

DELIMITER ;

CALL sp_follow_user(1, 2);

SELECT * FROM users;      
SELECT * FROM followers;  
CALL sp_follow_user(1, 1);

CALL sp_follow_user(1, 2);

CALL sp_follow_user(1, 999);

SELECT * FROM follow_log;
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

INSERT INTO posts (user_id, content) VALUES 
(1, 'Post 1'), (1, 'Post 2'), (1, 'Post 3'), (1, 'Post 4'), (1, 'Post 5'),
(1, 'Post 6'), (1, 'Post 7'), (1, 'Post 8'), (1, 'Post 9'), (1, 'Post 10');

DELIMITER $$

CREATE PROCEDURE CalculateBonusPoints(
    IN p_user_id INT,
    INOUT p_bonus_points INT
)
BEGIN
    DECLARE v_post_count INT;

    SELECT COUNT(*) INTO v_post_count 
    FROM posts 
    WHERE user_id = p_user_id;

    IF v_post_count >= 20 THEN
        SET p_bonus_points = p_bonus_points + 100;
    ELSEIF v_post_count >= 10 THEN
        SET p_bonus_points = p_bonus_points + 50;
    END IF;
END $$

DELIMITER ;

SET @current_points = 100;
CALL CalculateBonusPoints(1, @current_points);
SELECT @current_points;

DROP PROCEDURE IF EXISTS CalculateBonusPoints;
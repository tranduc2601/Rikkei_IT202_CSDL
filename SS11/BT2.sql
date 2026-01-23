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

CREATE TABLE likes (
    user_id INT,
    post_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (post_id) REFERENCES posts(post_id)
);

INSERT INTO users (username, full_name, email) VALUES ('user1', 'Nguyen Van A', 'an@gmail.com');
INSERT INTO posts (user_id, content) VALUES (1, 'Hello World');
INSERT INTO likes (user_id, post_id) VALUES (1, 1);

DELIMITER $$

CREATE PROCEDURE CalculatePostLikes(
    IN p_post_id INT,
    OUT total_likes INT
)
BEGIN
    SELECT COUNT(*) INTO total_likes 
    FROM likes 
    WHERE post_id = p_post_id;
END $$

DELIMITER ;

SET @likes_count = 0;
CALL CalculatePostLikes(1, @likes_count);
SELECT @likes_count;

DROP PROCEDURE IF EXISTS CalculatePostLikes;
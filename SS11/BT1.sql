DROP DATABASE IF EXISTS social_network_pro;
CREATE DATABASE social_network_pro;
USE social_network_pro;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    full_name VARCHAR(100),
    email VARCHAR(100),
    hometown VARCHAR(100)
);

CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO users (username, full_name, email, hometown) VALUES 
('user1', 'Nguyen Van A', 'an@gmail.com', 'Ha Noi'),
('user2', 'Tran Thi B', 'binh@gmail.com', 'Da Nang');

INSERT INTO posts (user_id, content) VALUES 
(1, 'Hello World'),
(1, 'My second post'),
(2, 'Travel time');

DELIMITER $$

CREATE PROCEDURE GetUserPosts(IN p_user_id INT)
BEGIN
    SELECT post_id, content, created_at 
    FROM posts 
    WHERE user_id = p_user_id;
END $$

DELIMITER ;

CALL GetUserPosts(1);

DROP PROCEDURE IF EXISTS GetUserPosts;
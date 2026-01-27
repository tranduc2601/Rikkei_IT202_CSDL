DROP DATABASE IF EXISTS session_14_gioi4;
CREATE DATABASE session_14_gioi4;
USE session_14_gioi4;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL
);

CREATE TABLE posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    comments_count INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE comments (
    comment_id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO users (username) VALUES ('Alice'), ('Bob');
INSERT INTO posts (user_id, content) VALUES (1, 'Hello World');

DELIMITER //

CREATE PROCEDURE sp_post_comment(
    IN p_post_id INT,
    IN p_user_id INT,
    IN p_content TEXT
)
BEGIN
    DECLARE v_simulate_error BOOLEAN DEFAULT FALSE;

    START TRANSACTION;

        INSERT INTO comments (post_id, user_id, content) 
        VALUES (p_post_id, p_user_id, p_content);

        SAVEPOINT after_insert;

        IF p_content = 'TEST_ERROR' THEN
            SET v_simulate_error = TRUE;
        END IF;

        IF v_simulate_error = TRUE THEN
            ROLLBACK TO SAVEPOINT after_insert;
            COMMIT;
        ELSE
            UPDATE posts 
            SET comments_count = comments_count + 1 
            WHERE post_id = p_post_id;
            
            COMMIT;
        END IF;

END //

DELIMITER ;

CALL sp_post_comment(1, 2, 'Bài viết hay quá!');

SELECT * FROM comments;
SELECT * FROM posts; 

CALL sp_post_comment(1, 2, 'TEST_ERROR');

SELECT * FROM comments;
SELECT * FROM posts;
USE session_14_kha1;

DROP TABLE IF EXISTS likes;

ALTER TABLE posts ADD COLUMN likes_count INT DEFAULT 0;

CREATE TABLE likes (
    like_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    UNIQUE KEY unique_like (post_id, user_id)
);

DELIMITER //

CREATE PROCEDURE sp_like_post(
    IN p_user_id INT,
    IN p_post_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Giao dịch thất bại: Lỗi hệ thống hoặc đã like rồi!' AS status;
    END;

    START TRANSACTION;

        INSERT INTO likes (user_id, post_id) VALUES (p_user_id, p_post_id);

        UPDATE posts 
        SET likes_count = likes_count + 1 
        WHERE post_id = p_post_id;

    COMMIT;
    SELECT 'Like thành công!' AS status;
END //

DELIMITER ;

UPDATE posts SET likes_count = 0;
DELETE FROM likes;

CALL sp_like_post(1, 1);

SELECT * FROM posts WHERE post_id = 1;
SELECT * FROM likes;

CALL sp_like_post(1, 1);

SELECT * FROM posts WHERE post_id = 1;
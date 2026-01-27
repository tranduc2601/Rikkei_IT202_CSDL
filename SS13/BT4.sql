USE session_13_bt1;

DROP TABLE IF EXISTS post_history;

DROP TRIGGER IF EXISTS trg_before_update_post;

CREATE TABLE post_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT,
    old_content TEXT,
    new_content TEXT,
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    changed_by_user_id INT,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE
);

DELIMITER //

CREATE TRIGGER trg_before_update_post
BEFORE UPDATE ON posts
FOR EACH ROW
BEGIN
    IF OLD.content <> NEW.content THEN
        INSERT INTO post_history (post_id, old_content, new_content, changed_at, changed_by_user_id)
        VALUES (OLD.post_id, OLD.content, NEW.content, NOW(), OLD.user_id);
    END IF;
END //

DELIMITER ;

INSERT IGNORE INTO posts (post_id, user_id, content, created_at) 
VALUES (2, 1, 'Content for testing history', NOW());

UPDATE posts 
SET content = 'This is updated content by Alice' 
WHERE post_id = 2;

SELECT * FROM post_history;

SELECT * FROM posts WHERE post_id = 2;
USE session_13_bt1;

DROP TRIGGER IF EXISTS trg_after_insert_like;
DROP TRIGGER IF EXISTS trg_after_delete_like;
DROP TRIGGER IF EXISTS trg_before_insert_like;
DROP TRIGGER IF EXISTS trg_after_update_like;

DELIMITER //

CREATE TRIGGER trg_before_insert_like
BEFORE INSERT ON likes
FOR EACH ROW
BEGIN
    DECLARE post_owner_id INT;
    SELECT user_id INTO post_owner_id FROM posts WHERE post_id = NEW.post_id;
    IF post_owner_id = NEW.user_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không được phép like bài viết của chính mình';
    END IF;
END //

CREATE TRIGGER trg_after_insert_like
AFTER INSERT ON likes
FOR EACH ROW
BEGIN
    UPDATE posts SET like_count = like_count + 1 WHERE post_id = NEW.post_id;
END //

CREATE TRIGGER trg_after_delete_like
AFTER DELETE ON likes
FOR EACH ROW
BEGIN
    UPDATE posts SET like_count = like_count - 1 WHERE post_id = OLD.post_id;
END //

CREATE TRIGGER trg_after_update_like
AFTER UPDATE ON likes
FOR EACH ROW
BEGIN
    UPDATE posts SET like_count = like_count - 1 WHERE post_id = OLD.post_id;
    UPDATE posts SET like_count = like_count + 1 WHERE post_id = NEW.post_id;
END //

DELIMITER ;

INSERT INTO likes (user_id, post_id, liked_at) VALUES (2, 4, NOW());

UPDATE likes SET post_id = 1 WHERE user_id = 2 AND post_id = 4;

SELECT * FROM posts;
SELECT * FROM user_statistics;
-- 1. Tạo CSDL nếu chưa có
DROP DATABASE IF EXISTS social_network_pro;
CREATE DATABASE social_network_pro;
USE social_network_pro;

-- 2. Tạo bảng users (cần thiết cho Bài 1, 2, 3, 4)
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    full_name VARCHAR(100),
    email VARCHAR(100),
    hometown VARCHAR(100)
);

-- 3. Tạo bảng posts (cần thiết cho Bài 1, 3, 4)
CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content TEXT,
    created_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 4. Thêm dữ liệu mẫu (Dummy Data) để test
INSERT INTO users (username, full_name, email, hometown) VALUES 
('user1', 'Nguyen Van A', 'an@gmail.com', 'Hà Nội'),
('user2', 'Tran Thi B', 'binh@gmail.com', 'Đà Nẵng'),
('user3', 'Le Van C', 'cuong@gmail.com', 'Hồ Chí Minh'),
('user4', 'Pham Thi D', 'dung@gmail.com', 'Hà Nội'),
('user5', 'Hoang Van E', 'em@gmail.com', 'Hải Phòng');

INSERT INTO posts (user_id, content, created_at) VALUES 
(1, 'Chào mọi người', '2026-01-01 08:00:00'),
(1, 'Hôm nay trời đẹp', '2026-01-02 09:00:00'),
(2, 'Đi du lịch thôi', '2026-01-03 10:00:00'),
(4, 'Hà Nội mùa thu', '2026-01-04 11:00:00'),
(1, 'Post thứ 3 của A', '2026-02-01 12:00:00');
USE social_network_pro;

CREATE OR REPLACE VIEW view_user_post AS
SELECT 
    user_id, 
    COUNT(post_id) AS total_user_post
FROM posts
GROUP BY user_id;

SELECT * FROM view_user_post;

SELECT 
    u.full_name, 
    v.total_user_post
FROM users u
JOIN view_user_post v ON u.user_id = v.user_id;
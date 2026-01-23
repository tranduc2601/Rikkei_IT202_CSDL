USE social_network_pro;

CREATE INDEX idx_hometown ON users(hometown);

EXPLAIN ANALYZE
SELECT 
    u.user_id,
    u.username,
    u.hometown,
    p.post_id, 
    p.content,
    p.created_at
FROM users u
JOIN posts p ON u.user_id = p.user_id
WHERE u.hometown = 'Hà Nội'
ORDER BY u.username DESC
LIMIT 10;
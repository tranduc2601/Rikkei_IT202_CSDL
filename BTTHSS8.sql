CREATE DATABASE IF NOT EXISTS HotelManagement;
USE HotelManagement;

CREATE TABLE guests (
    guest_id INT PRIMARY KEY,
    guest_name VARCHAR(255),
    phone VARCHAR(20)
);

CREATE TABLE rooms (
    room_id INT PRIMARY KEY,
    room_type VARCHAR(50),
    price_per_day DECIMAL(10, 2)
);

CREATE TABLE booking (
    booking_id INT PRIMARY KEY,
    guest_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);
SELECT guest_name, phone 
FROM guests;

SELECT DISTINCT room_type 
FROM rooms;

SELECT room_type, price_per_day 
FROM rooms 
ORDER BY price_per_day ASC;

SELECT * FROM rooms 
WHERE price_per_day > 1000000;

SELECT * FROM booking 
WHERE YEAR(check_in) = 2024;

SELECT room_type, COUNT(room_id) AS total_rooms
FROM rooms 
GROUP BY room_type;
SELECT g.guest_name, r.room_type, b.check_in
FROM booking b
JOIN guests g ON b.guest_id = g.guest_id
JOIN rooms r ON b.room_id = r.room_id;

SELECT g.guest_name, COUNT(b.booking_id) AS booking_count
FROM guests g
LEFT JOIN booking b ON g.guest_id = b.guest_id
GROUP BY g.guest_id, g.guest_name;

SELECT r.room_id, r.room_type, 
       SUM(DATEDIFF(b.check_out, b.check_in) * r.price_per_day) AS total_revenue
FROM booking b
JOIN rooms r ON b.room_id = r.room_id
GROUP BY r.room_id, r.room_type;

SELECT r.room_type, 
       SUM(DATEDIFF(b.check_out, b.check_in) * r.price_per_day) AS total_revenue
FROM booking b
JOIN rooms r ON b.room_id = r.room_id
GROUP BY r.room_type;

SELECT g.guest_id, g.guest_name, COUNT(b.booking_id) AS booking_count
FROM booking b
JOIN guests g ON b.guest_id = g.guest_id
GROUP BY g.guest_id, g.guest_name
HAVING COUNT(b.booking_id) >= 2;

SELECT r.room_type, COUNT(b.booking_id) AS total_bookings
FROM booking b
JOIN rooms r ON b.room_id = r.room_id
GROUP BY r.room_type
ORDER BY total_bookings DESC
LIMIT 1;
SELECT * FROM rooms 
WHERE price_per_day > (SELECT AVG(price_per_day) FROM rooms);

SELECT * FROM guests 
WHERE guest_id NOT IN (SELECT DISTINCT guest_id FROM booking);

SELECT r.room_id, r.room_type, COUNT(b.booking_id) AS total_bookings
FROM booking b
JOIN rooms r ON b.room_id = r.room_id
GROUP BY r.room_id, r.room_type
ORDER BY total_bookings DESC
LIMIT 1;
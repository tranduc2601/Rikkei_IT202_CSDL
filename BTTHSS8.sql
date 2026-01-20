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
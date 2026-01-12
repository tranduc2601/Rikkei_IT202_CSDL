CREATE DATABASE IF NOT EXISTS QuanLyTruongHoc;
USE QuanLyTruongHoc;

CREATE TABLE Class (
    class_id VARCHAR(10) NOT NULL,
    class_name VARCHAR(100) NOT NULL,
    school_year VARCHAR(20),
    PRIMARY KEY (class_id)
);

CREATE TABLE Student (
    student_id VARCHAR(10) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    class_id VARCHAR(10),
    PRIMARY KEY (student_id),

    CONSTRAINT fk_class_student
    FOREIGN KEY (class_id) REFERENCES Class(class_id)
);
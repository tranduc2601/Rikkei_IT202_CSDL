-- SET FOREIGN_KEY_CHECKS = 0;

-- DROP TABLE IF EXISTS Student;

-- SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Student (
    student_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE
);

INSERT INTO Student (student_id, full_name, date_of_birth, email)
VALUES 
    ('SV001', 'Nguyễn Văn A', '2005-01-15', 'nguyenvana@gmail.com'),
    ('SV002', 'Trần Thị B', '2005-03-20', 'tranthib@gmail.com'),
    ('SV003', 'Lê Văn C', '2004-12-05', 'levanc@gmail.com');

SELECT * FROM Student;
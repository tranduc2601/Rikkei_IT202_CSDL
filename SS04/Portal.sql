-- PHẦN I: THIẾT KẾ & TẠO BẢNG (DDL)
-- 1. Tắt kiểm tra khóa ngoại để reset DB dễ dàng
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Score;
DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Teacher;
DROP TABLE IF EXISTS Student;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Student (
    student_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE -- Email không trùng
);

CREATE TABLE Teacher (
    teacher_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Course (
    course_id VARCHAR(10) PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    description TEXT,
    session_count INT CHECK (session_count > 0), -- Số buổi học phải > 0
    teacher_id VARCHAR(10),
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Enrollment (
    student_id VARCHAR(10),
    course_id VARCHAR(10),
    enroll_date DATE DEFAULT (CURRENT_DATE),
    
    PRIMARY KEY (student_id, course_id),
    
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE Score (
    student_id VARCHAR(10),
    course_id VARCHAR(10),
    midterm_score DECIMAL(4,2) CHECK (midterm_score BETWEEN 0 AND 10), 
    final_score DECIMAL(4,2) CHECK (final_score BETWEEN 0 AND 10),
    
    PRIMARY KEY (student_id, course_id),
    
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

-- PHẦN II: NHẬP DỮ LIỆU BAN ĐẦU (INSERT)
INSERT INTO Student (student_id, full_name, date_of_birth, email) VALUES 
('SV001', 'Nguyễn Văn An', '2004-01-15', 'an.nguyen@email.com'),
('SV002', 'Trần Thị Bình', '2004-05-20', 'binh.tran@email.com'),
('SV003', 'Lê Văn Cường', '2003-12-10', 'cuong.le@email.com'),
('SV004', 'Phạm Thị Dung', '2004-08-05', 'dung.pham@email.com'),
('SV005', 'Hoàng Văn Em', '2005-02-28', 'em.hoang@email.com');

INSERT INTO Teacher (teacher_id, full_name, email) VALUES
('GV01', 'Thầy Nguyễn Văn Code', 'code.nguyen@uni.edu.vn'),
('GV02', 'Cô Trần Thị Database', 'data.tran@uni.edu.vn'),
('GV03', 'Thầy Lê Java', 'java.le@uni.edu.vn'),
('GV04', 'Cô Phạm Python', 'python.pham@uni.edu.vn'),
('GV05', 'Thầy Hoàng Web', 'web.hoang@uni.edu.vn');

INSERT INTO Course (course_id, course_name, description, session_count, teacher_id) VALUES
('CS101', 'Cơ sở dữ liệu', 'Nhập môn SQL và thiết kế DB', 30, 'GV02'),
('CS102', 'Lập trình Java', 'Java Core căn bản', 45, 'GV03'),
('CS103', 'Lập trình Web', 'HTML, CSS, JS', 35, 'GV05'),
('CS104', 'Cấu trúc dữ liệu', 'Giải thuật căn bản', 40, 'GV01'),
('CS105', 'Python phân tích dữ liệu', 'Numpy, Pandas', 30, 'GV04');

INSERT INTO Enrollment (student_id, course_id, enroll_date) VALUES
('SV001', 'CS101', '2024-01-10'), -- An học CSDL
('SV001', 'CS102', '2024-01-12'), -- An học Java
('SV002', 'CS101', '2024-01-10'), -- Bình học CSDL
('SV003', 'CS103', '2024-01-15'), -- Cường học Web
('SV004', 'CS101', '2024-01-11'), -- Dung học CSDL
('SV005', 'CS105', '2024-01-20'); -- Em học Python

INSERT INTO Score (student_id, course_id, midterm_score, final_score) VALUES
('SV001', 'CS101', 8.5, 9.0),
('SV001', 'CS102', 7.0, 7.5),
('SV002', 'CS101', 6.5, 8.0),
('SV003', 'CS103', 9.0, 9.5),
('SV004', 'CS101', 5.0, 6.0);

-- PHẦN III: CẬP NHẬT DỮ LIỆU (UPDATE)
UPDATE Student 
SET email = 'an.nguyen.new@email.com' 
WHERE student_id = 'SV001';

UPDATE Course 
SET description = 'Hệ quản trị CSDL MySQL nâng cao' 
WHERE course_id = 'CS101';

UPDATE Score 
SET final_score = 8.5 
WHERE student_id = 'SV002' AND course_id = 'CS101';

-- PHẦN IV: XÓA DỮ LIỆU (DELETE)
DELETE FROM Score 
WHERE student_id = 'SV004' AND course_id = 'CS101';

DELETE FROM Enrollment 
WHERE student_id = 'SV004' AND course_id = 'CS101';
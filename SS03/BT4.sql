-- Xóa bảng cũ nếu có để tránh lỗi
DROP TABLE IF EXISTS Enrollment;

CREATE TABLE Enrollment (
    student_id VARCHAR(10),
    subject_id VARCHAR(10),
    enroll_date DATE,
    
    -- 1. Tạo Khóa chính trên 2 cột để tránh trùng lặp
    -- (Một sinh viên không thể đăng ký 1 môn 2 lần)
    PRIMARY KEY (student_id, subject_id),
    
    -- 2. Tạo Khóa ngoại liên kết với bảng Student
    CONSTRAINT fk_enrollment_student 
        FOREIGN KEY (student_id) REFERENCES Student(student_id),
        
    -- 3. Tạo Khóa ngoại liên kết với bảng Subject
    CONSTRAINT fk_enrollment_subject 
        FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
);
SELECT * FROM Enrollment;
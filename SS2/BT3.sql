CREATE TABLE Enrollment (
    student_id VARCHAR(10) NOT NULL, -- Lấy từ bảng Student
    subject_id VARCHAR(10) NOT NULL, -- Lấy từ bảng Subject
    registration_date DATE,          -- Ngày đăng ký
    
    PRIMARY KEY (student_id, subject_id),
    
    CONSTRAINT fk_enrollment_student
        FOREIGN KEY (student_id) REFERENCES Student(student_id),
        
    CONSTRAINT fk_enrollment_subject
        FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
);
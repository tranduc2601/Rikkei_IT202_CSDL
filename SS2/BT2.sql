CREATE TABLE Student (
    student_id VARCHAR(10) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    
    PRIMARY KEY (student_id)
);

CREATE TABLE Subject (
    subject_id VARCHAR(10) NOT NULL,
    subject_name VARCHAR(100) NOT NULL,
    credit INT, -- Số tín chỉ
    
    PRIMARY KEY (subject_id),
    
    CONSTRAINT chk_credit CHECK (credit > 0)
);
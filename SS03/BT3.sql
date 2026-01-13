CREATE TABLE Subject (
    subject_id VARCHAR(10) PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    credit INT,
    CONSTRAINT chk_credit CHECK (credit > 0) 
);

INSERT INTO Subject (subject_id, subject_name, credit)
VALUES 
    ('MH01', 'Cơ sở dữ liệu', 3),
    ('MH02', 'Lập trình C', 4),
    ('MH03', 'Tiếng Anh chuyên ngành', 2);

SELECT * FROM Subject;
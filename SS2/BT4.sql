CREATE TABLE Teacher (
    teacher_id VARCHAR(10) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    
    PRIMARY KEY (teacher_id),
        CONSTRAINT uq_email UNIQUE (email)
);

ALTER TABLE Subject
ADD COLUMN teacher_id VARCHAR(10);

ALTER TABLE Subject
ADD CONSTRAINT fk_subject_teacher
FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id);
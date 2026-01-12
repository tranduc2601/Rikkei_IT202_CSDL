INSERT INTO Student (student_id, full_name, date_of_birth, email)
VALUES ('SV005', 'Sinh Viên Nhập Nhầm', '2000-01-01', 'nhamlan@gmail.com');

SELECT * FROM Student; 

UPDATE Student 
SET email = 'levanc_new_email@gmail.com' 
WHERE student_id = 'SV003';

UPDATE Student 
SET date_of_birth = '2005-05-25' 
WHERE student_id = 'SV002';

DELETE FROM Student 
WHERE student_id = 'SV005';

SELECT * FROM Student;
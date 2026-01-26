DROP DATABASE IF EXISTS StudentManager;
CREATE DATABASE StudentManager;
USE StudentManager;

CREATE TABLE Department(
    DeptID char(5) primary key,
    DeptName varchar(50) NOT NULL
);

CREATE TABLE Student(
    StudentID char(6) primary key,
    FullName varchar(50) NOT NULL,
    Gender varchar(10),
    BirthDate date,
    DeptID char(5),
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

CREATE TABLE Course(
    CourseID char(6) primary key,
    CourseName varchar(50) NOT NULL,
    Credits int
);

CREATE TABLE Enrollment(
    StudentID char(6),
    CourseID char(6),
    Score float,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

INSERT INTO Department (DeptID, DeptName) VALUES
('IT', 'Information Technology'),
('KT', 'Ke Toan'),
('NN', 'Ngon Ngu Anh');

INSERT INTO Student (StudentID, FullName, Gender, BirthDate, DeptID) VALUES
('S001', 'Nguyen Van An', 'Nam', '2000-01-15', 'IT'),
('S002', 'Tran Thi Binh', 'Nu', '2001-05-20', 'KT'),
('S003', 'Le Van Cuong', 'Nam', '2000-08-10', 'IT'),
('S004', 'Pham Thi Dung', 'Nu', '2002-02-14', 'NN'),
('S005', 'Hoang Van Em', 'Nam', '2001-12-25', 'IT');

INSERT INTO Course (CourseID, CourseName, Credits) VALUES
('C00001', 'Database Systems', 3),
('C00002', 'Web Development', 4),
('C00003', 'Accounting Basics', 3);

INSERT INTO Enrollment (StudentID, CourseID, Score) VALUES
('S001', 'C00001', 8.5),
('S001', 'C00002', 9.0),
('S002', 'C00003', 7.0),
('S003', 'C00001', 6.0),
('S003', 'C00002', 8.0),
('S004', 'C00001', 5.5), 
('S005', 'C00001', 9.5);

CREATE VIEW View_StudentBasic AS
SELECT
    student.StudentID,
    student.FullName,
    department.DeptName
FROM Student student
JOIN Department department ON student.DeptID = department.DeptID;

SELECT * FROM View_StudentBasic;

CREATE INDEX index_FullName ON Student(FullName);

SHOW INDEX FROM Student;

DELIMITER $$
CREATE PROCEDURE GetStudentsIT()
BEGIN 
    SELECT
        student.StudentID,
        student.FullName,
        student.Gender,
        student.BirthDate,
        department.DeptName
    FROM Student student
    JOIN Department department ON student.DeptID = department.DeptID
    WHERE department.DeptName = 'Information Technology';
END $$
DELIMITER ;

CALL GetStudentsIT();

CREATE VIEW View_StudentCountByDept AS
SELECT 
    department.DeptName,
    COUNT(student.StudentID) AS TotalStudents
FROM Department department
LEFT JOIN Student student ON department.DeptID = student.DeptID
GROUP BY department.DeptID, department.DeptName;

SELECT * FROM View_StudentCountByDept
ORDER BY TotalStudents DESC
LIMIT 1;

DELIMITER $$
CREATE PROCEDURE GetTopScoreStudent(IN p_CourseID char(6))
BEGIN 
    SELECT
        student.FullName,
        enrollment.Score,
        course.CourseName
    FROM Student student
    JOIN Enrollment enrollment ON student.StudentID = enrollment.StudentID
    JOIN Course course ON enrollment.CourseID = course.CourseID
    WHERE enrollment.CourseID = p_CourseID
    ORDER BY enrollment.Score DESC
    LIMIT 1;
END $$
DELIMITER ;

CALL GetTopScoreStudent('C00001');

CREATE OR REPLACE VIEW View_IT_Enrollment_DB AS
SELECT 
    enrollment.StudentID,
    enrollment.CourseID,
    enrollment.Score
FROM Enrollment enrollment
JOIN Student student ON enrollment.StudentID = student.StudentID
JOIN Department department ON student.DeptID = department.DeptID
WHERE department.DeptName = 'Information Technology'
    AND enrollment.CourseID = 'C00001'
WITH CHECK OPTION;
    
DELIMITER $$
CREATE PROCEDURE UpdateScore_IT_DB(
    IN p_StudentID char(6),
    INOUT p_NewScore float
)
BEGIN
    IF p_NewScore > 10 THEN
        SET p_NewScore = 10;
    END IF;
    
    UPDATE View_IT_Enrollment_DB
    SET Score = p_NewScore
    WHERE StudentID = p_StudentID;
END $$
DELIMITER ;
    
SET @diem_moi = 15;
CALL UpdateScore_IT_DB('S001', @diem_moi);
    
SELECT @diem_moi AS Diem_Sau_Xu_Ly;
SELECT * FROM View_IT_Enrollment_DB WHERE StudentID = 'S001';

SET @diem_nn = 9;
CALL UpdateScore_IT_DB('S004', @diem_nn);
SELECT * FROM Enrollment WHERE StudentID = 'S004' AND CourseID = 'C00001';
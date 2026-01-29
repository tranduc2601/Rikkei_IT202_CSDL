DROP DATABASE IF EXISTS StudentManagement;
CREATE DATABASE StudentManagement;
USE StudentManagement;

CREATE TABLE Students (
    StudentID CHAR(5) PRIMARY KEY,
    FullName VARCHAR(50) NOT NULL,
    TotalDebt DECIMAL(10,2) DEFAULT 0
);

CREATE TABLE Subjects (
    SubjectID CHAR(5) PRIMARY KEY,
    SubjectName VARCHAR(50) NOT NULL,
    Credits INT CHECK (Credits > 0)
);

CREATE TABLE Grades (
    StudentID CHAR(5),
    SubjectID CHAR(5),
    Score DECIMAL(4,2) CHECK (Score BETWEEN 0 AND 10),
    PRIMARY KEY (StudentID, SubjectID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

CREATE TABLE GradeLog (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID CHAR(5),
    OldScore DECIMAL(4,2),
    NewScore DECIMAL(4,2),
    ChangeDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Students (StudentID, FullName, TotalDebt) VALUES 
('SV01', 'Nguyen Van A', 1000000);

INSERT INTO Subjects (SubjectID, SubjectName, Credits) VALUES 
('SUB01', 'Co So Du Lieu', 3),
('SUB02', 'Lap Trinh C', 4);

INSERT INTO Grades (StudentID, SubjectID, Score) VALUES 
('SV01', 'SUB01', 8.5);

DELIMITER //
CREATE TRIGGER tg_CheckScore
BEFORE INSERT ON Grades
FOR EACH ROW
BEGIN
    IF NEW.Score < 0 THEN
        SET NEW.Score = 0;
    ELSEIF NEW.Score > 10 THEN
        SET NEW.Score = 10;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_AddStudentTransaction()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Giao dịch thất bại' AS Message;
    END;

    START TRANSACTION;
        INSERT INTO Students (StudentID, FullName) VALUES ('SV02', 'Ha Bich Ngoc');
        
        UPDATE Students 
        SET TotalDebt = 5000000 
        WHERE StudentID = 'SV02';
        
    COMMIT;
    SELECT 'Giao dịch thành công' AS Message;
END //
DELIMITER ;

CALL sp_AddStudentTransaction();

DELIMITER //
CREATE TRIGGER tg_LogGradeUpdate
AFTER UPDATE ON Grades
FOR EACH ROW
BEGIN
    INSERT INTO GradeLog (StudentID, OldScore, NewScore, ChangeDate)
    VALUES (OLD.StudentID, OLD.Score, NEW.Score, NOW());
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_PayTuition()
BEGIN
    DECLARE v_CurrentDebt DECIMAL(10,2);
    
    START TRANSACTION;
        UPDATE Students 
        SET TotalDebt = TotalDebt - 2000000 
        WHERE StudentID = 'SV01';
        
        SELECT TotalDebt INTO v_CurrentDebt FROM Students WHERE StudentID = 'SV01';
        
        IF v_CurrentDebt < 0 THEN
            ROLLBACK;
            SELECT 'Giao dịch thất bại: Số tiền đóng vượt quá số nợ' AS Message;
        ELSE
            COMMIT;
            SELECT 'Đóng học phí thành công' AS Message;
        END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER tg_PreventPassUpdate
BEFORE UPDATE ON Grades
FOR EACH ROW
BEGIN
    IF OLD.Score >= 4.0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Không được phép sửa điểm của sinh viên đã qua môn!';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeleteStudentGrade(
    IN p_StudentID CHAR(5),
    IN p_SubjectID CHAR(5)
)
BEGIN
    DECLARE v_OldScore DECIMAL(4,2);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Lỗi hệ thống' AS Message;
    END;

    START TRANSACTION;
        SELECT Score INTO v_OldScore 
        FROM Grades 
        WHERE StudentID = p_StudentID AND SubjectID = p_SubjectID;
        
        INSERT INTO GradeLog (StudentID, OldScore, NewScore, ChangeDate)
        VALUES (p_StudentID, v_OldScore, NULL, NOW());
        
        DELETE FROM Grades 
        WHERE StudentID = p_StudentID AND SubjectID = p_SubjectID;
        
        IF ROW_COUNT() = 0 THEN
            ROLLBACK;
            SELECT 'Không tìm thấy dữ liệu để xóa' AS Message;
        ELSE
            COMMIT;
            SELECT 'Hủy môn học thành công' AS Message;
        END IF;
END //
DELIMITER ;
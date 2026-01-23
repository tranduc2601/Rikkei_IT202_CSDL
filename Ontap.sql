-- =============================================
-- PHẦN 1: TẠO CSDL VÀ BẢNG (DDL)
-- =============================================

-- 1. Tạo Database
-- Logic: Kiểm tra nếu chưa có thì mới tạo để tránh lỗi trùng lặp.
CREATE DATABASE IF NOT EXISTS ProjectManagement;
USE ProjectManagement;

-- 2. Tạo bảng Employee (Bảng cha)
-- Logic: Tạo bảng này trước vì nó không phụ thuộc bảng nào khác.
-- Email cần UNIQUE để không trùng lặp. Department dùng ENUM để giới hạn giá trị nhập.
CREATE TABLE Employee (
    EmployeeId VARCHAR(10) PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    HireDate DATE NOT NULL,
    Department ENUM('IT', 'HR', 'Sales', 'Marketing', 'Finance') DEFAULT 'IT',
    Email VARCHAR(255) UNIQUE NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL
);

-- Tạo bảng Project (Bảng cha)
-- Logic: Tương tự, tạo bảng này trước khi tạo bảng phân công.
CREATE TABLE Project (
    ProjectId VARCHAR(10) PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE,
    Budget DECIMAL(12, 2) NOT NULL
);

-- Tạo bảng ProjectAssignment (Bảng con/Thực thể yếu)
-- Logic: Tạo sau cùng vì chứa Khóa ngoại (FK) trỏ về 2 bảng trên.
-- Khóa chính (PK) là cặp (EmployeeId, ProjectId) để đảm bảo 1 nhân viên không làm trùng 1 dự án 2 lần.
CREATE TABLE ProjectAssignment (
    EmployeeId VARCHAR(10),
    ProjectId VARCHAR(10),
    Role VARCHAR(50) NOT NULL,
    HoursWorked INT NOT NULL,
    PRIMARY KEY (EmployeeId, ProjectId),
    FOREIGN KEY (EmployeeId) REFERENCES Employee(EmployeeId),
    FOREIGN KEY (ProjectId) REFERENCES Project(ProjectId)
);

-- =============================================
-- PHẦN 2: CHÈN DỮ LIỆU (INSERT)
-- =============================================

-- Chèn bảng Employee
-- Logic: Chèn dữ liệu bảng cha trước. Định dạng ngày là 'YYYY-MM-DD'.
INSERT INTO Employee (EmployeeId, FullName, HireDate, Department, Email, Salary) VALUES
('EMP001', 'Nguyen Van An', '2020-03-15', 'IT', 'an.nguyen@company.com', 25000000),
('EMP002', 'Tran Thi Binh', '2021-06-10', 'HR', 'binh.tran@company.com', 18000000),
('EMP003', 'Le Van Cuong', '2019-11-25', 'Sales', 'cuong.le@company.com', 22000000),
('EMP004', 'Pham Thi Dung', '2022-01-30', 'Marketing', 'dung.pham@company.com', 20000000),
('EMP005', 'Hoang Van Em', '2020-08-12', 'Finance', 'em.hoang@company.com', 28000000);

-- Chèn bảng Project
INSERT INTO Project (ProjectId, ProjectName, StartDate, EndDate, Budget) VALUES
('PJ001', 'Website Redesign', '2023-01-10', '2023-06-30', 500000000),
('PJ002', 'Mobile App Development', '2023-02-15', '2023-09-30', 750000000),
('PJ003', 'Marketing Campaign Q2', '2023-04-01', '2023-06-30', 300000000),
('PJ004', 'ERP System Upgrade', '2023-03-01', '2023-12-31', 1200000000);

-- Chèn bảng ProjectAssignment
-- Logic: Chèn sau cùng. Dữ liệu EmployeeId và ProjectId phải khớp với dữ liệu đã có ở 2 bảng trên.
INSERT INTO ProjectAssignment (EmployeeId, ProjectId, Role, HoursWorked) VALUES
('EMP001', 'PJ001', 'Developer', 120),
('EMP001', 'PJ002', 'Lead Developer', 200),
('EMP002', 'PJ001', 'HR Coordinator', 80),
('EMP002', 'PJ003', 'HR Manager', 60),
('EMP003', 'PJ002', 'Sales Consultant', 100),
('EMP003', 'PJ004', 'Business Analyst', 150),
('EMP004', 'PJ003', 'Marketing Lead', 180),
('EMP004', 'PJ001', 'UX Designer', 90),
('EMP005', 'PJ004', 'Finance Controller', 160);

-- =============================================
-- PHẦN 3: SỬA ĐỔI DỮ LIỆU (UPDATE/DELETE)
-- =============================================

-- 3. Sửa tên dự án PJ001
-- Logic: Dùng WHERE để chỉ định đúng dự án cần sửa, tránh sửa toàn bộ bảng.
UPDATE Project 
SET ProjectName = 'Corporate Website Redesign 2023' 
WHERE ProjectId = 'PJ001';

-- 4. Cập nhật giờ làm của EMP004 trong dự án PJ001
-- Logic: Vì khóa chính là cặp (NV, DA), cần WHERE cả 2 điều kiện mới tìm đúng dòng.
UPDATE ProjectAssignment 
SET HoursWorked = 110 
WHERE EmployeeId = 'EMP004' AND ProjectId = 'PJ001';

-- 5. Xóa phân công của EMP002 trong dự án PJ003
-- Logic: Tương tự Update, cần xác định chính xác cặp khóa chính để xóa.
DELETE FROM ProjectAssignment 
WHERE EmployeeId = 'EMP002' AND ProjectId = 'PJ003';

-- =============================================
-- PHẦN 4: TRUY VẤN CƠ BẢN (SELECT)
-- =============================================

-- 6. Lấy nhân viên phòng IT
-- Logic: Dùng phép so sánh bằng (=) để lọc chính xác.
SELECT EmployeeId, FullName, HireDate, Department, Email, Salary
FROM Employee
WHERE Department = 'IT';

-- 7. Lấy dự án kết thúc trước 2023-07-01
-- Logic: So sánh ngày tháng dùng dấu < (nhỏ hơn là trước, lớn hơn là sau).
SELECT ProjectId, ProjectName, StartDate, EndDate
FROM Project
WHERE EndDate < '2023-07-01';

-- 8. Danh sách phân công dự án PJ002, sắp xếp giờ làm giảm dần
-- Logic: Lọc dự án trước (WHERE), sau đó mới sắp xếp (ORDER BY DESC).
SELECT EmployeeId, ProjectId, Role, HoursWorked
FROM ProjectAssignment
WHERE ProjectId = 'PJ002'
ORDER BY HoursWorked DESC;

-- 9. Lấy nhân viên họ 'Tran'
-- Logic: Dùng LIKE 'Tran %' -> Bắt đầu bằng Tran, theo sau là bất kỳ ký tự gì.
SELECT * FROM Employee
WHERE FullName LIKE 'Tran %';

-- 10. Phân công có giờ làm từ 100 đến 200
-- Logic: BETWEEN bao gồm cả 2 giá trị đầu mút (>= 100 và <= 200).
SELECT EmployeeId, ProjectId, Role, HoursWorked
FROM ProjectAssignment
WHERE HoursWorked BETWEEN 100 AND 200;

-- 11. Top 3 nhân viên vào làm sớm nhất
-- Logic: Sắp xếp ngày tăng dần (ASC - cũ nhất lên đầu) rồi lấy 3 dòng đầu (LIMIT).
SELECT * FROM Employee
ORDER BY HireDate ASC
LIMIT 3;

-- =============================================
-- PHẦN 5: TRUY VẤN NÂNG CAO (GROUP BY, JOIN)
-- =============================================

-- 12. Thống kê số lượng nhân viên theo phòng
-- Logic: Gom nhóm các nhân viên cùng phòng (GROUP BY), rồi đếm số ID trong nhóm đó (COUNT).
SELECT Department, COUNT(EmployeeId) AS EmployeeCount
FROM Employee
GROUP BY Department;

-- 13. Tổng giờ làm của từng nhân viên
-- Logic: Cần tên (bảng Employee) và giờ (bảng Assignment) -> Phải JOIN 2 bảng.
-- Sau đó gom nhóm theo từng người để tính tổng giờ (SUM).
SELECT 
    e.EmployeeId, 
    e.FullName, 
    SUM(pa.HoursWorked) AS TotalHoursWorked
FROM Employee e
JOIN ProjectAssignment pa ON e.EmployeeId = pa.EmployeeId
GROUP BY e.EmployeeId, e.FullName;

-- 14. Dự án có ít nhất 2 nhân viên
-- Logic: 
-- B1: JOIN Project với Assignment để biết dự án nào có ai làm.
-- B2: Gom nhóm theo dự án (GROUP BY).
-- B3: Lọc nhóm nào có số nhân viên >= 2 bằng HAVING (vì WHERE không dùng được với COUNT).
SELECT 
    p.ProjectId, 
    p.ProjectName,
    COUNT(pa.EmployeeId) AS TotalMembers
FROM Project p
JOIN ProjectAssignment pa ON p.ProjectId = pa.ProjectId
GROUP BY p.ProjectId, p.ProjectName
HAVING COUNT(pa.EmployeeId) >= 2;
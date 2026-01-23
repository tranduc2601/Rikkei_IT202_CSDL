CREATE DATABASE IF NOT EXISTS ProjectManagement;
USE ProjectManagement;

CREATE TABLE Employee (
    EmployeeId VARCHAR(10) PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    HireDate DATE NOT NULL,
    Department ENUM('IT', 'HR', 'Sales', 'Marketing', 'Finance') DEFAULT 'IT',
    Email VARCHAR(255) UNIQUE NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Project (
    ProjectId VARCHAR(10) PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE,
    Budget DECIMAL(12, 2) NOT NULL
);

CREATE TABLE ProjectAssignment (
    EmployeeId VARCHAR(10),
    ProjectId VARCHAR(10),
    Role VARCHAR(50) NOT NULL,
    HoursWorked INT NOT NULL,
    PRIMARY KEY (EmployeeId, ProjectId),
    FOREIGN KEY (EmployeeId) REFERENCES Employee(EmployeeId),
    FOREIGN KEY (ProjectId) REFERENCES Project(ProjectId)
);

INSERT INTO Employee (EmployeeId, FullName, HireDate, Department, Email, Salary) VALUES
('EMP001', 'Nguyen Van An', '2020-03-15', 'IT', 'an.nguyen@company.com', 25000000),
('EMP002', 'Tran Thi Binh', '2021-06-10', 'HR', 'binh.tran@company.com', 18000000),
('EMP003', 'Le Van Cuong', '2019-11-25', 'Sales', 'cuong.le@company.com', 22000000),
('EMP004', 'Pham Thi Dung', '2022-01-30', 'Marketing', 'dung.pham@company.com', 20000000),
('EMP005', 'Hoang Van Em', '2020-08-12', 'Finance', 'em.hoang@company.com', 28000000);

INSERT INTO Project (ProjectId, ProjectName, StartDate, EndDate, Budget) VALUES
('PJ001', 'Website Redesign', '2023-01-10', '2023-06-30', 500000000),
('PJ002', 'Mobile App Development', '2023-02-15', '2023-09-30', 750000000),
('PJ003', 'Marketing Campaign Q2', '2023-04-01', '2023-06-30', 300000000),
('PJ004', 'ERP System Upgrade', '2023-03-01', '2023-12-31', 1200000000);

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

UPDATE Project 
SET ProjectName = 'Corporate Website Redesign 2023' 
WHERE ProjectId = 'PJ001';

UPDATE ProjectAssignment 
SET HoursWorked = 110 
WHERE EmployeeId = 'EMP004' AND ProjectId = 'PJ001';

DELETE FROM ProjectAssignment 
WHERE EmployeeId = 'EMP002' AND ProjectId = 'PJ003';

SELECT EmployeeId, FullName, HireDate, Department, Email, Salary
FROM Employee
WHERE Department = 'IT';

SELECT ProjectId, ProjectName, StartDate, EndDate
FROM Project
WHERE EndDate < '2023-07-01';

SELECT EmployeeId, ProjectId, Role, HoursWorked
FROM ProjectAssignment
WHERE ProjectId = 'PJ002'
ORDER BY HoursWorked DESC;

SELECT * FROM Employee
WHERE FullName LIKE 'Tran %';

SELECT EmployeeId, ProjectId, Role, HoursWorked
FROM ProjectAssignment
WHERE HoursWorked BETWEEN 100 AND 200;

SELECT * FROM Employee
ORDER BY HireDate ASC
LIMIT 3;

SELECT Department, COUNT(EmployeeId) AS EmployeeCount
FROM Employee
GROUP BY Department;

SELECT 
    e.EmployeeId, 
    e.FullName, 
    SUM(pa.HoursWorked) AS TotalHoursWorked
FROM Employee e
JOIN ProjectAssignment pa ON e.EmployeeId = pa.EmployeeId
GROUP BY e.EmployeeId, e.FullName;

SELECT 
    p.ProjectId, 
    p.ProjectName,
    COUNT(pa.EmployeeId) AS TotalMembers
FROM Project p
JOIN ProjectAssignment pa ON p.ProjectId = pa.ProjectId
GROUP BY p.ProjectId, p.ProjectName
HAVING COUNT(pa.EmployeeId) >= 2;
DROP DATABASE IF EXISTS chapter11;

-- 创建数据库
CREATE DATABASE IF NOT EXISTS chapter11;

USE chapter11;

DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Manager;
DROP TABLE IF EXISTS Department;

-- 部门表
CREATE TABLE IF NOT EXISTS Department(
	DeptID INT PRIMARY KEY AUTO_INCREMENT,
	DeptName VARCHAR(50) NOT NULL
);

INSERT INTO Department(DeptName) VALUES('总部'),('开发部'),('咨询部'),('财务部'),('行政部'),('人力部');

-- 经理表
CREATE TABLE IF NOT EXISTS Manager(
	ManagerID INT PRIMARY KEY AUTO_INCREMENT,
	ManagerName VARCHAR(50) NOT NULL,
	DeptID INT,
	FOREIGN KEY(DeptID) REFERENCES Department(DeptID)
);

INSERT INTO Manager VALUES(NULL,'黄文隆',1),(NULL,'张吉',2),(NULL,'林玟',3),(NULL,'林雅',3),(NULL,'江奕',3),(NULL,'刘柏',4),(NULL,'吉茹',4);

-- 员工表
CREATE TABLE IF NOT EXISTS Employee(
	EmpID INT PRIMARY KEY AUTO_INCREMENT,
	EmpName VARCHAR(50) NOT NULL UNIQUE,
	JobPosition ENUM('CEO','开发人员','顾问','经理','HR','会计','行政') NOT NULL,
	Salary DECIMAL(10,2) NOT NULL,
	DeptID INT,
	ManagerID INT,
	FOREIGN KEY(DeptID) REFERENCES Department(DeptID),
	FOREIGN KEY(ManagerID) REFERENCES Manager(ManagerID)
);

INSERT INTO Employee VALUES
(NULL,'黄文隆','CEO',100000,1,NULL),
(NULL,'张吉','经理',30000,2,1),
(NULL,'谢彦','开发人员',15000,2,2),
(NULL,'傅智翔','开发人员',12000,2,2),
(NULL,'林玟','经理',35000,3,1),
(NULL,'荣姿康','顾问',12000,3,3),
(NULL,'林雅','经理',32500,3,1),
(NULL,'雷进宝','顾问',12500,3,4),
(NULL,'江奕','经理',31000,3,1),
(NULL,'李雅惠','顾问',26000,3,5),
(NULL,'吴佳瑞','HR',12000,NULL,NULL),
(NULL,'周琼玟','会计',14000,NULL,NULL),
(NULL,'黄文','行政',19000,NULL,NULL);

-- 查询员工信息以及所在部门的名称
SELECT e.EmpName, d.DeptName 
FROM Employee AS e,Department AS d;

-- CROSS JOIN，交叉连接，出现笛卡尔积效果
SELECT e.EmpName, d.DeptName 
FROM Employee AS e CROSS JOIN Department AS d;

SELECT COUNT(*) FROM Employee; -- 13
SELECT COUNT(*) FROM Department; -- 6
-- 13*6 = 78

-- INNER JOIN（内连接）
SELECT e.*, d.DeptName 
FROM Employee AS e INNER JOIN Department AS d
ON e.DeptID = d.DeptID;

-- INNER JOIN，可以只写JOIN
SELECT e.*, d.DeptName 
FROM Employee AS e JOIN Department AS d
ON e.DeptID = d.DeptID;

-- SELECT * FROM Employee;
-- SELECT * FROM Department;

-- LEFT JOIN（左连接），LEFT OUTER JOIN
SELECT e.*, d.DeptName 
FROM Employee AS e LEFT JOIN Department AS d
ON e.DeptID = d.DeptID;

-- RIGHT JOIN（右连接），RIGHT OUTER JOIN
SELECT e.*,d.DeptName
FROM Employee AS e RIGHT JOIN Department AS d
ON e.DeptID = d.DeptID;

-- FULL JOIN（全连接）
SELECT e.*,d.DeptName
FROM Employee AS e FULL JOIN Department AS d
ON e.DeptID = d.DeptID;

(SELECT e.*, d.DeptName 
FROM Employee AS e INNER JOIN Department AS d
ON e.DeptID = d.DeptID)
UNION
(SELECT e.*, d.DeptName 
FROM Employee AS e LEFT JOIN Department AS d
ON e.DeptID = d.DeptID)
UNION
(SELECT e.*,d.DeptName
FROM Employee AS e RIGHT JOIN Department AS d
ON e.DeptID = d.DeptID)

-- NATURAL JOIN（自然连接）
SELECT e.EmpName, d.DeptName
FROM Employee AS e
INNER JOIN
Department AS d
ON e.DeptID = d.DeptID;

SELECT e.EmpName, d.DeptName
FROM Employee AS e
NATURAL JOIN
Department AS d;

ALTER TABLE Department RENAME COLUMN DeptID TO DID;
ALTER TABLE Department RENAME COLUMN DID TO DeptID;

-- SELF JOIN（自连接）
DROP TABLE IF EXISTS EmployeeVar;
DROP TABLE IF EXISTS DepartmentVar;

-- 部门表
CREATE TABLE IF NOT EXISTS DepartmentVar (
	DeptID INT PRIMARY KEY AUTO_INCREMENT,
	DeptName VARCHAR(50) NOT NULL
);

INSERT INTO DepartmentVar(DeptName) VALUES('总部'),('开发部'),('咨询部'),('财务部'),('行政部'),('人力部');

-- 员工表
CREATE TABLE IF NOT EXISTS EmployeeVar (
	EmpID INT PRIMARY KEY AUTO_INCREMENT,
	EmpName VARCHAR(50) NOT NULL UNIQUE,
	JobPosition ENUM('CEO','开发人员','顾问','经理','HR','会计','行政') NOT NULL,
	Salary DECIMAL(10,2) NOT NULL,
	DeptID INT,
	ManagerID INT,
	FOREIGN KEY(DeptID) REFERENCES Department(DeptID),
	FOREIGN KEY(ManagerID) REFERENCES EmployeeVar(EmpID)
);

INSERT INTO EmployeeVar VALUES
(NULL,'黄文隆','CEO',100000,1,NULL),
(NULL,'张吉','经理',30000,2,1),
(NULL,'谢彦','开发人员',15000,2,2),
(NULL,'傅智翔','开发人员',12000,2,2),
(NULL,'林玟','经理',35000,3,1),
(NULL,'荣姿康','顾问',12000,3,5),
(NULL,'林雅','经理',32500,3,1),
(NULL,'雷进宝','顾问',12500,3,7),
(NULL,'江奕','经理',31000,3,1),
(NULL,'李雅惠','顾问',26000,3,9),
(NULL,'吴佳瑞','HR',12000,NULL,NULL),
(NULL,'周琼玟','会计',14000,NULL,NULL),
(NULL,'黄文','行政',19000,NULL,NULL);

-- 查看员工的姓名以及上级的姓名
SELECT e1.EmpName AS '员工姓名', e2.EmpName AS '上级姓名'
FROM EmployeeVar AS e1
INNER JOIN
EmployeeVar AS e2
ON e1.ManagerID = e2.EmpID;

SELECT e1.EmpName AS '员工姓名', e2.EmpName AS '上级姓名'
FROM EmployeeVar AS e1
LEFT JOIN
EmployeeVar AS e2
ON e1.ManagerID = e2.EmpID;
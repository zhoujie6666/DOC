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
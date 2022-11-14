-- WITH语句
-- Tips：MySQL8.0以上的版本才支持WITH语句的语法
-- 可读性增强，维护便利

-- 查询薪资高于公司均薪的员工信息（CEO除外），并在单独一列中说明

WITH temp AS (
	SELECT AVG(Salary) AS AllAvgSalary
	FROM Employee
	WHERE JobPosition != 'CEO'
)
SELECT *,(
	CASE
		WHEN e.Salary > temp.AllAvgSalary THEN 'Higher Than Average Salary'
		WHEN e.Salary = temp.AllAvgSalary THEN 'Equals Average Salary'
		ELSE 'Lower Than Average Salary'
	END
) AS CompareResult
FROM Employee AS e
INNER JOIN temp
WHERE JobPosition != 'CEO'
ORDER BY CompareResult;

-- 查询部门均薪高于公司均薪的部门名称（CEO除外）

-- 查询公司均薪
-- 查询各部门的均薪
-- 两个数值进行比较

WITH temp1 AS (	-- 查询公司均薪
	SELECT AVG(Salary) AS AllAvgSalary
	FROM Employee 
	WHERE JobPosition != 'CEO'
), 
temp2 AS (	-- 查询各部门的均薪
	SELECT DeptID, AVG(Salary) AS DeptAvgSalary
	FROM Employee
	WHERE JobPosition != 'CEO' AND DeptID IS NOT NULL
	GROUP BY DeptID
),
temp AS (	-- 两个数值进行比较
	SELECT temp2.DeptID, temp2.DeptAvgSalary, temp1.AllAvgSalary 
	FROM 
		temp1
	JOIN
		temp2
	ON
		temp2.DeptAvgSalary > temp1.AllAvgSalary
)
-- 关联Department表，获得部门的名称
SELECT d.DeptName AS '部门名称', ROUND(temp.DeptAvgSalary,2) AS '部门均薪', ROUND(temp.AllAvgSalary,2) AS '企业均薪'
FROM 
	Department AS d
JOIN
	temp
ON
	d.DeptID = temp.DeptID;

-- WITH循环递归

-- 获取1~10数字
WITH RECURSIVE temp AS
(
	SELECT 1 AS n -- 起始数据
	UNION
	SELECT n + 1	-- 基于起始条件，加1
	FROM temp			-- 从temp中获取数据
	WHERE n < 10	-- 条件判断
)
SELECT * FROM temp;

-- 自上而下，获取员工等级结构

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

WITH RECURSIVE EmpHierarchy AS
(
	SELECT EmpID, EmpName, ManagerID, 1 AS Level
	FROM EmployeeVar WHERE JobPosition = 'CEO'
	UNION
	SELECT e1.EmpID, e1.EmpName, e1.ManagerID, temp1.Level + 1 AS Level
	FROM EmployeeVar AS e1
	JOIN EmpHierarchy AS temp1
	ON e1.managerID = temp1.EmpID
)
SELECT temp2.EmpID AS '员工工号', temp2.EmpName AS '员工姓名', e2.EmpName AS '上级姓名', temp2.Level AS '级别'
FROM EmpHierarchy AS temp2
LEFT JOIN EmployeeVar AS e2
ON e2.EmpID = temp2.ManagerID;




























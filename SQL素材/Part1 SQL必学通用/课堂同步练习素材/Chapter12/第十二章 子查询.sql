-- 查询高于全体员工平均工资的员工信息

-- SELECT * FROM Employee WHERE Salary > '全体员工平均工资'

-- 查询全体员工平均工资
-- 查询高于这个平均工资的员工信息

SELECT AVG(Salary) FROM Employee WHERE JobPosition != 'CEO'; -- 20916.666667
SELECT * FROM Employee WHERE Salary > 20916.666667 AND JobPosition != 'CEO';

SELECT * 
FROM Employee 
WHERE Salary > (
								SELECT AVG(Salary) 	-- 单行单列子查询
								FROM Employee 
								WHERE JobPosition != 'CEO'
								) 
			AND JobPosition != 'CEO';
		
-- 作为单独一张表
SELECT AVG(Salary) 	-- 单行单列子查询
FROM Employee 
WHERE JobPosition != 'CEO';

-- 子查询作为关联表之一
SELECT * FROM Employee AS e
INNER JOIN
(
	SELECT AVG(Salary) AS AvgSalary
	FROM Employee 
	WHERE JobPosition != 'CEO'
) AS temp
ON e.Salary > temp.AvgSalary
WHERE e.JobPosition != 'CEO';

-- 多行多列子查询

-- 查询各部门薪资最高的人员信息

-- 查询各个部门的最高薪资
-- 查询各部门薪资最高的人员信息

SELECT DeptID, MAX(Salary) AS MaxSalary	-- 多行多列子查询
FROM Employee
WHERE DeptID IS NOT NULL
	AND JobPosition != 'CEO'
GROUP BY DeptID;

SELECT * FROM Employee AS e
INNER JOIN
(
	SELECT DeptID, MAX(Salary) AS MaxSalary
	FROM Employee
	WHERE DeptID IS NOT NULL
		AND JobPosition != 'CEO'
	GROUP BY DeptID
) AS temp
ON
	e.DeptID = temp.DeptID
	AND e.Salary = temp.MaxSalary;
	
SELECT * FROM Employee AS e
WHERE (e.DeptID, e.Salary) IN
(
	SELECT DeptID, MAX(Salary) AS MaxSalary
	FROM Employee
	WHERE DeptID IS NOT NULL
		AND JobPosition != 'CEO'
	GROUP BY DeptID
);

-- 查询没有员工的部门的名称

-- 查询员工表中所有部门名称
-- 查询部门表中不存在员工的部门名称

SELECT DISTINCT DeptID FROM Employee	-- 多行单列子查询
WHERE DeptID IS NOT NULL;

SELECT * FROM Department
WHERE DeptID NOT IN (
	SELECT DISTINCT DeptID FROM Employee
	WHERE DeptID IS NOT NULL
);

-- 三种常用的子查询类型
-- 单行单列，本质就是一个值，经常会把它作为条件过滤的一部分
-- 多行多列，经常把它作为一张独立表和其他表进行关联查询
-- 多行单列，本质就是多个值，结合IN来进行使用

-- 查询高于所在部门平均薪资的员工信息

-- 查询各部门的平均薪资
-- 查询各部门的员工高于其所在部门的平均薪资的员工信息

SELECT DeptID, AVG(Salary) FROM Employee
WHERE DeptID IS NOT NULL
	AND JobPosition != 'CEO'
GROUP BY DeptID;

SELECT e.EmpName, e.Salary, e.DeptID, temp.DeptAvgSalary FROM Employee AS e
INNER JOIN
(
	SELECT DeptID, AVG(Salary) AS DeptAvgSalary FROM Employee
	WHERE DeptID IS NOT NULL
		AND JobPosition != 'CEO'
	GROUP BY DeptID
) AS temp
ON
	e.DeptID = temp.DeptID
	AND e.Salary > temp.DeptAvgSalary;
	
-- 关联子查询
-- 查询高于所在部门平均薪资的员工信息
SELECT e1.* 
FROM Employee AS e1 
WHERE e1.Salary > ( -- '所在部门的平均薪资' -- 获得某个员工的部门编号，e1.DeptID
	SELECT AVG(e2.Salary) 
	FROM Employee AS e2 
	WHERE e2.DeptID = e1.DeptID
);

-- 外部的Employee表，逐行查询每个员工数据
-- 定位到员工表的某条数据后，拿到这名员工所在的DeptID数据
-- 替换掉内部子查询中的e1.DeptID
-- 内部子查询计算出这名员工所在部门的平均薪资
-- 就可以把这名员工薪资和所在部门的平均薪资比较
	

-- 查询部门均薪高于公司均薪的部门名称（CEO除外）

-- 查询公司均薪
-- 查询各部门的均薪
-- 两个数值进行比较

SELECT AVG(Salary) AS AllAvgSalary
FROM Employee 
WHERE JobPosition != 'CEO';

SELECT DeptID, AVG(Salary) AS DeptAvgSalary
FROM Employee
WHERE JobPosition != 'CEO' AND DeptID IS NOT NULL
GROUP BY DeptID;

SELECT temp2.DeptID, temp2.DeptAvgSalary, temp1.AllAvgSalary FROM
(
	SELECT AVG(Salary) AS AllAvgSalary
	FROM Employee 
	WHERE JobPosition != 'CEO'
) AS temp1
JOIN
(
	SELECT DeptID, AVG(Salary) AS DeptAvgSalary
	FROM Employee
	WHERE JobPosition != 'CEO' AND DeptID IS NOT NULL
	GROUP BY DeptID
) AS temp2
ON
	temp2.DeptAvgSalary > temp1.AllAvgSalary;

SELECT d.DeptName AS '部门名称', ROUND(temp.DeptAvgSalary,2) AS '部门均薪', ROUND(temp.AllAvgSalary,2) AS '企业均薪'
FROM Department AS d
JOIN
(
	SELECT temp2.DeptID, temp2.DeptAvgSalary, temp1.AllAvgSalary FROM
	(
		SELECT AVG(Salary) AS AllAvgSalary
		FROM Employee 
		WHERE JobPosition != 'CEO'
	) AS temp1
	JOIN
	(
		SELECT DeptID, AVG(Salary) AS DeptAvgSalary
		FROM Employee
		WHERE JobPosition != 'CEO' AND DeptID IS NOT NULL
		GROUP BY DeptID
	) AS temp2
	ON
		temp2.DeptAvgSalary > temp1.AllAvgSalary
) AS temp
ON
	d.DeptID = temp.DeptID;

-- EXISTS与NOT EXISTS
-- 查询不存在员工的部门名称
SELECT * FROM Department AS d
WHERE NOT EXISTS(
	SELECT * FROM Employee AS e
	WHERE e.DeptID = d.DeptID
);

SELECT * FROM Department AS d
WHERE NOT EXISTS(
	SELECT 1 FROM Employee AS e
	WHERE e.DeptID = d.DeptID
);

-- 作为条件判断一部分 => WHERE中使用子查询
-- 作为关联表之一 => FROM中使用子查询
-- SELECT、HAVING、CREATE、INSERT、UPDATE、DELETE中都可以使用子查询

-- SELECT中使用子查询
-- 查询薪资高于公司均薪的员工信息（CEO除外），并在单独一列中说明

SELECT AVG(Salary) AS AllAvgSalary
FROM Employee
WHERE JobPosition != 'CEO';

SELECT *,(
	CASE
		WHEN Salary > (
			SELECT AVG(Salary) AS AllAvgSalary
			FROM Employee
			WHERE JobPosition != 'CEO'
		) THEN 'Higher Than Average Salary'
		WHEN Salary = (
			SELECT AVG(Salary) AS AllAvgSalary
			FROM Employee
			WHERE JobPosition != 'CEO'
		) THEN 'Equals Average Salary'
		ELSE 'Lower Than Average Salary'
	END
) AS CompareResult
FROM Employee
WHERE JobPosition != 'CEO'
ORDER BY CompareResult;

-- HAVING中使用子查询
-- 查询高于平均薪资的部门信息

SELECT AVG(Salary) AS AllAvgSalary
FROM Employee
WHERE JobPosition != 'CEO';

SELECT DeptID, AVG(Salary) AS DeptAvgSalary
FROM Employee
WHERE DeptID IS NOT NULL AND JobPosition != 'CEO'
GROUP BY DeptID
HAVING DeptAvgSalary > (
	SELECT AVG(Salary) AS AllAvgSalary 
	FROM Employee 
	WHERE JobPosition != 'CEO'
);

SELECT d.DeptName, ROUND(temp.DeptAvgSalary,2) FROM Department AS d 
INNER JOIN
	(
		SELECT DeptID, AVG(Salary) AS DeptAvgSalary
		FROM Employee
		WHERE DeptID IS NOT NULL AND JobPosition != 'CEO'
		GROUP BY DeptID
		HAVING DeptAvgSalary > (
			SELECT AVG(Salary) AS AllAvgSalary 
			FROM Employee 
			WHERE JobPosition != 'CEO'
		)
	) AS temp
ON
	d.DeptID = temp.DeptID;

-- CREATE中使用子查询
-- 创建一张新表，保存高于全体员工平均工资的员工信息

SELECT * 
FROM Employee 
WHERE Salary > (
								SELECT AVG(Salary) 	-- 单行单列子查询
								FROM Employee 
								WHERE JobPosition != 'CEO'
								) 
			AND JobPosition != 'CEO';
			
CREATE TABLE HighThanAvgSalaryEmp
(
	SELECT * 
	FROM Employee 
	WHERE Salary > (
									SELECT AVG(Salary) 	-- 单行单列子查询
									FROM Employee 
									WHERE JobPosition != 'CEO'
									) 
				AND JobPosition != 'CEO'
);

-- INSERT中子查询
DROP TABLE HighThanAvgSalaryEmp;

CREATE TABLE HighThanAvgSalaryEmp (
	EmpID INT,
	EmpName VARCHAR(50),
	Salary DECIMAL(10,2)
);

INSERT INTO HighThanAvgSalaryEmp
(
	SELECT e.EmpID, e.EmpName, e.Salary
	FROM Employee AS e
	WHERE Salary > (
									SELECT AVG(Salary) 	-- 单行单列子查询
									FROM Employee 
									WHERE JobPosition != 'CEO'
									) 
				AND JobPosition != 'CEO'
);

INSERT INTO HighThanAvgSalaryEmp
(
	SELECT e.EmpID, e.EmpName, e.Salary
	FROM Employee AS e
	WHERE Salary > (
									SELECT AVG(Salary) 	-- 单行单列子查询
									FROM Employee 
									WHERE JobPosition != 'CEO'
									) 
				AND JobPosition != 'CEO'
				AND NOT EXISTS (
					SELECT 1 FROM HighThanAvgSalaryEmp AS temp
					WHERE temp.EmpID = e.EmpID
				)
);

SELECT * FROM Employee;

UPDATE Employee SET Salary = 35000 WHERE EmpID = 8;

-- UPDATE中使用子查询
-- 员工涨薪，涨薪幅度为公司平均薪资的5%

SELECT AVG(Salary) FROM Employee
WHERE JobPosition != 'CEO';

-- MySQL中，UPDATE时，WHERE和SET无法使用子查询
UPDATE Employee
SET Salary = Salary + (
												SELECT AVG(Salary) * 0.05 FROM Employee
												WHERE JobPosition != 'CEO'
											)
WHERE JobPosition != 'CEO';

UPDATE Employee AS e
INNER JOIN
(
	SELECT AVG(Salary) AS AllAvgSalary 
	FROM Employee
	WHERE JobPosition != 'CEO'
) AS temp
SET e.Salary = e.Salary + temp.AllAvgSalary * 0.05
WHERE JobPosition != 'CEO';

-- DELETE中使用子查询
-- 删除没有员工的部门

DELETE FROM Department AS d
WHERE NOT EXISTS (
	SELECT 1 FROM Employee AS e
	WHERE e.DeptID = d.DeptID
);

-- 设置外键失效
SET FOREIGN_KEY_CHECKS = 0;

-- 设置外键生效
SET FOREIGN_KEY_CHECKS = 1;

DELETE FROM Department;

-- UNION与UNION ALL
-- 差一点：UNION会去重，UNION ALL则不会
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

(SELECT e.*, d.DeptName 
FROM Employee AS e INNER JOIN Department AS d
ON e.DeptID = d.DeptID)
UNION ALL
(SELECT e.*, d.DeptName 
FROM Employee AS e LEFT JOIN Department AS d
ON e.DeptID = d.DeptID)
UNION ALL
(SELECT e.*,d.DeptName
FROM Employee AS e RIGHT JOIN Department AS d
ON e.DeptID = d.DeptID);

-- 注意点1：列数量需保持一致
(SELECT e.*, d.DeptName 
FROM Employee AS e INNER JOIN Department AS d
ON e.DeptID = d.DeptID)
UNION
(SELECT e.*, d.DeptName, d.DeptID 
FROM Employee AS e LEFT JOIN Department AS d
ON e.DeptID = d.DeptID)
UNION
(SELECT e.*,d.DeptName
FROM Employee AS e RIGHT JOIN Department AS d
ON e.DeptID = d.DeptID);

-- 注意点2：列顺序需保持一致
(SELECT e.*, d.DeptName 
FROM Employee AS e INNER JOIN Department AS d
ON e.DeptID = d.DeptID)
UNION
(SELECT d.DeptName, e.* 
FROM Employee AS e LEFT JOIN Department AS d
ON e.DeptID = d.DeptID)
UNION
(SELECT e.*,d.DeptName
FROM Employee AS e RIGHT JOIN Department AS d
ON e.DeptID = d.DeptID)






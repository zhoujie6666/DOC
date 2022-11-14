-- IF函数，IF(条件,结果1,结果2)
SELECT IF( 5 > 2, 1, 2 );
SELECT IF( 5 < 2, 1, 2 );

USE chapter10;

-- 基于员工薪资划分等级，低于20000元，低薪资级别，否则，设置为高薪资级别
SELECT *,IF(Salary < 20000, 'LOW', 'HIGH') AS SAL_GRADE FROM Employee ORDER BY SAL_GRADE;

-- 基于员工薪资划分等级，低于20000元，低薪资级别，如果大于20000元，但是低于25000，中等薪资级别，大于25000，高等薪资级别
SELECT *,IF(Salary < 20000, 'LOW', IF(Salary <= 25000, 'MEDIUM', 'HIGH')) AS SAL_GRADE FROM Employee ORDER BY SAL_GRADE;

-- 统计低中高三个级别人员数量
SELECT COUNT(*),IF(Salary < 20000, 'LOW', IF(Salary <= 25000, 'MEDIUM', 'HIGH')) AS SAL_GRADE FROM Employee GROUP BY SAL_GRADE;

-- CASE函数
-- 基于员工薪资划分等级，低于20000元，低薪资级别，否则，设置为高薪资级别
SELECT *,
(CASE
	WHEN Salary < 20000 THEN 'LOW'
	ELSE 'HIGH'
END) AS SAL_GRADE
FROM Employee
ORDER BY SAL_GRADE;

-- 基于员工薪资划分等级，低于20000元，低薪资级别，如果大于20000元，但是低于25000，中等薪资级别，大于25000，高等薪资级别
SELECT *,
(CASE
	WHEN Salary < 20000 THEN 'LOW'
	WHEN Salary <= 25000 THEN 'MEDIUM'
	ELSE 'HIGH'
END) AS SAL_GRADE
FROM Employee
ORDER BY SAL_GRADE;

-- 统计低中高三个级别人员数量
SELECT COUNT(*),
(CASE
	WHEN Salary < 20000 THEN 'LOW'
	WHEN Salary <= 25000 THEN 'MEDIUM'
	ELSE 'HIGH'
END) AS SAL_GRADE
FROM Employee
GROUP BY SAL_GRADE;

-- Employee表，展示时相加一个DepartmentName字段
SELECT *,(CASE JobPosition
	WHEN '开发人员' THEN '开发部'
	WHEN '顾问' THEN '咨询部'
	WHEN '业务经理' THEN '管理部'
	ELSE '其他部门'
END) AS DepartmentName
FROM Employee
ORDER BY DepartmentName;

-- CASE转置应用
DROP TABLE IF EXISTS OrderInfo;

CREATE TABLE OrderInfo(
	CustomerName VARCHAR(50),
	Month VARCHAR(10),
	Amount INT
);

INSERT INTO OrderInfo VALUES('张三','1月',50),('张三','2月',100),('张三','3月',200),
('李四','1月',70),('李四','2月',100),('李四','3月',150),
('王五','1月',200),('王五','2月',300),('王五','3月',800);

SELECT * FROM OrderInfo;

-- CASE过渡处理
SELECT CustomerName AS Customer,
(CASE WHEN Month = '1月' THEN Amount ELSE 0 END) AS '1月',
(CASE WHEN Month = '2月' THEN Amount ELSE 0 END) AS '2月',
(CASE WHEN Month = '3月' THEN Amount ELSE 0 END) AS '3月'
FROM OrderInfo;

-- GROUP BY汇总求和
SELECT CustomerName AS Customer,
SUM(CASE WHEN Month = '1月' THEN Amount ELSE 0 END) AS '1月',
SUM(CASE WHEN Month = '2月' THEN Amount ELSE 0 END) AS '2月',
SUM(CASE WHEN Month = '3月' THEN Amount ELSE 0 END) AS '3月'
FROM OrderInfo
GROUP BY Customer;















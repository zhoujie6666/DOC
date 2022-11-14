-- COUNT，计数，COUNT(*)常用
SELECT COUNT(*) FROM Employee;
SELECT COUNT(*) FROM Employee WHERE Gender = '男';
SELECT COUNT(*) FROM Employee WHERE Age <= 30;

-- MAX，最大值
SELECT MAX(Age) FROM Employee;
SELECT MAX(Salary) FROM Employee WHERE JobPosition = '业务经理';

-- MIN，最小值
SELECT MIN(Age) FROM Employee;
SELECT MIN(Salary) FROM Employee WHERE Gender = '男';

-- SUM，求和
SELECT SUM(Salary) FROM Employee;
SELECT ROUND(SUM(Salary) / COUNT(*),2) FROM Employee;

-- AVG，平均值
SELECT ROUND(AVG(Salary),2) FROM Employee;
SELECT AVG(Age) FROM Employee;
SELECT AVG(Age), AVG(Salary) FROM Employee;

-- DISTINCT结合聚合函数一起使用
SELECT COUNT(DISTINCT JobPosition) FROM Employee;
SELECT DISTINCT JobPosition FROM Employee;

-- 聚合函数，遇到NULL，进行忽略
SELECT * FROM Employee WHERE EmployeeID <= 3;
-- 29,29,26，平均值：28
SELECT AVG(Age) FROM Employee WHERE EmployeeID <= 3;
UPDATE Employee SET Age = NULL WHERE EmployeeID = 2;
-- 如果没有忽略NULL，(29 + 26) / 3
-- 如果忽略NULL，(29 + 26) / 2 = 27.5

SELECT SUM(Age) FROM Employee WHERE EmployeeID <= 3;
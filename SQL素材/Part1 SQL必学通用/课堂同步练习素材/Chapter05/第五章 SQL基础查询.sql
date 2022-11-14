CREATE DATABASE chapter05;

-- 算数运算
SELECT Name AS "姓名",Salary AS "当前薪资",Salary + 1000 AS "涨薪后" FROM Employee;
SELECT Name AS "姓名",Salary AS "月薪",Salary * 13 AS "年薪" FROM Employee;

-- 数据拼接（CONCAT，CONCAT_WS） WITH SEPARATOR
SELECT CONCAT(Name,Gender,Age) FROM Employee;
SELECT CONCAT(Name,', ',Gender,', ',Age) AS "员工基本信息" FROM Employee;
SELECT CONCAT_WS(', ',Name,Gender,Age,JobPosition) AS "员工基本信息" FROM Employee;

-- 数据排序（ORDER BY） 默认是ASC
SELECT EmployeeID, Name, Salary FROM Employee ORDER BY Salary DESC;
SELECT EmployeeID, Name, Age, Salary FROM Employee ORDER BY Salary DESC, Age ASC;

-- 限制行数（LIMIT），第一个数字：从X条数据开始，第二个数字：展示的数据条数
SELECT EmployeeID, Name, Age, Salary FROM Employee ORDER BY Salary DESC, Age ASC LIMIT 10;
SELECT EmployeeID, Name, Age, Salary FROM Employee ORDER BY Salary DESC, Age ASC LIMIT 0, 10;
SELECT EmployeeID, Name, Age, Salary FROM Employee ORDER BY Salary DESC, Age ASC LIMIT 10, 10;

-- 数据去重（DISTINCT）
SELECT Name, Gender, Age FROM Employee;
SELECT DISTINCT Gender FROM Employee;
SELECT DISTINCT Age FROM Employee ORDER BY Age;
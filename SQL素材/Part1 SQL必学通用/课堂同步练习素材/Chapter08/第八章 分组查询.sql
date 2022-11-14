-- 统计各岗位的员工平均薪资
SELECT AVG(Salary) FROM Employee;
-- 分组，GROUP BY
SELECT JobPosition, AVG(Salary) FROM Employee WHERE EmployeeID <= 10 GROUP BY JobPosition;
-- 能不能查询分组之外的字段
SELECT Name, JobPosition, AVG(Salary) FROM Employee WHERE EmployeeID <= 10 GROUP BY JobPosition;

SELECT JobPosition, AVG(Age) FROM Employee GROUP BY JobPosition;

SELECT Gender, COUNT(*) FROM Employee GROUP BY Gender;

-- 查询各岗位，不同性别的人员数量
SELECT 
JobPosition, Gender, COUNT(*), ROUND(AVG(Salary),2)
FROM Employee 
WHERE EmployeeID <= 10
GROUP BY JobPosition, Gender 
ORDER BY JobPosition, Gender;

-- WHERE针对表数据进行过滤，HAVING针对分组后的数据进行过滤
SELECT Gender, COUNT(*) FROM Employee GROUP BY Gender HAVING Gender = '男';
SELECT Gender, COUNT(*) FROM Employee WHERE Gender = '男' GROUP BY Gender;

SELECT Age, ROUND(AVG(Salary),2) FROM Employee GROUP BY Age HAVING Age >= 30 ORDER BY Age;
SELECT Age, ROUND(AVG(Salary),2) FROM Employee WHERE Age >= 30 GROUP BY Age ORDER BY Age; 

-- 查看不同年龄平均薪资，均薪21000元以上的年龄组的数据
SELECT Age, ROUND(AVG(Salary),0) FROM Employee GROUP BY Age HAVING AVG(Salary) >= 21000 ORDER BY Age;
SELECT Age, ROUND(AVG(Salary),0) AS AVG_Salary FROM Employee GROUP BY Age HAVING AVG_Salary >= 21000 ORDER BY Age;

-- 查看开发人员，不同年龄段的平均薪资，并且只查看平均薪资高于21000元年龄分组数据
SELECT 
Age, ROUND(AVG(Salary),0) AS AVG_Salary 
FROM Employee 
WHERE JobPosition = '开发人员' 
GROUP BY Age 
HAVING AVG_Salary >= 21000 
ORDER BY Age;

-- 查询语句的执行顺序
SELECT 
Age, ROUND(AVG(Salary),0)  AS AVG_Salary
FROM Employee 
WHERE JobPosition = '开发人员' 
GROUP BY Age 
HAVING AVG_Salary >= 21000
ORDER BY Age DESC
LIMIT 3;

-- 通过FROM获取表数据
SELECT * FROM Employee;

-- 通过WHERE条件进行数据过滤
SELECT * FROM Employee WHERE JobPosition = '开发人员';

-- 针对过滤后数据进行分组（GROUP BY），执行聚合函数
SELECT ROUND(AVG(Salary),0) AS AVG_Salary FROM Employee WHERE JobPosition = '开发人员' GROUP BY Age;

-- 针对分组查询的结果，通过HAVING进行二次过滤
SELECT ROUND(AVG(Salary),0) AS AVG_Salary FROM Employee WHERE JobPosition = '开发人员' GROUP BY Age HAVING AVG_Salary >= 21000;

-- 针对SELECT后的查询内容进行处理展示
SELECT Age, ROUND(AVG(Salary),0) AS AVG_Salary FROM Employee WHERE JobPosition = '开发人员' GROUP BY Age HAVING AVG_Salary >= 21000;

-- 就需要针对Age字段来排序（ORDER BY）
SELECT Age, ROUND(AVG(Salary),0) AS AVG_Salary FROM Employee WHERE JobPosition = '开发人员' GROUP BY Age HAVING AVG_Salary >= 21000 ORDER BY Age;

-- 针对排序结果，限制展示条数（LIMIT）
SELECT Age, ROUND(AVG(Salary),0) AS AVG_Salary FROM Employee WHERE JobPosition = '开发人员' GROUP BY Age HAVING AVG_Salary >= 21000 ORDER BY Age LIMIT 3;

-- FROM -> WHERE -> GROUP BY -> 聚合函数 -> HAVING -> SELECT -> DISTINCT -> ORDER BY -> LIMIT

-- GROUP_CONCAT函数

SELECT Age,GROUP_CONCAT(Name) FROM Employee WHERE JobPosition = '开发人员' GROUP BY Age;

-- WITH ROLLUP
SELECT JobPosition,Gender,COUNT(*),SUM(Salary) FROM Employee GROUP BY JobPosition, Gender ORDER BY JobPosition, Gender;
SELECT JobPosition,COUNT(*),SUM(Salary) FROM Employee GROUP BY JobPosition ORDER BY JobPosition;
SELECT COUNT(*),SUM(Salary) FROM Employee;

SELECT JobPosition,Gender,COUNT(*),SUM(Salary) FROM Employee GROUP BY JobPosition, Gender WITH ROLLUP;
SELECT JobPosition,Gender,COUNT(*),AVG(Salary) FROM Employee GROUP BY JobPosition, Gender WITH ROLLUP;






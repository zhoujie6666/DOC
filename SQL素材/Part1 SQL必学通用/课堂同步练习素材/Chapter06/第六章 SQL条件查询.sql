-- 比较运算查询（>、<、>=、<=、=、!=、<>）
SELECT * FROM Employee WHERE EmployeeID = 10;
SELECT * FROM Employee WHERE Age = 33;
SELECT * FROM Employee WHERE Age != 33;
SELECT * FROM Employee WHERE Age <> 33;
SELECT * FROM Employee WHERE Age > 30;
SELECT * FROM Employee WHERE Age < 30;
SELECT * FROM Employee WHERE Age >= 30;
SELECT * FROM Employee WHERE Age <= 30;

SELECT * FROM Employee WHERE Salary > 20000;
SELECT * FROM Employee WHERE JobPosition = '开发人员';
SELECT * FROM Employee WHERE JoinedAt > '2022-01-01';

-- 逻辑运算查询（AND、OR、NOT）
-- AND，与，所有条件必须都要成立
-- 5年以上工作经验，年龄35岁以下
-- OR，或，所有条件只要有一个成立
-- 5年以上工作经验，年龄30岁以下
-- NOT，非
-- 5年以下工作经验，不考虑
SELECT * FROM Employee WHERE Age >= 30 AND Salary > 20000;
SELECT * FROM Employee WHERE Age >= 30 AND Salary > 20000 AND Gender = '男';
SELECT * FROM Employee WHERE Age >= 30 OR Salary > 20000;
SELECT * FROM Employee WHERE NOT (Age >= 30 AND Salary > 20000);

-- 范围查询（IN、NOT IN）（BETWEEN AND）
SELECT * FROM Employee WHERE Age IN (32,34,36);
SELECT * FROM Employee WHERE Age = 32 OR Age = 33 OR Age = 34;
SELECT * FROM Employee WHERE Age NOT IN (32,33,34);

SELECT * FROM Employee WHERE JobPosition IN ('开发人员', '顾问');
SELECT * FROM Employee WHERE JobPosition = '开发人员' OR JobPosition = '顾问';

SELECT * FROM Employee WHERE Age BETWEEN 32 AND 34;
SELECT * FROM Employee WHERE JoinedAt BETWEEN '2020-01-01' AND '2020-04-01';

-- 空值查询（IS NULL、IS NOT NULL）
SELECT * FROM Employee WHERE JoinedAt IS NULL;
SELECT * FROM Employee WHERE JoinedAt IS NOT NULL;

-- 模糊查询（LIKE）（%，任意多个字符，0个、1个或多个）（_，单个字符）
SELECT * FROM Employee WHERE Name LIKE '杨%';
SELECT * FROM Employee WHERE Name LIKE '杨_';
SELECT * FROM EMployee WHERE Name LIKE '%国%';
SELECT * FROM EMployee WHERE Name LIKE '___';







DROP DATABASE IF EXISTS chapter15;

-- 创建数据库
CREATE DATABASE IF NOT EXISTS chapter15;

USE chapter15;

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

-- 查询各部门高于部门平均薪资的员工信息
SELECT e.*, temp.DeptAvgSalary
FROM Employee AS e
INNER JOIN 
(
	SELECT DeptID, AVG(Salary) AS DeptAvgSalary 
	FROM Employee 
	WHERE DeptID IS NOT NULL
		AND JobPosition != 'CEO'
	GROUP BY DeptID
) AS temp
ON 
	e.DeptID = temp.DeptID 
	AND e.Salary > temp.DeptAvgSalary;
	
-- 视图，VIEW
-- 视图是基于SELECT创建的虚拟表，不存储任何数据，可动态查询最新的数据
-- 使用视图可简化复杂SQL语句的查询

-- 创建视图，CREATE VIEW
CREATE VIEW HigherThanDeptAvgSalary
AS
(
	SELECT e.*, temp.DeptAvgSalary
	FROM Employee AS e
	INNER JOIN 
	(
		SELECT DeptID, AVG(Salary) AS DeptAvgSalary 
		FROM Employee 
		WHERE DeptID IS NOT NULL
			AND JobPosition != 'CEO'
		GROUP BY DeptID
	) AS temp
	ON 
		e.DeptID = temp.DeptID 
		AND e.Salary > temp.DeptAvgSalary
);

-- 查看视图
SHOW TABLES;

-- 查看视图内容
SELECT * FROM HigherThanDeptAvgSalary;

-- 可动态查询最新的数据
SELECT * FROM Employee;
UPDATE Employee SET Salary = 50000 WHERE EmpID = 4;
SELECT * FROM HigherThanDeptAvgSalary;

-- 修改VIEW
CREATE OR REPLACE VIEW HigherThanDeptAvgSalary
AS
(
	SELECT e.EmpName AS '员工姓名', e.Salary AS '员工薪资', ROUND(temp.DeptAvgSalary, 2) AS '部门均薪'
	FROM Employee AS e
	INNER JOIN 
	(
		SELECT DeptID, AVG(Salary) AS DeptAvgSalary 
		FROM Employee 
		WHERE DeptID IS NOT NULL
			AND JobPosition != 'CEO'
		GROUP BY DeptID
	) AS temp
	ON 
		e.DeptID = temp.DeptID 
		AND e.Salary > temp.DeptAvgSalary
);

SELECT * FROM HigherThanDeptAvgSalary;

-- 删除VIEW
DROP VIEW HigherThanDeptAvgSalary;

-- 重新创建VIEW
CREATE VIEW HigherThanDeptAvgSalary
AS
(
	SELECT e.EmpName AS '员工姓名', e.Salary AS '员工薪资', ROUND(temp.DeptAvgSalary, 2) AS '部门均薪'
	FROM Employee AS e
	INNER JOIN 
	(
		SELECT DeptID, AVG(Salary) AS DeptAvgSalary 
		FROM Employee 
		WHERE DeptID IS NOT NULL
			AND JobPosition != 'CEO'
		GROUP BY DeptID
	) AS temp
	ON 
		e.DeptID = temp.DeptID 
		AND e.Salary > temp.DeptAvgSalary
);

SELECT * FROM HigherThanDeptAvgSalary;

-- 索引
-- 数据量大，高频查询，使用索引，可加快查询的速度
-- 数据量小，或者低频查询，没有必要使用索引
-- 构建索引，占用磁盘空间，并且构建索引也需要划分很多时间
-- 构建索引，会降低增删改的速度
-- 主键，自动被设置为索引

DROP TABLE IF EXISTS TestIndex;

-- 创建表
CREATE TABLE IF NOT EXISTS TestIndex(
	Num1 INT,
	Num2 INT
);

-- 插入1000万条数据
DROP PROCEDURE IF EXISTS InsertNums;
CREATE PROCEDURE InsertNums(count INT)  
BEGIN  
		DECLARE num1 INT DEFAULT 1;
		DECLARE num2 INT DEFAULT 101;
		SET AUTOCOMMIT = 0;       
		WHILE num1 <= count 
		DO  
				INSERT INTO TestIndex VALUES(num1, num2);  
				SET num1 = num1 + 1;  
				SET num2 = num2 + 1;  
		END WHILE;
		SET AUTOCOMMIT=1;       
END;

CALL InsertNums(10000000);

SELECT * FROM TestIndex WHERE Num1 = 5123455; -- 10.567s
SELECT * FROM TestIndex WHERE Num2 = 5123555; -- 8.017s
SELECT * FROM TestIndex WHERE Num1 = 5123455 AND Num2 = 5123555; -- 6.687s

-- 创建索引
CREATE INDEX idx_testindex_num1 ON TestIndex(Num1); -- 25.663s

SELECT * FROM TestIndex WHERE Num1 = 5123455; -- 0.044s
SELECT * FROM TestIndex WHERE Num2 = 5123555; -- 5.881s
SELECT * FROM TestIndex WHERE Num1 = 5123455 AND Num2 = 5123555; -- 0.045s

CREATE INDEX idx_testindex_num2 ON TestIndex(Num2); -- 22.592s
CREATE INDEX idx_testindex_num1_num2 ON TestIndex(Num1, Num2); -- 25.380s

-- 查看表相关索引信息
SHOW INDEX FROM TestIndex;

SELECT * FROM TestIndex WHERE Num1 = 5123455; -- 0.044s
SELECT * FROM TestIndex WHERE Num2 = 5123555; -- 0.035s
SELECT * FROM TestIndex WHERE Num1 = 5123455 AND Num2 = 5123555; -- 0.034s

-- 删除索引
DROP INDEX idx_testindex_num1 ON TestIndex;
DROP INDEX idx_testindex_num2 ON TestIndex;
DROP INDEX idx_testindex_num1_num2 ON TestIndex;

-- 事务

CREATE TABLE User(
	UID INT PRIMARY KEY AUTO_INCREMENT,
	UserName VARCHAR(20)
);

-- AUTOCOMMIT，自动提交
SELECT @@AUTOCOMMIT;

-- 执行新增、修改、删除SQL语句，立刻影响到数据库中数据
INSERT INTO USER VALUES(NULL, '张三');

-- 关闭自动提交
-- 执行新增、修改、删除SQL语句，不会立即影响到数据库中数据
SET AUTOCOMMIT = 0;

INSERT INTO User VALUES(Null, '李四');

SELECT * FROM User;

-- 设置自动提交
SET AUTOCOMMIT = 1;

-- 场景一
-- 开启事务，相当于设置SET AUTOCOMMIT = 0
START TRANSACTION;

INSERT INTO User VALUES(NULL, '王五'),(NULL, '赵六');

SELECT * FROM User;

-- 提交
COMMIT;

-- 场景二
START TRANSACTION;

UPDATE User SET UserName = '张三三' WHERE UID = 1;

INSERT INTO User VALUES(NULL, '孙七');

DELETE FROM User WHERE UID = 2;

SELECT * FROM User;

-- 回退
ROLLBACK;

-- 场景三
START TRANSACTION;

UPDATE User SET UserName = '张三三' WHERE UID = 1;

INSERT INTO User VALUES(NULL, '孙七');

DELETE FROM User WHERE UID = 2;

SELECT * FROM User;

COMMIT;

-- 提交后，回滚无意义
ROLLBACK;

-- 场景四
-- SAVEPOINT，保存点
START TRANSACTION;

SAVEPOINT insertData;

INSERT INTO User VALUES(Null, '周八');

SAVEPOINT updateData;

UPDATE User SET UserName = '吴九' WHERE UserName = '周八';

SAVEPOINT deleteData;

DELETE FROM User WHERE UserName = '吴九';

SELECT * FROM User;

ROLLBACK TO updateData;

COMMIT;

-- 银行转账场景

DROP TABLE IF EXISTS Account;

CREATE TABLE Account (
	ID INT PRIMARY KEY AUTO_INCREMENT,
	Name VARCHAR(50) NOT NULL,
	Money DECIMAL(15,2) NOT NULL
);

INSERT INTO Account VALUES(NULL,'zhangsan',100000),(NULL,'lisi',200000);

-- zhangsan欠lisi钱，10000元
UPDATE Account SET Money = Money - 10000 WHERE Name = 'zhangsan';
UPDATE Account SET Money = Money + 10000 WHERE Name = 'lisi2';

SELECT * FROM Account;

START TRANSACTION;
UPDATE Account SET Money = Money - 10000 WHERE Name = 'zhangsan';
UPDATE Account SET Money = Money + 10000 WHERE Name = 'lisi';
-- 基于执行结果，全部顺利执行，COMMIT
COMMIT;
-- 否则，ROLLBACK
ROLLBACK;

-- 事务的四大特性：ACID
-- A，原子性，要么全部成功，要么全部失败
-- C，一致性，数据在事务执行前后需保持一致
-- I，隔离性，事务提交之前，其他事务不可见
-- D，持久性，数据操作，持久有效


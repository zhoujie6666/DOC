CREATE DATABASE chapter03;

USE chapter03;

-- 创建数据表
CREATE TABLE Employees(
	EmployeeID CHAR(9),
	Name VARCHAR(50),
	Gender ENUM('男','女'),
	Age INT UNSIGNED,
	JobPosition ENUM('业务经理','开发人员','顾问'),
	Salary DECIMAL(10,2),
	JoinedAt DATETIME,
	Address TEXT
);

-- 查看表结构
DESC Employees;

-- 查看表创建语句
SHOW CREATE TABLE Employees;

-- 删除表
DROP TABLE Employees;

-- 全字段插入（插入值必须与表字段顺序完全一致）,Tab
INSERT INTO Employees 
VALUES(
	'EMP-00001',
	'张三',
	'男',
	34,
	'业务经理',
	20000,
	'2000-01-15 15:00:00',
	'上海市'
	);
	
-- 部分字段插入（插入值必须与指定字段顺序完全一致）
INSERT INTO Employees(EmployeeID,Gender,Name,Age,JobPosition,Salary)
VALUES('EMP-00002','女','李四',28,'开发人员',15000);

-- 全字段一次插入多行数据
INSERT INTO Employees VALUES
	('EMP-00003','王五','男',25,'开发人员',10000,'2015-07-28 13:00:00','北京市'),
	('EMP-00004','赵六','女',32,'顾问',8000,'2019-11-12','杭州市'),
	('EMP-00005','孙七','女',29,'顾问',9000,'2021-10-13','南京市');

-- 部分字段一次插入多行数据
INSERT INTO Employees(EmployeeID,Name,Gender,Age,JobPosition,Salary) 
VALUES
	('EMP-00006','周八','男',28,'开发人员',20000),
	('EMP-00007','杨九','女',33,'顾问',7500);
	
-- 测试数据，验证数据类型对字段内容的限制
INSERT INTO Employees VALUES
	('EMP-00008','郑十','男',34,'业务经理',23000,'2012-01-18','上海市');
INSERT INTO Employees VALUES
	('EMP-00008','郑十','男',-34,'业务经理',23000,'2012-01-18','上海市');
INSERT INTO Employees VALUES
	('EMP-00008','郑十','男',34,'经理',23000,'2012-01-18','上海市');
INSERT INTO Employees VALUES
	('EMP-000081','郑十','男',34,'业务经理',23000,'2012-01-18','上海市');
	
DROP TABLE Employees;

-- NOT NULL，非空限制
CREATE TABLE Employees(
	EmployeeID CHAR(9) NOT NULL,
	Name VARCHAR(50) NOT NULL,
	Gender ENUM('男','女'),
	Age INT UNSIGNED,
	JobPosition ENUM('业务经理','开发人员','顾问') NOT NULL,
	Salary DECIMAL(10,2) NOT NULL,
	JoinedAt DATETIME,
	Address TEXT
);

INSERT INTO Employees VALUES('EMP-00001','张三',NULL,NULL,'业务经理',20000,NULL,NULL);
INSERT INTO Employees(EmployeeID,Name,JobPosition,Salary) VALUES
('EMP-00002','李四','开发人员',15000);
INSERT INTO Employees(EmployeeID,Name,JobPosition) VALUES
('EMP-00003','王五','开发人员');

DROP TABLE Employees;

-- Default，默认值
CREATE TABLE Employees(
	EmployeeID CHAR(9) NOT NULL,
	Name VARCHAR(50) NOT NULL,
	Gender ENUM('男','女'),
	Age INT UNSIGNED,
	JobPosition ENUM('业务经理','开发人员','顾问') NOT NULL,
	Salary DECIMAL(10,2) NOT NULL Default 0,
	JoinedAt DATETIME,
	Address TEXT
);

INSERT INTO Employees(EmployeeID,Name,JobPosition) VALUES
('EMP-00003','王五','开发人员');
INSERT INTO Employees(EmployeeID,Name,JobPosition) VALUES
('EMP-00002','李四','开发人员',15000);

DROP TABLE Employees;

-- UNIQUE，唯一性
CREATE TABLE Employees(
	EmployeeID CHAR(9) NOT NULL UNIQUE,
	Name VARCHAR(50) NOT NULL,
	Gender ENUM('男','女'),
	Age INT UNSIGNED,
	JobPosition ENUM('业务经理','开发人员','顾问') NOT NULL,
	Salary DECIMAL(10,2) NOT NULL Default 0,
	JoinedAt DATETIME,
	Address TEXT
);

INSERT INTO Employees(EmployeeID,Name,JobPosition) VALUES
('EMP-00001','张三','业务经理'),
('EMP-00001','李四','开发人员');

INSERT INTO Employees(EmployeeID,Name,JobPosition) VALUES
('EMP-00001','张三','业务经理'),
('EMP-00002','李四','开发人员');

DROP TABLE Employees;

-- AUTO_INCREMENT，自动增长
CREATE TABLE Employees(
	EmployeeID INT NOT NULL UNIQUE AUTO_INCREMENT,
	Name VARCHAR(50) NOT NULL,
	Gender ENUM('男','女'),
	Age INT UNSIGNED,
	JobPosition ENUM('业务经理','开发人员','顾问') NOT NULL,
	Salary DECIMAL(10,2) NOT NULL Default 0,
	JoinedAt DATETIME,
	Address TEXT
);

INSERT INTO Employees(Name,JobPosition) VALUES
('张三','业务经理'),
('李四','开发人员');

INSERT INTO Employees(Name,JobPosition) VALUES
('王五','顾问');

DROP TABLE Employees;

-- PRMARY KEY，设置主键
CREATE TABLE Employees(
	EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
	Name VARCHAR(50) NOT NULL,
	Gender ENUM('男','女'),
	Age INT UNSIGNED,
	JobPosition ENUM('业务经理','开发人员','顾问') NOT NULL,
	Salary DECIMAL(10,2) NOT NULL Default 0,
	JoinedAt DATETIME,
	Address TEXT
);

DESC Employees;

CREATE TABLE Employees(
	EmployeeID INT AUTO_INCREMENT,
	Name VARCHAR(50) NOT NULL,
	Gender ENUM('男','女'),
	Age INT UNSIGNED,
	JobPosition ENUM('业务经理','开发人员','顾问') NOT NULL,
	Salary DECIMAL(10,2) NOT NULL Default 0,
	JoinedAt DATETIME,
	Address TEXT,
	PRIMARY KEY(EmployeeID)
);

-- 主键字段，插入数据，可以使用NULL占位，也可以直接忽略字段
INSERT INTO Employees(EmployeeID,Name,JobPosition) VALUES
(NULL,'张三','业务经理');

INSERT INTO Employees(Name,JobPosition) VALUES
('李四','开发人员'),
('王五','顾问');

-- 删除表
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Department;

-- 创建表
CREATE TABLE IF NOT EXISTS Department(
	DeptID INT PRIMARY KEY AUTO_INCREMENT,
	DeptName VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO Department(DeptName) VALUES
('管理部'),('开发部'),('咨询部');

CREATE TABLE IF NOT EXISTS Employees(
	EmployeeID INT AUTO_INCREMENT,
	Name VARCHAR(50) NOT NULL,
	Gender ENUM('男','女'),
	Age INT UNSIGNED,
	JobPosition ENUM('业务经理','开发人员','顾问') NOT NULL,
	Salary DECIMAL(10,2) NOT NULL Default 0,
	JoinedAt DATETIME,
	Address TEXT,
	DeptID INT NOT NULL,
	PRIMARY KEY(EmployeeID),
	FOREIGN KEY(DeptID) REFERENCES Department(DeptID)
);

INSERT INTO Employees(Name,JobPosition,DeptID) VALUES
('张三','业务经理',1);

INSERT INTO Employees(Name,JobPosition,DeptID) VALUES
('李四','开发人员',2),
('王五','开发人员',2);

INSERT INTO Employees(Name,JobPosition,DeptID) VALUES
('赵六','顾问',3);

-- 修改表名称
ALTER TABLE Employees RENAME TO Employee;

-- 修改字段名称
ALTER TABLE Employee CHANGE COLUMN JoinedAt HireDate DATETIME;

DESC Employee;

-- 修改字段数据类型和约束
ALTER TABLE Employee MODIFY COLUMN Name VARCHAR(30);

-- 添加字段（Birthday）
ALTER TABLE Employee ADD COLUMN Birthday DATE;

-- 删除字段
ALTER TABLE Employee DROP COLUMN Birthday;

-- 删除主键
ALTER TABLE Employee DROP PRIMARY KEY;
-- 去除AUTO_INCREMENT限制
ALTER TABLE Employee MODIFY COLUMN EmployeeID INT;

-- 添加主键
ALTER TABLE Employee ADD PRIMARY KEY(EmployeeID);
-- 重新添加AUTO_INCREMENT
ALTER TABLE Employee MODIFY COLUMN EmployeeID INT AUTO_INCREMENT;

-- 删除外键
ALTER TABLE Employee DROP FOREIGN KEY employee_ibfk_1;

-- 添加外键
ALTER TABLE Employee ADD FOREIGN KEY(DeptID) REFERENCES Department(DeptID);

SHOW CREATE TABLE Employee;
DROP DATABASE IF EXISTS chapter16;

CREATE DATABASE IF NOT EXISTS chapter16;

USE chapter16;

DROP TABLE IF EXISTS Score;
DROP TABLE IF EXISTS Exam;
DROP TABLE IF EXISTS Teacher;
DROP TABLE IF EXISTS Subject;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Class;

CREATE TABLE IF NOT EXISTS Subject(
	SubjectID INT PRIMARY KEY AUTO_INCREMENT,
	SubjectName VARCHAR(30) NOT NULL
) AUTO_INCREMENT = 2001;

INSERT INTO Subject(SubjectName) VALUES('MySQL'),('SQL Server'),('Oracle');

CREATE TABLE IF NOT EXISTS Class(
	ClassID INT PRIMARY KEY AUTO_INCREMENT,
	ClassName VARCHAR(30) NOT NULL
) AUTO_INCREMENT = 5001;

INSERT INTO Class(ClassName) VALUES('计算机一班'),('计算机二班'),('计算机三班');

CREATE TABLE IF NOT EXISTS Student(
	StudentID INT PRIMARY KEY AUTO_INCREMENT,
	StudentName VARCHAR(30) NOT NULL,
	ClassID INT NOT NULL,
	FOREIGN KEY(ClassID) REFERENCES Class(ClassID)
) AUTO_INCREMENT = 1001;

INSERT INTO Student(StudentName, ClassID) VALUES('张三',5001),('李四',5001),('王五',5002);

CREATE TABLE IF NOT EXISTS Teacher(
	TeacherID INT PRIMARY KEY AUTO_INCREMENT,
	TeacherName VARCHAR(30) NOT NULL,
	SubjectID INT NOT NULL,
	FOREIGN KEY(SubjectID) REFERENCES Subject(SubjectID)
) AUTO_INCREMENT = 3001;

INSERT INTO Teacher(TeacherName, SubjectID) VALUES('张吉',2001),('谢彦',2002),('傅智翔',2003);

CREATE TABLE IF NOT EXISTS Exam(
	ExamID INT PRIMARY KEY AUTO_INCREMENT,
	ExamName VARCHAR(30) NOT NULL,
	TotalMark INT NOT NULL
) AUTO_INCREMENT = 4001;

INSERT INTO Exam(ExamName,TotalMark) 
VALUES
('MySQL 试卷I',100),
('MySQL 试卷II',120),
('SQL Server 试卷I',120),
('SQL Server 试卷II',150),
('Oracle 试卷I',120),
('Oracle 试卷II',150);

CREATE TABLE IF NOT EXISTS Score(
	StudentID INT,
	SubjectID INT,
	ExamID INT,
	Marks INT,
	PRIMARY KEY(StudentID, SubjectID, ExamID),
	FOREIGN KEY(StudentID) REFERENCES Student(StudentID),
	FOREIGN KEY(SubjectID) REFERENCES Subject(SubjectID),
	FOREIGN KEY(ExamID) REFERENCES Exam(ExamID)
);

INSERT INTO Score 
VALUES
(1001,2001,4001,100),
(1001,2002,4003,95),
(1002,2002,4004,88),
(1003,2003,4006,97);

-- 查询学生姓名、班级名称、学科名字、对应老师姓名、参与测试试卷名称、分数（基于100分计算）
SELECT Student.StudentName,Class.ClassName,Subject.SubjectName,Teacher.TeacherName,Exam.ExamName,ROUND((Score.Marks / Exam.TotalMark)*100,0) AS Score
FROM
Score
INNER JOIN Student ON Student.StudentID = Score.StudentID
INNER JOIN Class ON Student.ClassID = Class.ClassID
INNER JOIN Exam ON Exam.ExamID = Score.ExamID
INNER JOIN Subject ON Subject.SubjectID = Score.SubjectID
INNER JOIN Teacher ON Teacher.SubjectID = Subject.SubjectID;

-- 拆表数据

-- City
SELECT DISTINCT CityName FROM OrderData;
SELECT CityName FROM OrderData GROUP BY CityName;

INSERT INTO City(CityName)
(SELECT CityName FROM OrderData GROUP BY CityName);

-- Category
SELECT CategoryName FROM OrderData GROUP BY CategoryName;

INSERT INTO Category(CategoryName)
(SELECT CategoryName FROM OrderData GROUP BY CategoryName);

-- Supplier
SELECT SupplierName FROM OrderData GROUP BY SupplierName;

INSERT INTO Supplier(SupplierName)
(SELECT SupplierName FROM OrderData GROUP BY SupplierName);

-- Product
Select o.ProductName,o.Unit,o.UnitPrice,CategoryID,SupplierID
FROM OrderData AS o
INNER JOIN Category AS c
INNER JOIN Supplier AS s
ON c.CategoryName = o.CategoryName AND o.SupplierName = s.SupplierName
GROUP BY o.ProductName,o.Unit,o.UnitPrice,c.CategoryID,s.SupplierID;

INSERT INTO Product(ProductName,Unit,UnitPrice,CategoryID,SupplierID)
(
	Select o.ProductName,o.Unit,o.UnitPrice,CategoryID,SupplierID
	FROM OrderData AS o
	INNER JOIN Category AS c
	INNER JOIN Supplier AS s
	ON c.CategoryName = o.CategoryName AND o.SupplierName = s.SupplierName
	GROUP BY o.ProductName,o.Unit,o.UnitPrice,c.CategoryID,s.SupplierID
);

-- Customer
SELECT CustomerName,CustomerPhone
FROM OrderData
GROUP BY CustomerName,CustomerPhone;

INSERT INTO Customer(CustomerName,CustomerPhone)
(
	SELECT CustomerName,CustomerPhone
	FROM OrderData
	GROUP BY CustomerName,CustomerPhone
);

-- OrderInfo
SELECT o.OrderDate,o.OrderQuality,c1.CustomerID,p.ProductID,c2.CityID
FROM OrderData AS o
INNER JOIN Customer AS c1
INNER JOIN Product AS p
INNER JOIN City AS c2
ON o.CustomerName = c1.CustomerName AND o.ProductName = p.ProductName AND o.CityName = c2.CityName
GROUP BY o.OrderDate,o.OrderQuality,c1.CustomerID,p.ProductID,c2.CityID;

INSERT INTO OrderInfo(OrderDate,OrderQuality,CustomerID,ProductID,CityID)
(
	SELECT o.OrderDate,o.OrderQuality,c1.CustomerID,p.ProductID,c2.CityID
	FROM OrderData AS o
	INNER JOIN Customer AS c1
	INNER JOIN Product AS p
	INNER JOIN City AS c2
	ON o.CustomerName = c1.CustomerName AND o.ProductName = p.ProductName AND o.CityName = c2.CityName
	GROUP BY o.OrderDate,o.OrderQuality,c1.CustomerID,p.ProductID,c2.CityID
);

-- 查询订单金额总和
SELECT SUM(o.OrderQuality * p.UnitPrice) AS TotalAmount
FROM OrderInfo AS o
INNER JOIN Product AS p
ON o.ProductID = p.ProductID;

-- 查询各商品订单金额总和，并导出为Excel文档
SELECT p.ProductName AS 商品名称, SUM(o.OrderQuality * p.UnitPrice) AS 订单总金额
FROM OrderInfo AS o
INNER JOIN Product AS p
ON o.ProductID = p.ProductID
GROUP BY p.ProductID
ORDER BY 订单总金额 DESC;

-- 查询各客户订单总金额
SELECT c.CustomerName AS 客户姓名, SUM(o.OrderQuality * p.UnitPrice) AS 订单总金额
FROM OrderInfo AS o
INNER JOIN Product AS p ON o.ProductID = p.ProductID
INNER JOIN Customer AS c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID
ORDER BY 订单总金额 DESC;

-- 查询所有订单信息明细
SELECT	
	c1.CustomerName, c1.CustomerPhone, c2.CityName,
	o.OrderDate, c3.CategoryName, s.SupplierName,
	p.ProductName, p.UnitPrice, p.Unit, 
	o.OrderQuality, o.OrderQuality * p.UnitPrice AS OrderAmount
FROM OrderInfo AS o
INNER JOIN Product AS p ON o.ProductID = p.ProductID
INNER JOIN Customer AS c1 ON o.CustomerID = c1.CustomerID
INNER JOIN City AS c2 ON o.CityID = c2.CityID
INNER JOIN Category AS c3 ON p.CategoryID = c3.CategoryID
INNER JOIN Supplier AS s ON p.SupplierID = s.SupplierID;
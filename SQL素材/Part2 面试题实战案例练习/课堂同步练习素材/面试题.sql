-- Exercise 001

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Address;
DROP TABLE IF EXISTS Person;

CREATE TABLE IF NOT EXISTS Person(
	PersonID INT PRIMARY KEY AUTO_INCREMENT,
	Name VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Address(
	AddressID INT PRIMARY KEY AUTO_INCREMENT,
	PersonID INT NOT NULL,
	Province VARCHAR(30) NOT NULL,
	City VARCHAR(30) NOT NULL,
	FOREIGN KEY(PersonID) REFERENCES Person(PersonID)
);

INSERT INTO Person(Name) 
VALUES('ormes'),('nethercutt'),('philipp'),('menefee'),('borkowski');

INSERT INTO Address(PersonID,Province,City)
VALUES(1,'jiangsu','nanjing'),(2,'zhejiang','hangzhou'),(4,'anhui','hefei');

SELECT * FROM Person;
SELECT * FROM Address;

-- 查询每个人的信息，无论是否存在地址信息

SELECT p.Name, a.Province, a.City
FROM Person AS p
LEFT JOIN Address AS a
ON p.PersonID = a.PersonID
ORDER BY a.Province DESC;

-- Exercise 002

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Employee;

CREATE TABLE IF NOT EXISTS Employee(
	EmpID INT PRIMARY KEY AUTO_INCREMENT,
	Salary DECIMAL(10,2) NOT NULL
);

INSERT INTO Employee(Salary) VALUES(25000.00),(15000.00),(23000.00);

SELECT * FROM Employee;

-- 查询薪资第二高的金额

SELECT Salary AS SecondHighestSalary 
FROM Employee 
ORDER BY Salary DESC 
LIMIT 1,1;

-- 先获取薪资最高的数据
SELECT MAX(Salary) FROM Employee;

-- 从余下的数据获取最高的数据
SELECT MAX(Salary) AS SecondHighestSalary
FROM Employee
WHERE Salary != (
	SELECT MAX(Salary) FROM Employee
);

-- 使用窗口函数方式
SELECT temp.Salary AS SecondHighestSalary
FROM
(
	SELECT *, ROW_NUMBER() OVER(ORDER BY Salary DESC) AS rn
	FROM Employee
) AS temp
WHERE temp.rn = 2;

-- Exercise 003

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Employee;

CREATE TABLE IF NOT EXISTS Employee(
	EmpID INT PRIMARY KEY AUTO_INCREMENT,
	Name VARCHAR(30) NOT NULL,
	Salary DECIMAL(10,2) NOT NULL,
	ManagerID INT
);

INSERT INTO Employee(Name, Salary, ManagerID) 
VALUES
('Joe', 25000.00, 3),
('Henry', 23000.00, 4),
('Sam', 28000.00, NULL),
('Max', 20000.00, NULL);

SELECT * FROM Employee;

-- 查询高于自身经理薪资的职员姓名

SELECT emp.Name AS Employee
FROM Employee AS emp
INNER JOIN Employee AS mgr
ON emp.ManagerID = mgr.EmpID
WHERE emp.Salary > mgr.Salary;

-- Exercise 004 + 005

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Employee;

CREATE TABLE IF NOT EXISTS Employee(
	EmpID INT PRIMARY KEY AUTO_INCREMENT,
	Email VARCHAR(30) NOT NULL
);

INSERT INTO Employee(Email) 
VALUES('Joe@lx.com'),('Henry@lx.com'),('Sam@lx.com'),('Max@lx.com'),('Henry@lx.com'),('Henry@lx.com');

SELECT * FROM Employee;

-- 查询重复邮箱信息

SELECT temp.Email
FROM
(
	SELECT Email, COUNT(*) AS count
	FROM Employee
	GROUP BY Email
) AS temp
WHERE temp.count > 1;

SELECT Email
FROM Employee
GROUP BY Email
HAVING COUNT(*) > 1;

SELECT DISTINCT Email
FROM
(
	SELECT *, ROW_NUMBER() OVER(PARTITION BY Email) AS rn
	FROM Employee
) AS temp
WHERE temp.rn > 1;

-- 删除重复邮件

SELECT * FROM Employee;

DELETE FROM Employee
WHERE EmpID 
IN
(
	SELECT EmpID
	FROM
	(
		SELECT *, ROW_NUMBER() OVER(PARTITION BY Email) AS rn
		FROM Employee
	) AS temp
	WHERE temp.rn > 1
);

-- 获取各邮箱信息对应的员工编号最小的数据

SELECT Email, MIN(EmpID) AS MinEmpID
FROM Employee
GROUP BY Email

-- 把不再邮箱信息最小编号里的员工进行删除

DELETE FROM Employee
WHERE EmpID NOT IN
(
	SELECT MinEmpID 
	FROM
	(
		SELECT MIN(EmpID) AS MinEmpID
		FROM Employee
		GROUP BY Email
	) AS temp
);

SELECT * FROM Employee;

-- Exercise 006

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Orders;

CREATE TABLE IF NOT EXISTS Customers(
	Id INT PRIMARY KEY AUTO_INCREMENT,
	Name VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Orders(
	Id INT PRIMARY KEY AUTO_INCREMENT,
	CustomerId INT NOT NULL,
	FOREIGN KEY(CustomerId) REFERENCES Customers(Id)
);

INSERT INTO Customers(Name) 
VALUES('Joe'),('Henry'),('Sam'),('Max');

INSERT INTO Orders(CustomerId) 
VALUES(1),(3);

SELECT * FROM Customers;
SELECT * FROM Orders;

-- 查询所有没有下单的客户名称

SELECT DISTINCT CustomerId FROM Orders;

SELECT Name
FROM Customers
WHERE Id NOT IN(
	SELECT DISTINCT CustomerId FROM Orders
);

SELECT Name
FROM Customers AS c
WHERE NOT EXISTS(
	SELECT 1 FROM Orders WHERE CustomerId = c.Id
);

SELECT Name
FROM Customers AS c
LEFT JOIN Orders AS o
ON c.Id = o.CustomerId
WHERE o.CustomerId IS NULL;

-- Exercise 007

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Weather;

CREATE TABLE IF NOT EXISTS Weather (
	Id INT PRIMARY KEY AUTO_INCREMENT,
	RecordDate DATE NOT NULL,
	Temperature INT NOT NULL
);

INSERT INTO Weather(RecordDate,Temperature)
VALUES
('2022-01-01', 10),
('2022-01-02', 15),
('2022-01-03', 12),
('2022-01-04', 20);

SELECT * FROM Weather;

-- 查询比前一天气温高的日期

SELECT w2.RecordDate
FROM Weather AS w1
INNER JOIN Weather AS w2
ON DATEDIFF(w2.RecordDate, w1.RecordDate) = 1
WHERE w2.Temperature > w1.Temperature;

SELECT RecordDate
FROM
(
	SELECT *,
	LAG(Temperature) OVER(ORDER BY Id) AS Temperature2
	FROM Weather
) AS temp
WHERE temp.Temperature2 IS NOT NULL AND temp.Temperature > temp.Temperature2;

-- Exercise 008 + 009

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Activity;

CREATE TABLE IF NOT EXISTS Activity (
	PlayerId INT NOT NULL,
	DeviceId INT NOT NULL,
	EventDate Date NOT NULL,
	GamesPlayed INT NOT NULL
);

INSERT INTO Activity(PlayerId,DeviceId,EventDate,GamesPlayed)
VALUES
(1,2,'2022-03-01', 5),
(1,2,'2022-05-02', 6),
(2,3,'2022-06-25', 1),
(3,1,'2022-03-02', 0),
(3,4,'2022-07-03', 5);

SELECT * FROM Activity;

-- 查询每名玩家第一次登陆的日期

SELECT PlayerId, MIN(EventDate) AS FirstLogin
FROM Activity
GROUP BY PlayerId;

SELECT PlayerId, EventDate AS FirstLogin
FROM
(
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY PlayerId ORDER BY EventDate) AS rn
	FROM Activity
) AS temp
WHERE temp.rn = 1;

-- 查询每名玩家第一次使用的设备

SELECT PlayerId, DeviceId AS FirstDevice
FROM
(
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY PlayerId ORDER BY EventDate) AS rn
	FROM Activity
) AS temp
WHERE temp.rn = 1;

SELECT a.PlayerId, a.DeviceId AS FirstDevice
FROM Activity AS a
INNER JOIN
(
	SELECT PlayerId, MIN(EventDate) AS FirstLogin
	FROM Activity
	GROUP BY PlayerId
) AS temp
ON a.PlayerId = temp.PlayerId AND a.EventDate = temp.FirstLogin;

-- Exercise 010

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Courses;

CREATE TABLE IF NOT EXISTS Courses (
	Student CHAR(1) NOT NULL,
	Class VARCHAR(10) NOT NULL
);
	
INSERT INTO Courses
VALUES
('A', 'Math'),
('B', 'English'),
('C', 'Math'),
('D', 'Biology'),
('E', 'Math'),
('F', 'Computer'),
('G', 'Math'),
('H', 'Math'),
('I', 'Math');

SELECT * FROM Courses;

-- 列出学生数超过5个的班级

SELECT Class
FROM Courses
GROUP BY Class
HAVING COUNT(*) > 5;

SELECT DISTINCT Class
FROM
(
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY Class) AS rn
	FROM Courses
) AS temp
WHERE temp.rn > 5;

-- Exercise 011

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Cinema;

CREATE TABLE IF NOT EXISTS Cinema(
	Id INT PRIMARY KEY AUTO_INCREMENT,
	Movie VARCHAR(30) NOT NULL,
	Description VARCHAR(30) NOT NULL,
	Rating DECIMAL(2,1) NOT NULL
);

INSERT INTO Cinema(Movie, Description, Rating)
VALUES
('War', 'great 3D', 8.9),
('Science', 'fiction', 8.5),
('irish', 'boring', 6.2),
('Ice song', 'Fantacy', 8.6),
('House card', 'Interesting', 9.1);

SELECT * FROM Cinema;

-- 筛选出ID为奇数并且描述不是'boring'的电影

SELECT 3 % 2;
SELECT 4 % 2;

SELECT * FROM Cinema
WHERE Id % 2 = 1;

SELECT * FROM Cinema
WHERE Description LIKE '%boring%';

SELECT * FROM Cinema
WHERE Id % 2 = 1 AND Description NOT LIKE '%boring%';

-- Exercise 012

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Salary;

CREATE TABLE IF NOT EXISTS Salary(
	Id INT PRIMARY KEY AUTO_INCREMENT,
	Name VARCHAR(30) NOT NULL,
	Sex VARCHAR(1) NOT NULL,
	Salary INT NOT NULL
);

INSERT INTO Salary(Name, Sex, Salary)
VALUES
('A', 'm', 2500),
('B', 'f', 1500),
('C', 'm', 5500),
('D', 'f', 500);

SELECT * FROM Salary;

-- 将Salary表中的f更新为m，m更新为f

UPDATE Salary
SET Sex = IF(Sex = 'm', 'f', 'm');

SELECT * FROM Salary;

UPDATE Salary
SET Sex = 
(
	CASE Sex
		WHEN 'm' THEN 'f'
		ELSE 'm'
	END
);

SELECT * FROM Salary;

-- Exercise 013

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Product;

CREATE TABLE IF NOT EXISTS Product(
	ProductId INT PRIMARY KEY,
	ProductName VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Sales(
	SaleId INT,
	ProductId INT,
	Year INT NOT NULL,
	Quantity INT NOT NULL,
	Price INT NOT NULL,
	PRIMARY KEY(SaleId, ProductId),
	FOREIGN KEY(ProductId) REFERENCES Product(ProductId)
);

INSERT INTO Product
VALUES
(100, 'Nokia'),
(200, 'Apple'),
(300, 'Samsung');

INSERT INTO Sales
VALUES
(1, 100, 2008, 10, 5000),
(2, 100, 2009, 12, 5000),
(7, 200, 2011, 15, 9000);

SELECT * FROM Product;
SELECT * FROM Sales;

-- 查询各个商品的年销售额

SELECT p.ProductName, s.Year, IFNULL(s.Quantity * s.Price, 0) AS TotalAmount
FROM Product AS p
LEFT JOIN Sales AS s
ON p.ProductId = s.ProductId
ORDER BY ProductName, Year;

-- 查询各个商品的总销量

SELECT ProductName, IFNULL(SUM(Quantity), 0) AS TotalQuantity
FROM Product AS p
LEFT JOIN Sales AS s
ON p.ProductId = s.ProductId
GROUP BY ProductName;

-- Exercise 015

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Product;

CREATE TABLE IF NOT EXISTS Product(
	ProductId INT PRIMARY KEY AUTO_INCREMENT,
	ProductName VARCHAR(30) NOT NULL,
	UnitPrice INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Sales(
	SellerId INT NOT NULL,
	ProductId INT NOT NULL,
	BuyerId INT NOT NULL,
	SaleDate DATE NOT NULL,
	Quantity INT NOT NULL,
	Price INT NOT NULL,
	FOREIGN KEY(ProductId) REFERENCES Product(ProductId)
);

INSERT INTO Product(ProductName, UnitPrice)
VALUES
('S8', 1000),
('G4', 800),
('iPhone', 1400);

INSERT INTO Sales
VALUES
(1,1,1,'2022-01-21',1,1000),
(1,1,1,'2022-01-25',1,1000),
(1,2,2,'2022-02-17',1,800),
(2,2,3,'2022-06-02',1,800),
(3,3,1,'2022-05-13',2,1400),
(2,1,2,'2022-02-17',1,1000);

SELECT * FROM Product;
SELECT * FROM Sales;

-- 查询基于销售额的最好的卖家（如果销售额相同，一起展示）

SELECT SUM(Quantity * Price) AS TotalAmount
FROM Sales
GROUP BY SellerId
ORDER BY TotalAmount DESC
LIMIT 1;

SELECT SellerId
FROM Sales
GROUP BY SellerId
HAVING SUM(Quantity * Price) =
(
	SELECT SUM(Quantity * Price) AS TotalAmount
	FROM Sales
	GROUP BY SellerId
	ORDER BY TotalAmount DESC
	LIMIT 1
);

WITH temp1 AS
(
	SELECT SellerId, SUM(Quantity * Price) AS TotalAmount
	FROM Sales
	GROUP BY SellerId
),
temp2 AS
(
	SELECT *,
	RANK() OVER(ORDER BY TotalAmount DESC) AS r
	FROM temp1
)
SELECT SellerId FROM temp2
WHERE temp2.r = 1;

-- 查询购买了S8却没有购买iphone的买家信息

WITH temp AS
(
	SELECT s.BuyerId, p.ProductName, p.ProductName = 'S8' AS flag1, p.ProductName = 'iPhone' AS flag2
	FROM Sales AS s
	INNER JOIN Product AS p
	ON s.ProductId = p.ProductId
)
SELECT BuyerId
FROM temp
GROUP BY BuyerId
HAVING SUM(flag1) > 0 AND SUM(flag2) = 0;

WITH temp AS
(
	SELECT s.BuyerId, GROUP_CONCAT(DISTINCT p.ProductName) AS ProductsName
	FROM Sales AS s
	INNER JOIN Product AS p
	ON s.ProductId = p.ProductId
	WHERE ProductName IN ('S8', 'iPhone')
	GROUP BY s.BuyerId
)
SELECT BuyerId FROM temp WHERE productsName = 'S8';

-- 查询只在2022年第一季度销售的商品信息

SELECT ProductId
FROM Sales
GROUP BY ProductId
HAVING MIN(SaleDate) >= '2022-01-01' AND MAX(SaleDate) <= '2022-03-31';

WITH temp AS
(
	SELECT ProductId, SaleDate, (SaleDate BETWEEN '2022-01-01' AND '2022-03-31') AS flag
	FROM Sales
)
SELECT ProductId
FROM temp
GROUP BY ProductId
HAVING MIN(flag) = 1;

-- Exercise 018

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Department;

CREATE TABLE IF NOT EXISTS Department(
	Id INT,
	Month VARCHAR(3),
	Revenue INT NOT NULL,
	PRIMARY KEY(Id, Month)
);

INSERT INTO Department
VALUES
(1, 'Jan', 8000),
(2, 'Jan', 9000),
(3, 'Feb', 10000),
(1, 'Feb', 7000),
(1, 'Mar', 6000);

SELECT * FROM Department;

-- 转换Department表的数据展示格式

+------+-------------+-------------+-------------+-----+-------------+
| id   | Jan_Revenue | Feb_Revenue | Mar_Revenue | ... | Dec_Revenue |
+------+-------------+-------------+-------------+-----+-------------+
| 1    | 8000        | 7000        | 6000        | ... | null        |
| 2    | 9000        | null        | null        | ... | null        |
| 3    | null        | 10000       | null        | ... | null        |
+------+-------------+-------------+-------------+-----+-------------+

SELECT * FROM Department;

SELECT Id, 
SUM(CASE WHEN month = 'Jan' THEN Revenue ELSE null END) AS Jan_Revenue,
SUM(CASE WHEN month = 'Feb' THEN Revenue ELSE null END) AS Feb_Revenue,
SUM(CASE WHEN month = 'Mar' THEN Revenue ELSE null END) AS Mar_Revenue,
SUM(CASE WHEN month = 'Apr' THEN Revenue ELSE null END) AS Apr_Revenue
FROM Department
GROUP BY Id;

SELECT Id,
SUM(IF(month = 'Jan', Revenue, null)) AS Jan_Revenue,
SUM(IF(month = 'Feb', Revenue, null)) AS Feb_Revenue,
SUM(IF(month = 'Mar', Revenue, null)) AS Mar_Revenue,
SUM(IF(month = 'Apr', Revenue, null)) AS Apr_Revenue
FROM Department
GROUP BY Id;

-- Exercise 019

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Products;

CREATE TABLE IF NOT EXISTS Products(
	ProductId INT,
	Store ENUM('store1', 'store2', 'store3'),
	Price INT NOT NULL,
	PRIMARY KEY(ProductId, Price)
);

INSERT INTO Products
VALUES
(0, 'store1', 95),
(0, 'store3', 105),
(0, 'store2', 100),
(1, 'store1', 70),
(1, 'store3', 80);

SELECT * FROM Products;

-- 查询每个商品在不同商店中的价格

SELECT ProductId,
SUM(IF(Store = 'store1', Price, NULL)) AS Store1,
SUM(IF(Store = 'store2', Price, NULL)) AS Store2,
SUM(IF(Store = 'store3', Price, NULL)) AS Store3
FROM Products
GROUP BY ProductId;

-- Exercise 020

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Products;

CREATE TABLE IF NOT EXISTS Products(
	ProductId INT PRIMARY KEY,
	LowFats ENUM('Y', 'N'),
	Recyclable ENUM('Y', 'N')
);

INSERT INTO Products
VALUES
(0, 'Y', 'N'),
(1, 'Y', 'Y'),
(2, 'N', 'Y'),
(3, 'Y', 'Y'),
(4, 'N', 'N');

SELECT * FROM Products;

-- 查询不符合 低脂且可回收标准的产品

SELECT ProductId
FROM Products
WHERE ProductId NOT IN
(
	SELECT ProductId
	FROM Products
	WHERE LowFats = 'Y' AND Recyclable = 'Y'
);

SELECT ProductId
FROM Products
WHERE (LowFats, Recyclable) != ('Y','Y');

-- Exercise 021

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Warehouse;

CREATE TABLE IF NOT EXISTS Warehouse(
	Name VARCHAR(30),
	ProductId INT,
	Units INT NOT NULL,
	PRIMARY KEY(Name, ProductId)
);

CREATE TABLE IF NOT EXISTS Products(
	ProductId INT PRIMARY KEY AUTO_INCREMENT,
	ProductName VARCHAR(30),
	Width INT,
	Length INT,
	Height INT
);

INSERT INTO Warehouse
VALUES
('LCHouse1', 1, 1),
('LCHouse1', 2, 10),
('LCHouse1', 3, 5),
('LCHouse2', 1, 2),
('LCHouse2', 2, 2),
('LCHouse3', 4, 1);

INSERT INTO Products
VALUES
(1, 'LC-TV', 5, 50, 40),
(2, 'LC-KeyChain', 5, 5, 5),
(3, 'LC-Phone', 2, 10, 10),
(4, 'LC-T-Shirt', 4, 10, 20);

SELECT * FROM Warehouse;
SELECT * FROM Products;

-- 查询各仓库被占用了多少空间

SELECT w.Name, SUM(w.Units * p.Width * p.Length * p.Height) AS Volume
FROM Warehouse AS w
INNER JOIN Products AS p
ON w.ProductId = p.ProductId
GROUP BY w.Name;

-- Exercise 022

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Activity;

CREATE TABLE IF NOT EXISTS Activity(
	MachineId INT,
	ProcessId INT,
	ActivityType ENUM('start', 'end'),
	Timestamp FLOAT NOT NULL,
	PRIMARY KEY(MachineId, ProcessId, ActivityType)
);

INSERT INTO Activity
VALUES
(0, 0, 'start', 0.712),
(0, 0, 'end', 1.520),
(0, 1, 'start', 3.140),
(0, 1, 'end', 4.120),
(1, 0, 'start', 0.550),
(1, 0, 'end', 1.550),
(1, 1, 'start', 0.430),
(1, 1, 'end', 1.420),
(2, 0, 'start', 4.100),
(2, 0, 'end', 4.512),
(2, 1, 'start', 2.500),
(2, 1, 'end', 5.000);

SELECT * FROM Activity;

-- 查询各机器完成加工的平均时间

WITH temp AS
(
	SELECT MachineId, ProcessId, MAX(Timestamp) - MIN(Timestamp) AS ProcessTime
	FROM Activity
	GROUP BY MachineId, ProcessId
)
SELECT MachineId, ROUND(AVG(ProcessTime), 3) AS AvgProcessTime
FROM temp
GROUP BY MachineId;

WITH temp AS
(
	SELECT a1.MachineId, a1.ProcessId, (a2.Timestamp - a1.Timestamp) AS ProcessTime 
	FROM Activity AS a1
	INNER JOIN Activity AS a2
	ON a1.MachineId = a2.MachineId AND a1.ProcessId = a2.ProcessId AND a1.ActivityType = 'start' AND a2.ActivityType = 'end'
)
SELECT MachineId, ROUND(AVG(ProcessTime), 3) AS AvgProcessTime
FROM temp
GROUP BY MachineId;

-- Exercise 023

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Rides;
DROP TABLE IF EXISTS Users;

CREATE TABLE IF NOT EXISTS Users(
	Id INT PRIMARY KEY,
	Name VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Rides(
	Id INT PRIMARY KEY AUTO_INCREMENT,
	UserId INT NOT NULL,
	Distance INT NOT NULL,
	FOREIGN KEY(UserId) REFERENCES Users(Id)
);

INSERT INTO Users
VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Alex'),
(4, 'Donald'),
(7, 'Lee'),
(13, 'Jonathan'),
(19, 'Elvis');

INSERT INTO Rides(UserId, Distance)
VALUES
(1, 120),
(2, 317),
(3, 222),
(7, 100),
(13, 312),
(19, 50),
(7, 120),
(19, 400),
(7, 230);

SELECT * FROM Rides;
SELECT * FROM Users;

-- 查询每位旅行者的里程值

SELECT u.Name, SUM(IFNULL(r.Distance, 0)) AS TravelledDistance
FROM Users AS u
LEFT JOIN Rides AS r
ON u.Id = r.UserId
GROUP BY u.Name
ORDER BY TravelledDistance DESC;

-- Exercise 024

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Employees;

CREATE TABLE IF NOT EXISTS Employees(
	EmpId INT,
	EventDay DATE,
	InTime INT,
	OutTime INT NOT NULL,
	PRIMARY KEY(EmpId, EventDay, InTime)
);

INSERT INTO Employees
VALUES
(1, '2022-11-28', 4, 32),
(1, '2022-11-28', 55, 200),
(1, '2022-12-03', 1, 42),
(2, '2022-11-28', 3, 33),
(2, '2022-12-09', 47, 74);

SELECT * FROM Employees;

-- 查询每位员工在办公室的总时间

SELECT EmpId, EventDay, SUM(OutTime - InTime) AS TotalTime
FROM Employees
GROUP BY EmpId, EventDay;

-- Exercise 025

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Bonus;
DROP TABLE IF EXISTS Employee;

CREATE TABLE IF NOT EXISTS Employee(
	EmpId INT PRIMARY KEY AUTO_INCREMENT,
	Name VARCHAR(30) NOT NULL,
	Supervisor INT,
	Salary INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Bonus(
	EmpId INT NOT NULL,
	Bonus INT NOT NULL,
	FOREIGN KEY(EmpId) REFERENCES Employee(EmpId)
);

INSERT INTO Employee
VALUES
(1, 'John', 3, 1000),
(2, 'Dan', 3, 2000),
(3, 'Brad', null, 4000),
(4, 'Thomas', 3, 4000);

INSERT INTO Bonus
VALUES
(2, 500),
(4, 2000);

SELECT * FROM Employee;
SELECT * FROM Bonus;

-- 查询奖金金额低于1000的员工以及没有奖金的员工信息

SELECT e.Name, b.Bonus
FROM Employee AS e
LEFT JOIN Bonus AS b
ON e.EmpId = b.EmpId
WHERE b.Bonus < 1000 OR b.Bonus IS NULL;

SELECT e.Name, b.Bonus
FROM Employee AS e
LEFT JOIN Bonus AS b
ON e.EmpId = b.EmpId
WHERE IFNULL(b.Bonus, 0) < 1000;

-- Exercise 026

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Customer;

CREATE TABLE IF NOT EXISTS Customer(
	CustomerId INT NOT NULL,
	Year INT NOT NULL,
	REVENUE INT NOT NULL
);

INSERT INTO Customer
VALUES
(1, 2018, 50),
(1, 2021, 30),
(1, 2021, -50),
(1, 2021, 100),
(1, 2020, 70),
(2, 2021, -50),
(3, 2018, 10),
(3, 2016, 50),
(4, 2021, 20);

SELECT * FROM Customer;

-- 查询2021年收入为正的客户信息

SELECT CustomerId
FROM Customer
WHERE Year = 2021
GROUP BY CustomerId
HAVING SUM(Revenue) > 0;

-- Exercise 027

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Triangle;

CREATE TABLE IF NOT EXISTS Triangle(
	X INT NOT NULL,
	Y INT NOT NULL,
	Z INT NOT NULL
);

INSERT INTO Triangle
VALUES
(13, 15, 30),
(10, 20, 15);

SELECT * FROM Triangle;

-- 判定能够组成三角形的数字集合

SELECT X, Y, Z,
IF((X + Y > Z) AND (X + Z > Y) AND (Y + Z > X), 'Yes', 'No') AS Triangle
FROM Triangle;

-- Exercise 028

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Delivery;

CREATE TABLE IF NOT EXISTS Delivery(
	DeliveryId INT PRIMARY KEY AUTO_INCREMENT,
	CustomerId INT NOT NULL,
	OrderDate DATE NOT NULL,
	CustomerPrefDeliveryDate DATE NOT NULL
);

INSERT INTO Delivery(CustomerId, OrderDate, CustomerPrefDeliveryDate)
VALUES
(1, '2022-08-01', '2022-08-02'),
(5, '2022-08-02', '2022-08-02'),
(1, '2022-08-11', '2022-08-11'),
(3, '2022-08-24', '2022-08-26'),
(4, '2022-08-21', '2022-08-22'),
(2, '2022-08-11', '2022-08-13');

SELECT * FROM Delivery;

-- 查询需要当天立刻送达的订单百分比

SELECT COUNT(*)
FROM Delivery;

SELECT SUM(OrderDate = CustomerPrefDeliveryDate) AS Immediate
FROM Delivery;

SELECT CONCAT(ROUND(SUM(OrderDate = CustomerPrefDeliveryDate) / COUNT(*) * 100, 2), '%') AS ImmediatePercentage
FROM Delivery;

-- Exercise 029

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;

CREATE TABLE IF NOT EXISTS Department(
	Id INT PRIMARY KEY,
	Name VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Employee(
	Id INT PRIMARY KEY,
	Name VARCHAR(30) NOT NULL,
	DepartmentId INT NOT NULL
);

INSERT INTO Department
VALUES
(1, 'Electical Engineering'),
(7, 'Computer Engineering'),
(13, 'Bussiness Administration');

INSERT INTO Employee
VALUES
(23, 'Alice', 1),
(1, 'Bob', 7),
(5, 'Jennifer', 13),
(2, 'John', 14),
(4, 'Jasmine', 77),
(3, 'Steve', 74),
(6, 'Luis', 1),
(8, 'Jonathan', 7),
(7, 'Daiana', 33),
(11, 'Madelynn', 1);

SELECT * FROM Department;
SELECT * FROM Employee;

-- 查询所分配部门已不存在的员工信息

SELECT Id, Name
FROM Employee
WHERE DepartmentId NOT IN
(
	SELECT Id FROM Department
);

SELECT e.Id, e.Name
FROM Employee AS e
LEFT JOIN Department AS d
ON e.DepartmentId = d.Id
WHERE d.Id IS NULL;

SELECT e.Id, e.Name
FROM Employee AS e
WHERE NOT EXISTS
(
	SELECT 1 FROM Department AS d
	WHERE d.Id = e.DepartmentId
);

-- Exercise 030

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Register;
DROP TABLE IF EXISTS Users;

CREATE TABLE IF NOT EXISTS Users(
	UserId INT,
	UserName VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Register(
	ContestId INT,
	UserId INT,
	PRIMARY KEY(ContestId, UserId)
);

INSERT INTO Users
VALUES
(6, 'Alice'),
(2, 'Bob'),
(7, 'Alex');

INSERT INTO Register
VALUES
(215, 6),
(209, 2),
(208, 2),
(210, 6),
(208, 6),
(209, 7),
(209, 6),
(215, 7),
(208, 7),
(210, 2),
(207, 2),
(210, 7);

SELECT * FROM Users;
SELECT * FROM Register;

-- 查询各个竞赛参与人数的百分比

SELECT ContestId, COUNT(*)
FROM Register
GROUP BY ContestId;

SELECT COUNT(*) FROM Users;

SELECT ContestId, Concat(ROUND(COUNT(*) / (SELECT COUNT(*) FROM Users) * 100, 2), '%') AS Percentage
FROM Register
GROUP BY ContestId;

-- Exercise 031

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Orders;

CREATE TABLE IF NOT EXISTS Orders(
	OrderNumber INT PRIMARY KEY,
	CustomerNumber INT NOT NULL
);

INSERT INTO Orders
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 3),
(5, 3),
(6, 4),
(7, 2),
(8, 2);

SELECT * FROM Orders;

-- 查询订单量最多的买家

SELECT CustomerNumber, COUNT(*) AS OrderNumbers
FROM Orders
GROUP BY CustomerNumber
ORDER BY OrderNumbers DESC
LIMIT 1;

WITH temp AS
(
	SELECT CustomerNumber, COUNT(*) AS OrderNumbers
	FROM Orders
	GROUP BY CustomerNumber
	ORDER BY OrderNumbers DESC
)
SELECT CustomerNumber FROM temp
WHERE OrderNumbers = (
	SELECT MAX(OrderNumbers) FROM temp
);

WITH temp1 AS
(
	SELECT CustomerNumber, COUNT(*) AS OrderNumbers
	FROM Orders
	GROUP BY CustomerNumber
	ORDER BY OrderNumbers DESC
),
temp2 AS 
(
	SELECT *,
	RANK() OVER(ORDER BY OrderNumbers DESC) AS r
	FROM temp1
)
SELECT CustomerNumber FROM temp2
WHERE temp2.r = 1;

-- Exercise 032

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Employee;

CREATE TABLE IF NOT EXISTS Employee(
	Id INT PRIMARY KEY,
	Salary INT NOT NULL
);

INSERT INTO Employee
VALUES
(1, 10000),
(2, 30000),
(3, 20000),
(4, 15000),
(5, 25000),
(6, 15000),
(7, 30000),
(8, 25000);

SELECT * FROM Employee;

-- 查询薪资第2高的员工

SELECT *
FROM Employee
ORDER BY Salary DESC
LIMIT 2, 1;

WITH temp AS
(
	SELECT *,
	DENSE_RANK() OVER(ORDER BY Salary DESC) AS r
	FROM Employee
)
SELECT DISTINCT Salary FROM temp
WHERE r = 2;

-- Exercise 033

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Scores;

CREATE TABLE IF NOT EXISTS Scores(
	Id INT PRIMARY KEY AUTO_INCREMENT,
	Score DECIMAL(10, 2) NOT NULL
);

INSERT INTO Scores(Score)
VALUES
(3.50),
(3.65),
(4.00),
(3.85),
(4.00),
(3.65);

SELECT * FROM Scores;

-- 针对员工评分进行倒序排序，分数相同，名次并列

SELECT Score,
DENSE_RANK() OVER(ORDER BY Score DESC) AS 'Rank'
FROM Scores;

SELECT *,
(SELECT COUNT(DISTINCT Score) FROM Scores AS s2 WHERE s2.Score >= s1.Score) AS 'Rank'
FROM Scores AS s1
ORDER BY s1.Score DESC;

-- Exercise 034

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Logs;

CREATE TABLE IF NOT EXISTS Logs(
	Id INT PRIMARY KEY AUTO_INCREMENT,
	Num INT NOT NULL
);

INSERT INTO Logs(Num)
VALUES
(1),(1),(1),(1),(2),(1),(3),(2),(2),(2);

SELECT * FROM Logs;

-- 查询连续出现三次以上的数字

WITH temp AS
(
	SELECT Num,
	LAG(Num) OVER() AS Num2,
	LAG(Num, 2) OVER() AS Num3
	FROM Logs
)
SELECT DISTINCT Num AS ConsecutiveNums
FROM temp
WHERE Num = Num2 AND NUm = Num3;

-- Exercise 035

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Employee;

CREATE TABLE IF NOT EXISTS Department(
	Id INT PRIMARY KEY AUTO_INCREMENT,
	Name VARCHAR(10) NOT NULL
);

INSERT INTO Department(Name)
VALUES
('IT'),('Sales');

CREATE TABLE IF NOT EXISTS Employee(
	Id INT PRIMARY KEY AUTO_INCREMENT,
	Name VARCHAR(10) NOT NULL,
	Salary INT NOT NULL,
	DepartmentId INT NOT NULL,
	FOREIGN KEY(DepartmentId) REFERENCES Department(Id)
);

INSERT INTO Employee(Name, Salary, DepartmentId)
VALUES
('Joe', 70000, 1),
('Jim', 90000, 1),
('Henry', 80000, 2),
('Sam', 60000, 2),
('Max', 90000, 1);

SELECT * FROM Department;
SELECT * FROM Employee;

-- 查询各个部门最高薪资的员工

SELECT DepartmentId, MAX(Salary) AS MaxSalary
FROM Employee
GROUP BY DepartmentId;

SELECT d.Name AS Department, e.Name AS Employee, e.Salary AS Salary
FROM Department AS d
INNER JOIN Employee AS e
ON e.DepartmentId = d.Id
WHERE (e.DepartmentId, e.Salary) IN
(
	SELECT DepartmentId, MAX(Salary) AS MaxSalary
	FROM Employee
	GROUP BY DepartmentId
)
ORDER BY Department;

WITH temp AS
(
	SELECT *,
	RANK() OVER(PARTITION BY DepartmentId ORDER BY Salary DESC) AS r
	FROM Employee
)
SELECT d.Name AS Department, t.Name AS Employee, t.Salary AS Salary 
FROM temp AS t
INNER JOIN Department AS d
ON t.DepartmentId = d.Id
WHERE t.r = 1;

-- Exercise 036 + 037

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Activity;

CREATE TABLE IF NOT EXISTS Activity (
	PlayerId INT NOT NULL,
	DeviceId INT NOT NULL,
	EventDate Date NOT NULL,
	GamesPlayed INT NOT NULL
);

INSERT INTO Activity(PlayerId,DeviceId,EventDate,GamesPlayed)
VALUES
(1,2,'2022-03-01', 5),
(1,2,'2022-03-02', 6),
(1,3,'2022-03-03', 1),
(1,3,'2022-05-03', 10),
(2,1,'2022-03-02', 1),
(2,4,'2022-07-03', 5),
(3,1,'2022-03-03', 3),
(3,1,'2022-03-04', 4);

SELECT * FROM Activity;

-- 统计各个玩家在各个日期的累计次数值

SELECT PlayerId, EventDate,
SUM(GamesPlayed) OVER(PARTITION BY PlayerId ORDER BY EVENTDATE
									RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS GamesPalyedSoFar
FROM Activity;

SELECT a1.PlayerId, a1.EventDate, SUM(a2.GamesPlayed) AS GamesPalyedSoFar
FROM Activity AS a1
INNER JOIN Activity AS a2
ON a1.PlayerId = a2.PlayerId AND a1.EventDate >= a2.EventDate
GROUP BY a1.PlayerId, a1.EventDate
ORDER BY a1.PlayerId, a1.EventDate;

-- 统计连续两天登陆的用户百分比

WITH temp1 AS
(
	SELECT *,
	LEAD(EventDate, 1) OVER(PARTITION BY PlayerId ORDER BY EventDate) AS NextEventDate
	FROM Activity
),
temp2 AS 
(
	SELECT COUNT(DISTINCT PlayerId) AS LogBackUserCounts
	FROM temp1
	WHERE DATEDIFF(EventDate, NextEventDate) = - 1
)
SELECT CONCAT(ROUND((LogBackUserCounts / (SELECT COUNT(DISTINCT PlayerId) FROM Activity)) * 100, 2), '%') AS Percentage
FROM temp2;

SELECT CONCAT(ROUND((COUNT(DISTINCT a2.PlayerId) / COUNT(DISTINCT a1.PlayerId)) * 100, 2), '%') AS Percentage
FROM Activity AS a1
LEFT JOIN Activity AS a2
ON a1.PlayerId = a2.PlayerId AND DATEDIFF(a1.EventDate, a2.EventDate) = -1;

-- Exercise 038

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Seat;

CREATE TABLE IF NOT EXISTS Seat (
	Id INT NOT NULL,
	Name VARCHAR(10) NOT NULL
);

INSERT INTO Seat
VALUES
(1, 'Abbot'),
(2, 'Doris'),
(3, 'Emerson'),
(4, 'Green'),
(5, 'Jeames');

SELECT * FROM Seat;

-- 查询奇偶数同学更换位置的效果

SELECT
-- 如果Id为奇数， 通过Id + 1处理
-- 特殊情况：如果Id为表中的Id最大值，保持不变
-- 如果Id为偶数， 通过Id - 1处理
IF(Id % 2 = 1, IF(Id = (SELECT MAX(Id) FROM Seat), Id, Id + 1), Id - 1) AS Id,
Name
FROM Seat
ORDER BY Id;

-- Exercise 039

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Product;

CREATE TABLE IF NOT EXISTS Product (
	ProductId INT PRIMARY KEY,
	ProductName VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS Sales (
	SaleId INT PRIMARY KEY,
	ProductId INT NOT NULL,
	Year INT NOT NULL,
	Quantity INT NOT NULL,
	Price INT NOT NULL,
	FOREIGN KEY(ProductId) REFERENCES Product(ProductId)
);

INSERT INTO Product
VALUES
(100, 'Nokia'),
(200, 'Apple'),
(300, 'Samsung');

INSERT INTO Sales
VALUES
(1, 100, 2008, 10, 5000),
(2, 100, 2009, 12, 5000),
(7, 200, 2011, 15, 9000);

SELECT * FROM Product;
SELECT * FROM Sales;

-- 查询每个商品第一年的销售信息

WITH temp AS
(
	SELECT *,
	RANK() OVER(PARTITION BY ProductId ORDER BY Year) AS r
	FROM Sales
)
SELECT ProductId, Year AS FirstYear, Quantity, Price
FROM temp
WHERE r = 1;

SELECT ProductId, Year AS FirstYear, Quantity, Price
FROM Sales
WHERE (ProductId, Year) IN 
(
	SELECT ProductId, MIN(Year)
	FROM Sales
	GROUP BY ProductId
);

-- Exercise 040

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Employees;

CREATE TABLE IF NOT EXISTS Employees (
	EmployeeId INT PRIMARY KEY,
	EmployeeName VARCHAR(30) NOT NULL,
	ManagerId INT NOT NULL
);

INSERT INTO Employees
VALUES
(1, 'Boss', 1),
(3, 'Alice', 3),
(2, 'Bob', 1),
(4, 'Daniel', 2),
(7, 'Luis', 4),
(8, 'Jhon', 3),
(9, 'Angela', 8),
(77, 'Robert', 1);

SELECT * FROM Employees;

-- 查询能间接或直接向企业老板汇报的员工信息
-- 注意：基于公司规模较小原因，管理层级不超过3级

SELECT e1.EmployeeId
FROM Employees AS e1
INNER JOIN Employees AS e2
INNER JOIN Employees AS e3
ON e1.ManagerId = e2.EmployeeId AND e2.ManagerId = e3.EmployeeId
WHERE e3.ManagerId = 1 AND e1.EmployeeId != 1;

WITH RECURSIVE temp AS 
(
	SELECT EmployeeId, ManagerId, 1 AS N FROM Employees WHERE EmployeeName = 'Boss'
	UNION
	SELECT e.EmployeeId, e.ManagerId, N + 1 
	FROM Employees AS e
	INNER JOIN temp AS t
	ON e.ManagerId = t.EmployeeId
	WHERE N < 4 
)
SELECT EmployeeId FROM temp
WHERE N = 4 AND EmployeeId != 1;

-- Exercise 041

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Activities;
DROP TABLE IF EXISTS Friends;

CREATE TABLE IF NOT EXISTS Activities(
	Id INT PRIMARY KEY AUTO_INCREMENT,
	Name VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Friends(
	Id INT PRIMARY KEY AUTO_INCREMENT,
	Name VARCHAR(30) NOT NULL,
	Activity VARCHAR(30) NOT NULL
);

INSERT INTO Activities(Name)
VALUES
('Eating'), ('Singing'), ('Horse Riding');

INSERT INTO Friends(Name, Activity)
VALUES
('Jonathan D.', 'Eating'),
('Jade W.', 'Singing'),
('Victor J.', 'Singing'),
('Elvis Q.', 'Eating'),
('Daniel A.', 'Eating'),
('Bob B.', 'Horse Riding');

SELECT * FROM Activities;
SELECT * FROM Friends;

-- 查询参与人数不是最多也不是最少的活动

WITH temp1 AS
(
	SELECT Activity, COUNT(*) AS FriendCounts
	FROM Friends
	GROUP BY Activity
),
temp2 AS 
(
	SELECT MAX(FriendCounts) AS MaxOrMinFriends FROM temp1
	UNION
	SELECT MIN(FriendCounts) AS MaxOrMinFriends FROM temp1
)
SELECT Activity FROM temp1
WHERE FriendCounts NOT IN 
(
	SELECT MaxOrMinFriends FROM temp2
);

SELECT Activity
FROM Friends
GROUP BY Activity
HAVING
COUNT(*) != (SELECT COUNT(*) FROM Friends GROUP BY Activity ORDER BY COUNT(*) LIMIT 1)
AND
COUNT(*) != (SELECT COUNT(*) FROM Friends GROUP BY Activity ORDER BY COUNT(*) DESC LIMIT 1);

-- Exercise 042

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Contacts;

CREATE TABLE IF NOT EXISTS Customers(
	CustomerId INT PRIMARY KEY,
	CustomerName VARCHAR(30) NOT NULL,
	Email VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Contacts(
	UserId INT,
	ContactName VARCHAR(30) NOT NULL,
	ContactEmail VARCHAR(30),
	PRIMARY KEY(UserId, ContactEmail)
);

CREATE TABLE IF NOT EXISTS Invoices(
	InvoiceId INT PRIMARY KEY,
	Price INT NOT NULL,
	UserId INT NOT NULL
);

INSERT INTO Customers
VALUES
(1, 'Alice', 'alice@lx.com'),
(2, 'Bob', 'bob@lx.com'),
(13, 'John', 'john@lx.com'),
(6, 'Alex', 'alex@lx.com');

INSERT INTO Contacts
VALUES
(1, 'Bob', 'bob@lx.com'),
(1, 'John', 'john@lx.com'),
(1, 'Jal', 'jal@lx.com'),
(2, 'Omar', 'omar@lx.com'),
(2, 'Meir', 'meir@lx.com'),
(6, 'Alice', 'alice@lx.com');

INSERT INTO Invoices
VALUES
(77, 100, 1),
(88, 200, 1),
(99, 300, 2),
(66, 400, 2),
(55, 500, 13),
(44, 60, 6);

SELECT * FROM Customers;
SELECT * FROM Contacts;
SELECT * FROM Invoices;

-- 查询账单信息，包括账单号，客户姓名，账单价格， 联系人数量， 信任的联系人数量

WITH temp AS
(
	SELECT i.InvoiceId, c1.CustomerName, i.Price,
	(SELECT COUNT(*) AS ContactCounts FROM Contacts AS c2 GROUP BY UserId HAVING c2.UserId = c1.CustomerId) AS ContactsCnt,
	(SELECT COUNT(*) AS TrustedContactsCnt FROM Contacts AS c3 INNER JOIN Customers AS c4 ON c3.ContactName = c4.CustomerName 
		GROUP BY c3.UserId HAVING c3.UserId = c1.CustomerId) AS TrustedContactsCnt
	FROM Invoices AS i
	INNER JOIN Customers As c1
	ON i.UserId = c1.CustomerId
)
SELECT InvoiceId, CustomerName, Price, IFNULL(ContactsCnt, 0) AS ContactsCnt, IFNULL(TrustedContactsCnt, 0) AS TrustedContactsCnt FROM temp; 

-- Exercise 043

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Accounts;
DROP TABLE IF EXISTS Logins;

CREATE TABLE IF NOT EXISTS Accounts(
	Id INT PRIMARY KEY,
	Name VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Logins(
	Id INT NOT NULL,
	LoginDate DATE NOT NULL
);

INSERT INTO Accounts
VALUES
(1, 'Winston'),
(7, 'Jonathan');

INSERT INTO Logins
VALUES
(7, '2020-05-30'),
(1, '2020-05-30'),
(7, '2020-05-31'),
(7, '2020-06-01'),
(7, '2020-06-02'),
(7, '2020-06-02'),
(7, '2020-06-03'),
(1, '2020-06-07'),
(7, '2020-06-10');

SELECT * FROM Accounts;
SELECT * FROM Logins;

-- 查询连续登陆5天的账户信息

SELECT a.Name
FROM Logins AS l1
INNER JOIN Logins AS l2
INNER JOIN Accounts AS a
ON DATEDIFF(l1.LoginDate, l2.LoginDate) = -1 AND l1.Id = l2.Id AND a.Id = l1.Id
GROUP BY l1.Id
HAVING COUNT(DISTINCT l1.LoginDate) = 4;

-- Exercise 044

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Products;

CREATE TABLE IF NOT EXISTS Customers(
	CustomerId INT PRIMARY KEY AUTO_INCREMENT,
	CustomerName VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Products(
	ProductId INT PRIMARY KEY AUTO_INCREMENT,
	ProductName VARCHAR(30) NOT NULL,
	Price INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Orders(
	OrderId INT PRIMARY KEY AUTO_INCREMENT,
	OrderDate DATE NOT NULL,
	CustomerId INT NOT NULL,
	ProductId INT NOT NULL,
	FOREIGN KEY(CustomerId) REFERENCES Customers(CustomerId),
	FOREIGN KEY(ProductId) REFERENCES Products(ProductId)
);

INSERT INTO Customers(CustomerName)
VALUES
('Alice'), ('Bob'), ('Tom'), ('Jerry'), ('John');

INSERT INTO Products(ProductName, Price)
VALUES
('keyboard', 120),
('mouse', 80),
('screen', 600),
('hard disk', 450);

INSERT INTO Orders(OrderDate, CustomerId, ProductId)
VALUES
('2020-07-31', 1, 1),
('2020-07-30', 2, 2),
('2020-08-29', 3, 3),
('2020-07-29', 4, 1),
('2020-06-10', 1, 2),
('2020-08-01', 2, 1),
('2020-08-01', 3, 3),
('2020-08-03', 1, 2),
('2020-08-07', 2, 3),
('2020-07-15', 1, 2);

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;

-- 查询每位客户最高频订购的商品

WITH temp1 AS
(
	SELECT CustomerId, ProductId, COUNT(*) AS OrderCounts
	FROM Orders
	GROUP BY CustomerId, ProductId
	ORDER BY CustomerId, ProductId
),
temp2 AS
(
	SELECT *,	RANK() OVER(PARTITION BY CustomerId ORDER BY OrderCounts DESC) AS r
	FROM temp1
)
SELECT t.CustomerId, t.ProductId, p.ProductName
FROM temp2 AS t
INNER JOIN Products AS p
ON t.ProductId = p.ProductId
WHERE t.r = 1
ORDER BY t.CustomerId, t.ProductId;

-- Exercise 045

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Boxes;
DROP TABLE IF EXISTS Chests;

CREATE TABLE IF NOT EXISTS Chests(
	ChestId INT PRIMARY KEY,
	AppleCount INT NOT NULL,
	OrangeCount INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Boxes(
	BoxId INT PRIMARY KEY,
	ChestId INT,
	AppleCount INT NOT NULL,
	OrangeCount INT NOT NULL,
	FOREIGN KEY(ChestId) REFERENCES Chests(ChestId)
);

INSERT INTO Chests
VALUES
(6, 5, 6),
(14, 20, 10),
(2, 8, 8),
(3, 19, 4),
(16, 19, 19);

INSERT INTO Boxes
VALUES
(2, NULL, 6, 15),
(18, 14, 4, 15),
(19, 3, 8, 4),
(12, 2, 19, 20),
(20, 6, 12, 9),
(8, 6, 9, 9),
(3, 14, 16, 7);

SELECT * FROM Chests;
SELECT * FROM Boxes;

-- 查询所有盒子中的苹果和橘子数量总和

SELECT SUM(AppleCount) AS AppleCount, SUM(OrangeCount) AS OrangeCount
FROM
(
	SELECT AppleCount, OrangeCount
	FROM Chests
	UNION ALL
	SELECT AppleCount, OrangeCount
	FROM Boxes
) AS temp;

-- Exercise 046

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Players;
DROP TABLE IF EXISTS Championships;

CREATE TABLE IF NOT EXISTS Players(
	PlayerId INT PRIMARY KEY AUTO_INCREMENT,
	PlayerName VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Championships(
	Year INT PRIMARY KEY,
	Wimbledon INT NOT NULL,
	FrOpen INT NOT NULL,
	USOpen INT NOT NULL,
	AuOpen INT NOT NULL
);

INSERT INTO Players(PlayerName)
VALUES
('Nadal'), ('Federer'), ('Novak');

INSERT INTO Championships
VALUES
(2018, 1, 1, 1, 1),
(2019, 1, 1, 2, 2),
(2020, 2, 1, 2, 2);

SELECT * FROM Players;
SELECT * FROM Championships;

-- 查询每位选手赢得大满贯赛事的次数

SELECT p.PlayerId, p.PlayerName, (SUM(p.PlayerId = c.Wimbledon) + SUM(p.PlayerId = c.FrOpen) + SUM(p.PlayerId = c.USOpen) + SUM(p.PlayerId = c.AuOpen)) AS GrandSlamsCount
FROM Players AS p
INNER JOIN Championships AS c
ON p.PlayerId = c.Wimbledon OR p.PlayerId = c.FrOpen OR p.PlayerId = c.USOpen OR p.PlayerId = c.AuOpen
GROUP BY p.PlayerId;

WITH temp AS
(
	SELECT Wimbledon AS PlayerId
	FROM Championships
	UNION ALL
	SELECT FrOpen AS PlayerId
	FROM Championships
	UNION ALL
	SELECT USOpen AS PlayerId
	FROM Championships
	UNION ALL
	SELECT AuOpen AS PlayerId
	FROM Championships
)
SELECT t.PlayerId, p.PlayerName, COUNT(*) AS GrandSlamsCount
FROM temp AS t
INNER JOIN Players AS p
ON t.PlayerId = p.PlayerId
GROUP BY t.PlayerId;

-- Exercise 047

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Calls;
DROP TABLE IF EXISTS Person;
DROP TABLE IF EXISTS Country;

CREATE TABLE IF NOT EXISTS Person(
	Id INT PRIMARY KEY,
	Name VARCHAR(30) NOT NULL,
	PhoneNumber VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Country(
	Name VARCHAR(30) PRIMARY KEY,
	CountryCode VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Calls(
	CallerId INT NOT NULL,
	CalleeId INT NOT NULL,
	Duration INT NOT NULL,
	FOREIGN KEY(CallerId) REFERENCES Person(Id),
	FOREIGN KEY(CalleeId) REFERENCES Person(Id)
);

INSERT INTO Person
VALUES
(3, 'Jonathan', '051-1234567'),
(12, 'Elvis', '051-7654321'),
(1, 'Moncef', '212-1234567'),
(2, 'Maroua', '212-6523651'),
(7, 'Meir', '972-1234567'),
(9, 'Rachel', '972-0011100');

INSERT INTO Country
VALUES
('peru', '051'),
('Israel', '972'),
('Morocco', '212'),
('Germany', '049'),
('Ethiopia', '251');

INSERT INTO Calls
VALUES
(1, 9, 33),
(2, 9, 4),
(1, 2, 59),
(3, 12, 102),
(3, 12, 330),
(12, 3, 5),
(7, 9, 13),
(7, 1, 3),
(9, 7, 1),
(1, 7, 7);

SELECT * FROM Person;
SELECT * FROM Country;
SELECT * FROM Calls;

-- 查询平均通话时间超过全球平均通话时长的国家

SELECT c2.Name AS 'Country'
FROM Calls AS c1
INNER JOIN Person AS p ON c1.CallerId = p.Id OR c1.CalleeId = p.Id
INNER JOIN Country AS c2 ON LEFT(p.PhoneNumber, 3) = c2.CountryCode
GROUP BY c2.Name
HAVING AVG(c1.Duration) >
(
	SELECT AVG(Duration) FROM Calls
);

-- Exercise 048

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Stocks;

CREATE TABLE IF NOT EXISTS Stocks(
	StockName VARCHAR(30),
	Operation ENUM('Buy', 'Sell') NOT NULL,
	OperationDay INT,
	Price INT NOT NULL,
	PRIMARY KEY(StockName, OperationDay)
);

INSERT INTO Stocks
VALUES
('Lee', 'Buy', 1, 1000),
('Corona Masks', 'Buy', 2, 10),
('Lee', 'Sell', 5, 9000),
('Handbags', 'Buy', 17, 30000),
('Corona Masks', 'Sell', 3, 1010),
('Corona Masks', 'Buy', 4, 1000),
('Corona Masks', 'Sell', 5, 500),
('Corona Masks', 'Buy', 6, 1000),
('Handbags', 'Sell', 29, 7000),
('Corona Masks', 'Sell', 10, 10000);

SELECT * FROM Stocks;

-- 查询每个账户的收益和损失

SELECT StockName, 
SUM(
	CASE Operation
		WHEN 'Buy' THEN Price * -1
		ELSE Price
	END
) AS CapitalGainLoss
FROM Stocks
GROUP BY StockName;

SELECT StockName, SUM(IF(Operation = 'Sell', Price, Price * -1)) AS CapitalGainLoss
FROM Stocks
GROUP BY StockName;

-- Exercise 049

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Teams;

CREATE TABLE IF NOT EXISTS Teams(
	TeamId INT PRIMARY KEY,
	TeamName VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Matches(
	MatchId INT PRIMARY KEY AUTO_INCREMENT,
	HostTeam INT NOT NULL,
	GuestTeam INT NOT NULL,
	HostGoals INT NOT NULL,
	GuestGoals INT NOT NULL,
	FOREIGN KEY(GuestTeam) REFERENCES Teams(TeamId),
	FOREIGN KEY(HostTeam) REFERENCES Teams(TeamId)
);

INSERT INTO Teams
VALUES
(10, 'Lee FC'),
(20, 'NewYork FC'),
(30, 'Atlanta FC'),
(40, 'Chicago FC'),
(50, 'Toronto FC');

INSERT INTO Matches(HostTeam, GuestTeam, HostGoals, GuestGoals)
VALUES
(10, 20, 3, 0),
(30, 10, 2, 2),
(10, 50, 5, 1),
(20, 30, 1, 0),
(50, 30, 1, 0);

SELECT * FROM Teams;
SELECT * FROM Matches;

-- 查询各个团队的得分（胜，3分，平，1分，负，0分）

WITH temp1 AS
(
	SELECT HostTeam AS TeamId,
	SUM(
		CASE
			WHEN HostGoals > GuestGoals THEN 3
			WHEN HostGoals = GuestGoals THEN 1
			ELSE 0
		END
	) AS Score
	FROM Matches
	GROUP BY HostTeam
	UNION ALL
	SELECT GuestTeam AS TeamId,
	SUM(
		CASE
			WHEN GuestGoals > HostGoals THEN 3
			WHEN GuestGoals = HostGoals THEN 1
			ELSE 0
		END
	) AS Score
	FROM Matches
	GROUP BY GuestTeam
),
temp2 AS
(
	SELECT TeamId, SUM(Score) AS NumPoints
	FROM temp1
	GROUP BY TeamId
)
SELECT t1.TeamId, t1.TeamName, IFNULL(t2.NumPoints, 0) AS NumPoints 
FROM Teams AS t1
LEFT JOIN temp2 AS t2
ON t1.TeamId = t2.TeamId;

SELECT t.TeamId, t.TeamName,
SUM(
	IF(t.TeamId = m.HostTeam,
		-- 主场
		IF(m.HostGoals > m.GuestGoals, 3, IF(m.HostGoals = m.GuestGoals, 1, 0)),
		-- 客场
		IF(m.GuestGoals > m.HostGoals, 3, IF(m.GuestGoals = m.HostGoals, 1, 0))
	)
) AS NumPoints
FROM Teams AS t
LEFT JOIN Matches AS m
ON m.HostTeam = t.TeamId OR m.GuestTeam = t.TeamId
GROUP BY t.TeamId;

-- Exercise 050

DROP DATABASE IF EXISTS exercise;
CREATE DATABASE IF NOT EXISTS exercise;

USE exercise;

DROP TABLE IF EXISTS Salaries;

CREATE TABLE IF NOT EXISTS Salaries(
	CompanyId INT,
	EmployeeId INT,
	EmployeeName VARCHAR(30) NOT NULL,
	Salary INT NOT NULL,
	PRIMARY KEY(CompanyId, EmployeeId)
);

INSERT INTO Salaries
VALUES
(1, 1, 'Tony', 2000),
(1, 2, 'Pronub', 21300),
(1, 3, 'Tyrrox', 10800),
(2, 1, 'Pam', 300),
(2, 7, 'Bassem', 450),
(2, 9, 'Hermione', 700),
(3, 7, 'Bocaben', 100),
(3, 2, 'Ognjen', 2200),
(3, 13, 'Nyancat', 3300),
(3, 15, 'Morninngcat', 7777);

SELECT * FROM Salaries;

-- 计算各个员工的税后工资（公司最高薪资，1000元以下，0%，1000~10000元，24%，10000元以上，49%）

WITH temp AS 
(
	SELECT CompanyId, 
	(
		CASE
			WHEN MAX(Salary) < 1000 THEN 0
			WHEN MAX(Salary) BETWEEN 1000 AND 10000 THEN 0.24
			ELSE 0.49
		END
	) AS TaxRate
	FROM Salaries
	GROUP BY CompanyId
)
SELECT s.CompanyId, s.EmployeeId, s.EmployeeName, 
ROUND((s.Salary * (1 - t.TaxRate)), 0) AS Salary 
FROM Salaries AS s
INNER JOIN temp AS t
ON t.CompanyId = s.CompanyId;
DROP DATABASE IF EXISTS chapter14;

CREATE DATABASE chapter14;

USE chapter14;

DROP TABLE IF EXISTS OrderInfo;

CREATE TABLE OrderInfo (
	OrderID INT PRIMARY KEY AUTO_INCREMENT,
	ProductBrand VARCHAR(50) NOT NULL,
	ProductName VARCHAR(50) NOT NULL,
	UnitPrice DECIMAL(10,2) NOT NULL,
	UnitsInStock INT,
	UnitsOnOrder INT
);

INSERT INTO OrderInfo VALUES
(NULL, '苹果', '手机', 9999, 100, 20),
(NULL, '苹果', '耳机', 599, 500, 50),
(NULL, '苹果', '平板', 5999, 300, 100),
(NULL, '苹果', '笔记本', 7999, 800, 100),
(NULL, '华为', '手机', 10999, 200, 100),
(NULL, '华为', '耳机', 399, 700, 200),
(NULL, '华为', '平板', 3999, 500, 100),
(NULL, '华为', '笔记本', 4999, 600, 300),
(NULL, '小米', '手机', 7999, 300, 220),
(NULL, '小米', '耳机', 299, 700, 150),
(NULL, '小米', '平板', 3999, 400, 50),
(NULL, '小米', '笔记本', 5999, 700, 450),
(NULL, '荣耀', '手机', 7999, 300, 120),
(NULL, '荣耀', '耳机', 299, 200, 100),
(NULL, '荣耀', '平板', 3999, 300, 30),
(NULL, '荣耀', '笔记本', 5999, 500, 220);

SELECT * FROM OrderInfo;
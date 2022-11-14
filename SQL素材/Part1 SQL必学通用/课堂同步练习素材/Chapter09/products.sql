CREATE TABLE Products(
	Pid INT PRIMARY KEY AUTO_INCREMENT,
	ProductName VARCHAR(50) NOT NULL,
	UnitPrice Decimal(10,2) NOT NULL,
	UnitsInStock INT,
	UnitsOnOrder INT
);

INSERT INTO Products VALUES
(NULL, '苹果手机', 9800, 100, 20),
(NULL, '华为手机', 8800, 200, 40),
(NULL, '小米手机', 7000, 200, NULL);
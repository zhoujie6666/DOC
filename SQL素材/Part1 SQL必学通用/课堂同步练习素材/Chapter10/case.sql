DROP TABLE IF EXISTS OrderInfo;

CREATE TABLE OrderInfo(
	CustomerName VARCHAR(50),
	Month VARCHAR(10),
	Amount INT
);

INSERT INTO OrderInfo VALUES('张三','1月',50),('张三','2月',100),('张三','3月',200),
('李四','1月',70),('李四','2月',100),('李四','3月',150),
('王五','1月',200),('王五','2月',300),('王五','3月',800);

SELECT * FROM OrderInfo;
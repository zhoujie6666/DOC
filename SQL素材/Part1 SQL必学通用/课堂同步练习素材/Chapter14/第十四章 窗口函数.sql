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

-- 查询所有商品的最高价格和平均价格
SELECT MAX(UnitPrice) AS MaxUnitPrice FROM OrderInfo;
SELECT AVG(UnitPrice) AS AvgUnitPrice FROM OrderInfo;

-- 查询各个产品类别的最高价格和平均价格
SELECT ProductName, MAX(UnitPrice) AS MaxUnitPrice, AVG(UnitPrice) AS AvgUnitPrice
FROM OrderInfo
GROUP BY ProductName;

SELECT OrderID, ProductName, MAX(UnitPrice) AS MaxUnitPrice, AVG(UnitPrice) AS AvgUnitPrice
FROM OrderInfo
GROUP BY ProductName;

-- 什么是窗口函数
-- OVER子句指定窗口分区方式
-- OVER子句参数为空，整个查询结果集作为单一分区
SELECT temp.*, CONCAT(ROUND(temp.UnitPrice / temp.MaxUnitPrice,2)*100,'%') AS Ratio
FROM
(SELECT *, MAX(UnitPrice) OVER() AS MaxUnitPrice FROM OrderInfo) AS temp;

SELECT *, MAX(UnitPrice) OVER() AS MaxUnitPrice FROM OrderInfo;
SELECT *, AVG(UnitPrice) OVER() AS AvgUnitPrice FROM OrderInfo;
SELECT *, MAX(UnitPrice) OVER() AS MaxUnitPrice, AVG(UnitPrice) OVER() AS AvgUnitPrice FROM OrderInfo;

-- PARTITION BY，按照某个字段进行分区
SELECT *, MAX(UnitPrice) OVER(PARTITION BY ProductName) AS MaxUnitPrice FROM OrderInfo;
SELECT *, AVG(UnitPrice) OVER(PARTITION BY ProductName) AS AvgUnitPrice FROM OrderInfo;
SELECT *, 
MAX(UnitPrice) OVER(PARTITION BY ProductName) AS MaxUnitPrice, 
AVG(UnitPrice) OVER(PARTITION BY ProductName) AS AvgUnitPrice 
FROM OrderInfo;

-- ROW_NUMBER函数
SELECT *,ROW_NUMBER() OVER() AS RN FROM OrderInfo;
SELECT *,ROW_NUMBER() OVER(PARTITION BY ProductName) AS RN FROM OrderInfo;
-- ORDER BY，对分区内的记录进行排序
SELECT *,ROW_NUMBER() OVER(PARTITION BY ProductName Order BY UnitPrice DESC) AS RN FROM OrderInfo;

-- 查询各产品类别价格排名最高的商品信息
SELECT * 
FROM (
	SELECT *,ROW_NUMBER() OVER(PARTITION BY ProductName Order BY UnitPrice DESC) AS RN FROM OrderInfo
) AS temp
WHERE temp.RN = 1;

-- WITH语句
WITH temp AS
(
	SELECT *,ROW_NUMBER() OVER(PARTITION BY ProductName Order BY UnitPrice DESC) AS RN FROM OrderInfo
)
SELECT * FROM temp 
WHERE temp.RN = 1;

-- 查询各产品类别价格排名前两名的商品信息
WITH temp AS
(
	SELECT *,ROW_NUMBER() OVER(PARTITION BY ProductName Order BY UnitPrice DESC) AS RN FROM OrderInfo
)
SELECT * FROM temp 
WHERE temp.RN <= 2;

-- 查询各产品类别订单数量最高的商品信息
SELECT *, ROW_NUMBER() OVER(PARTITION BY ProductName Order BY UnitsOnOrder DESC) AS RN FROM OrderInfo;

WITH temp AS
(
	SELECT *, ROW_NUMBER() OVER(PARTITION BY ProductName Order BY UnitsOnOrder DESC) AS RN FROM OrderInfo
)
SELECT * FROM temp
WHERE temp.RN = 1;

SELECT *, ROW_NUMBER() OVER(PARTITION BY ProductName Order BY UnitsOnOrder DESC) AS RN FROM OrderInfo;
-- RANK函数
SELECT *, RANK() OVER(PARTITION BY ProductName Order BY UnitsOnOrder DESC) AS RNK FROM OrderInfo;
-- DENSE_RANK函数
SELECT *, DENSE_RANK() OVER(PARTITION BY ProductName Order BY UnitsOnOrder DESC) AS DR FROM OrderInfo;

SELECT *,
	ROW_NUMBER() OVER(PARTITION BY ProductName Order BY UnitsOnOrder DESC) AS RN,
	RANK() OVER(PARTITION BY ProductName Order BY UnitsOnOrder DESC) AS RNK,
	DENSE_RANK() OVER(PARTITION BY ProductName Order BY UnitsOnOrder DESC) AS DR
FROM OrderInfo;

WITH temp AS
(
	SELECT *,
		DENSE_RANK() OVER(PARTITION BY ProductName Order BY UnitsOnOrder DESC) AS DR
	FROM OrderInfo
)
SELECT * FROM temp
WHERE temp.DR <= 2;

-- 窗口命名之WINDOW子句
SELECT *,
	ROW_NUMBER() OVER w AS RN,
	RANK() OVER w AS RNK,
	DENSE_RANK() OVER w AS DR
FROM OrderInfo
WINDOW w AS (PARTITION BY ProductName Order BY UnitPrice DESC);


-- FRAME子句设置
SELECT *, SUM(UnitsOnOrder) OVER(
	PARTITION BY ProductName ORDER BY UnitsOnOrder ) AS SUM 
FROM OrderInfo;

SELECT *, SUM(UnitsOnOrder) OVER(
	PARTITION BY ProductName ORDER BY UnitsOnOrder 
	RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS SUM 
FROM OrderInfo;

-- 未设置分区，未设置排序
-- 整个查询结果集作为一个分区，整个分区作为一个单位
SELECT *, SUM(UnitsOnOrder) OVER() AS SUM FROM OrderInfo;

-- 明确分区情况
-- 明确Frame单位情况
-- 明确Current Row、Unbounded Preceding具体的含义
-- CURRENT ROW：当前单位的末尾行
SELECT *, SUM(UnitsOnOrder) OVER(
	RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS SUM FROM OrderInfo;

-- 设置了分区，未设置排序
-- 划分分区，各个分区是一个单位
SELECT *, SUM(UnitsOnOrder) OVER(PARTITION BY ProductName) AS SUM FROM OrderInfo;

SELECT *, SUM(UnitsOnOrder) OVER(
	PARTITION BY ProductName
	RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS SUM FROM OrderInfo;

-- 未设置分区，设置了排序
SELECT *, SUM(UnitsOnOrder) OVER(ORDER BY UnitsOnOrder) AS SUM FROM OrderInfo;

SELECT *, SUM(UnitsOnOrder) OVER(
	ORDER BY UnitsOnOrder
	RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS SUM FROM OrderInfo;

-- 设置了分区，又设置排序
SELECT *, SUM(UnitsOnOrder) OVER(PARTITION BY ProductName ORDER BY UnitsOnOrder) AS SUM FROM OrderInfo;

SELECT *, SUM(UnitsOnOrder) OVER(
	PARTITION BY ProductName ORDER BY UnitsOnOrder
	RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS SUM FROM OrderInfo;

SELECT *, SUM(UnitsOnOrder) OVER(
	PARTITION BY ProductName ORDER BY UnitsOnOrder 
	RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS SUM 
FROM OrderInfo;

SELECT *, SUM(UnitsOnOrder) OVER(
	PARTITION BY ProductName ORDER BY UnitsOnOrder 
	RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) AS SUM 
FROM OrderInfo;

-- ROWS：一行为一个单位
SELECT *, SUM(UnitsOnOrder) OVER(
	PARTITION BY ProductName ORDER BY UnitsOnOrder
	ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS SUM FROM OrderInfo;

-- CURRENT ROW：当前单位的末尾行
-- UNBOUNDED PRECEDING：当前单位的末尾行上方所有行（分区）
-- UNBOUNDED FOLLOWING：当前单位的末尾行下方所有行（分区）
-- n PRECEDING：当前单位的末尾行上方n行（分区）
-- n FOLLOWING：当前单位的末尾行下方n行（分区）

SELECT *, SUM(UnitsOnOrder) OVER(
	PARTITION BY ProductName ORDER BY UnitsOnOrder
	-- 默认效果：ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
	ROWS 1 PRECEDING
) AS SUM FROM OrderInfo;

SELECT *, SUM(UnitsOnOrder) OVER(
	PARTITION BY ProductName ORDER BY UnitsOnOrder
	ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS SUM FROM OrderInfo;

SELECT *, SUM(UnitsOnOrder) OVER(
	PARTITION BY ProductName ORDER BY UnitsOnOrder
	ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING
) AS SUM FROM OrderInfo;

SELECT *, SUM(UnitsOnOrder) OVER(
	PARTITION BY ProductName ORDER BY UnitsOnOrder
	ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
) AS SUM FROM OrderInfo;

-- LAG与LEAD函数
SELECT * FROM OrderInfo;

-- 针对哪个字段往下移动
SELECT *,
LAG(UnitsOnOrder) OVER(PARTITION BY ProductName ORDER BY UnitsOnOrder) AS Lg
FROM OrderInfo;

-- 移动几行
SELECT *,
LAG(UnitsOnOrder, 2) OVER(PARTITION BY ProductName ORDER BY UnitsOnOrder) AS Lg
FROM OrderInfo;

-- 如果遇到NULL情况，采用什么数据填充
SELECT *,
LAG(UnitsOnOrder, 2, 0) OVER(PARTITION BY ProductName ORDER BY UnitsOnOrder) AS Lg
FROM OrderInfo;

SELECT *,
Lead(UnitsOnOrder) OVER(PARTITION BY ProductName ORDER BY UnitsOnOrder) AS Ld
FROM OrderInfo;

SELECT *,
Lead(UnitsOnOrder, 2) OVER(PARTITION BY ProductName ORDER BY UnitsOnOrder) AS Ld
FROM OrderInfo;

SELECT *,
Lead(UnitsOnOrder, 2, 0) OVER(PARTITION BY ProductName ORDER BY UnitsOnOrder) AS Ld
FROM OrderInfo;

-- 呈现差值计算效果
SELECT *,
LAG(UnitsOnOrder, 1, 0) OVER(PARTITION BY ProductName ORDER BY UnitsOnOrder) AS Lg
FROM OrderInfo;

SELECT *,
LAG(UnitsOnOrder, 1, 0) OVER(PARTITION BY ProductName ORDER BY UnitsOnOrder) AS Lg,
(UnitsOnOrder - (LAG(UnitsOnOrder, 1, 0) OVER(PARTITION BY ProductName ORDER BY UnitsOnOrder))) AS DValue
FROM OrderInfo;

SELECT temp.*, (temp.UnitsOnOrder - temp.Lg) AS DValue
FROM
(
	SELECT *,
	LAG(UnitsOnOrder, 1, 0) OVER(PARTITION BY ProductName ORDER BY UnitsOnOrder) AS Lg
	FROM OrderInfo
) AS temp;

WITH temp AS
(
	SELECT *,
	LAG(UnitsOnOrder, 1, 0) OVER(PARTITION BY ProductName ORDER BY UnitsOnOrder) AS Lg
	FROM OrderInfo
)
SELECT temp.*, (temp.UnitsOnOrder - temp.Lg) AS DValue
FROM temp;

-- FIRST_VALUE、LAST_VALUE、NTH_VALUE
SELECT * FROM OrderInfo ORDER BY ProductName;

-- 查询各产品类别价格最高、最低、排名第二的商品的产品品牌名称
SELECT *,
	FIRST_VALUE(ProductBrand) OVER w AS HighPriceBrand,
	LAST_VALUE(ProductBrand) OVER w AS LowPriceBrand,
	NTH_VALUE(ProductBrand, 2) OVER w AS SecondPriceBrand
FROM OrderInfo
WINDOW w AS (PARTITION BY ProductName ORDER BY UnitPrice DESC
							RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING);

-- NTILE函数
-- 把数据分桶，如果数据分配不均匀，默认增加第一个桶中数据数量

-- 按订单价值进行分级
SELECT * FROM OrderInfo;

SELECT *, UnitPrice * UnitsOnOrder AS OrderValue FROM OrderInfo ORDER BY OrderValue DESC;

WITH temp AS
(
	SELECT *,
		NTILE(3) OVER(ORDER BY UnitPrice * UnitsOnOrder DESC) AS Nt
	FROM OrderInfo
)
SELECT temp.ProductBrand, temp.ProductName, (temp.UnitPrice * temp.UnitsOnOrder) AS OrderValue,
	(
		CASE
			WHEN temp.Nt = 1 THEN 'BestSellerProduct'
			WHEN temp.Nt = 2 THEN 'SecondSellerProduct'
			ELSE 'WorstSellerProduct'
		END
	) AS Level
FROM temp;

-- CUME_DIST，获得累积分布
-- 查询订单价值的累积分布
-- 条数 / 总条数
SELECT *,CUME_DIST() OVER(ORDER BY UnitPrice * UnitsOnOrder DESC) AS Cd
FROM OrderInfo;

SELECT temp.* 
FROM
(
	SELECT *,
	CUME_DIST() OVER(ORDER BY UnitPrice * UnitsOnOrder DESC) AS Cd
	FROM OrderInfo
) AS temp
WHERE temp.Cd <= 0.3;

-- PERCENT_RANK，获得百分位数排名
-- 按照订单价值获得百分位数排名
-- (条数 - 1) / (总条数 - 1)
SELECT *,ROUND(PERCENT_RANK() OVER(ORDER BY UnitPrice * UnitsOnOrder DESC), 2) AS Pr
FROM OrderInfo;

SELECT temp.*
FROM
(
	SELECT *,
	ROUND(PERCENT_RANK() OVER(ORDER BY UnitPrice * UnitsOnOrder DESC), 2) AS Pr
	FROM OrderInfo
) AS temp
WHERE temp.Pr <= 0.3;
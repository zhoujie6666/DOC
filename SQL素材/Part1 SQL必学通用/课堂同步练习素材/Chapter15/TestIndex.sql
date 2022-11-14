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
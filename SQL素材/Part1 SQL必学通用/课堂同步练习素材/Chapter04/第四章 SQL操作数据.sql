-- 查询数据

-- 查询全字段数据
SELECT * FROM chapter04.employee;

USE chapter04;
SELECT * FROM Employee;

-- 查询指定字段数据
SELECT Name, Salary FROM Employee;
SELECT Employee.Name, Employee.Salary FROM Employee;

-- 为字段取别名
SELECT Name AS "姓名", Salary AS "月薪" FROM Employee;
SELECT Name "姓名", Salary "月薪" FROM Employee;

-- 根据主键获取某一条记录
SELECT 
	EmployeeID AS "工号", 
	Name AS "姓名", 
	Age AS "年龄",
	Salary AS "月薪" 
FROM Employee 
WHERE EmployeeID = 10;

-- 修改全部数据
UPDATE Employee SET Salary = Salary + 1000;

-- 修改指定数据
UPDATE Employee SET Salary = Salary + 1000 WHERE EmployeeID = 10;
UPDATE Employee SET Salary = Salary + 1000, Age = Age + 10 WHERE EmployeeID = 10;

-- 删除全部数据
DELETE FROM Employee;

-- 删除指定数据
DELETE FROM Employee WHERE EmployeeID = 10;



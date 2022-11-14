CREATE DATABASE chapter07;

USE chapter07;

DROP TABLE IF EXISTS Employee;

CREATE TABLE IF NOT EXISTS Employee (
	EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
	Name VARCHAR ( 50 ) NOT NULL,
	Gender ENUM ( '男', '女' ),
	Age INT UNSIGNED,
	JobPosition ENUM ( '业务经理', '开发人员', '顾问' ) NOT NULL,
	Salary DECIMAL ( 10, 2 ) NOT NULL DEFAULT 0,
	JoinedAt DATE
);

INSERT INTO Employee(Name,Gender,Age,JobPosition,Salary,JoinedAt) 
VALUES
('张吉','男',29,'开发人员',19000,'2014-05-21'),
('林国','女',29,'顾问',14400,'2015-06-15'),
('林玟','女',26,'业务经理',12200,'2019-12-08'),
('林雅','女',30,'顾问',28400,'2021-06-12'),
('江奕','女',33,'业务经理',26500,'2018-03-23'),
('刘柏','男',26,'顾问',13300,'2018-12-26'),
('阮建安','男',22,'开发人员',22500,'2018-12-29'),
('林子','男',35,'开发人员',25700,'2020-04-15'),
('夏志豪','男',30,'开发人员',17800,'2019-03-20'),
('吉茹','男',30,'业务经理',19800,'2021-01-18'),
('李中冰','女',27,'顾问',27600,'2019-07-15'),
('黄文隆','女',25,'顾问',24300,'2016-04-09'),
('谢彦','女',23,'业务经理',22700,'2019-08-09'),
('傅智翔','女',34,'业务经理',28100,'2018-02-10'),
('洪振霞','男',29,'顾问',16500,'2021-11-11'),
('刘姿婷','女',23,'顾问',14000,'2021-03-14'),
('荣姿康','男',26,'顾问',26800,'2020-05-06'),
('吕致盈','女',26,'顾问',23800,'2014-10-02'),
('方一','男',30,'开发人员',24700,'2017-11-21'),
('黎芸贵','男',24,'业务经理',15600,'2018-01-09'),
('郑伊','男',22,'顾问',13300,'2017-11-13'),
('雷进宝','女',28,'业务经理',29500,'2017-02-20'),
('吴美','女',28,'开发人员',14400,'2016-11-05'),
('吴心真','男',28,'开发人员',29100,'2015-04-26'),
('王美','女',22,'开发人员',28200,'2017-02-12'),
('郭芳','女',22,'顾问',27600,'2018-08-24'),
('李雅惠','男',25,'开发人员',28700,'2016-03-26'),
('陈文婷','男',23,'业务经理',22200,'2017-05-24'),
('曹敏侑','男',27,'顾问',25500,'2016-09-11'),
('王依','男',31,'业务经理',17000,'2015-06-22'),
('陈婉','男',24,'顾问',25100,'2020-06-05'),
('吴美','男',31,'顾问',28500,'2014-08-12'),
('蔡依','女',31,'顾问',13200,'2019-03-16'),
('郑昌','男',33,'业务经理',14200,'2018-06-11'),
('林家','男',34,'顾问',13000,'2016-12-19'),
('黄丽','女',27,'顾问',27400,'2020-08-01'),
('李育泉','男',34,'开发人员',18300,'2022-02-16'),
('黄芸欢','男',22,'开发人员',16400,'2015-04-16'),
('吴韵如','女',33,'业务经理',17800,'2014-03-15'),
('李肇芬','男',35,'顾问',12100,'2014-11-18'),
('卢木仲','男',34,'开发人员',22800,'2022-02-07'),
('李成白','女',33,'顾问',16600,'2014-09-11'),
('方兆','女',23,'顾问',13000,'2017-04-30'),
('刘翊惠','女',28,'业务经理',25200,'2017-08-01'),
('丁汉','女',24,'开发人员',15700,'2015-07-14'),
('吴佳瑞','男',26,'顾问',17100,'2017-05-22'),
('舒绿','女',33,'业务经理',22900,'2014-12-23'),
('周白','男',22,'开发人员',17400,NULL),
('张姿','女',32,'开发人员',18000,NULL),
('张虹','女',34,'开发人员',24800,NULL),
('周琼玟','女',33,'业务经理',18300,NULL),
('倪怡芳','男',28,'业务经理',29100,NULL),
('郭贵','男',35,'业务经理',23300,'2018-06-13'),
('杨佩芳','女',22,'顾问',18200,'2017-03-16'),
('黄文','男',23,'业务经理',26200,'2020-11-27'),
('黄盛','女',35,'业务经理',13100,'2014-10-26'),
('郑丽','男',35,'业务经理',12400,'2019-03-09'),
('许智云','男',22,'顾问',12600,'2019-05-29'),
('张孟','女',30,'顾问',25800,'2020-03-02'),
('李小爱','女',22,'开发人员',12800,'2022-03-05'),
('王恩','男',29,'开发人员',29100,'2017-07-19'),
('朱政廷','女',23,'顾问',12400,'2016-04-14'),
('邓诗涵','男',27,'开发人员',28400,'2020-11-03'),
('陈政倩','女',29,'业务经理',22000,'2014-10-18'),
('吴俊','男',23,'业务经理',17200,'2021-01-12'),
('阮馨','男',26,'业务经理',29000,'2014-12-27'),
('翁惠珠','女',27,'顾问',23700,'2014-11-25'),
('吴思翰','男',27,'开发人员',29700,'2017-02-06'),
('林佩','女',24,'开发人员',21200,'2017-10-15'),
('邓海来','女',34,'顾问',12100,'2021-02-08'),
('陈翊依','女',22,'业务经理',18900,'2020-03-16'),
('李建智','女',27,'顾问',16400,'2018-10-26'),
('武淑','女',27,'顾问',24300,'2019-12-07'),
('金雅琪','男',32,'业务经理',20000,'2014-09-14'),
('赖怡','女',22,'开发人员',18400,'2021-06-03'),
('黄育','男',24,'开发人员',27300,'2014-08-29'),
('张仪湖','男',34,'顾问',22800,'2015-01-13'),
('王俊','男',26,'业务经理',19600,'2017-10-14'),
('张诗','男',31,'顾问',28400,'2016-04-27'),
('林慧','女',35,'顾问',23300,'2016-01-24'),
('沈俊君','男',26,'开发人员',17500,'2021-06-23'),
('陈淑妤','女',32,'开发人员',21000,'2016-01-09'),
('李姿伶','男',28,'业务经理',30000,'2016-12-26'),
('高咏钰','男',28,'顾问',12300,'2018-08-11'),
('黄彦','男',34,'顾问',19200,'2021-11-23'),
('周孟儒','女',22,'业务经理',13900,'2021-06-05'),
('潘欣臻','女',24,'开发人员',13700,'2015-08-21'),
('李祯韵','男',28,'顾问',26900,'2017-12-09'),
('叶洁启','女',31,'业务经理',27100,'2014-10-13'),
('梁哲宇','女',31,'顾问',21800,'2016-10-03'),
('黄晓','男',25,'业务经理',19000,'2020-11-14'),
('杨雅','男',28,'业务经理',26700,'2017-02-13'),
('卢志','女',24,'开发人员',24700,'2021-08-01'),
('张茂以','男',28,'顾问',28000,'2018-12-01'),
('林婉','女',33,'开发人员',14500,'2017-06-17'),
('蔡宜','女',31,'开发人员',22400,'2016-01-26'),
('林珮','女',30,'顾问',20600,'2014-06-07'),
('黄柏仪','女',31,'开发人员',12300,'2018-01-17'),
('周逸','女',25,'业务经理',13100,'2021-01-09'),
('夏雅','女',25,'顾问',14600,'2015-01-02'),
('王采珮','男',31,'顾问',29200,'2018-05-20'),
('林孟','男',29,'开发人员',20200,'2017-03-31'),
('林竹','女',24,'顾问',23300,'2021-01-17'),
('王怡','男',31,'开发人员',20800,'2021-01-27'),
('王爱','女',25,'顾问',25100,'2015-09-04'),
('金佳蓉','女',29,'顾问',18800,'2016-04-08'),
('韩健','女',28,'开发人员',19800,'2020-01-22'),
('李士杰','女',26,'顾问',27600,'2014-07-22'),
('陈萱','男',23,'业务经理',23300,'2016-01-21'),
('苏姿','男',31,'顾问',18100,'2018-03-09'),
('张政','女',34,'开发人员',24700,'2019-05-29'),
('李志宏','女',24,'业务经理',23300,'2022-03-01'),
('陈素达','女',32,'开发人员',25700,'2018-01-29'),
('陈虹荣','男',34,'顾问',21000,'2015-12-21'),
('何美玲','男',35,'业务经理',18900,'2018-03-18'),
('李仪','女',27,'顾问',26200,'2021-05-18'),
('张俞','女',34,'开发人员',21400,'2016-09-04'),
('黄秋','男',33,'业务经理',20800,'2016-02-04'),
('潘吉','女',30,'开发人员',23100,'2016-10-25'),
('陈智','女',30,'顾问',13700,'2019-11-03'),
('蔡书玮','女',30,'顾问',15000,'2019-11-25'),
('陈信峰','女',25,'开发人员',28700,'2020-10-10'),
('林培','男',30,'业务经理',24000,'2019-11-23'),
('查瑜','男',28,'开发人员',29700,'2021-02-21'),
('黎慧','女',34,'业务经理',19700,'2018-12-18'),
('郑士','女',34,'开发人员',24900,'2021-08-27'),
('陈建','男',26,'开发人员',26800,'2017-01-20'),
('吴怡婷','女',22,'开发人员',23900,'2014-09-15'),
('徐紫','男',25,'开发人员',19600,'2020-02-16'),
('张博','男',22,'顾问',16300,'2018-05-27'),
('黎宏儒','男',25,'顾问',13800,'2018-04-25'),
('柯乔','男',32,'开发人员',20800,'2015-05-07'),
('胡睿','男',33,'顾问',23800,'2021-12-23'),
('王淑月','女',25,'业务经理',22700,'2021-04-17'),
('陈百菁','男',23,'业务经理',25200,'2014-03-24'),
('王雅','女',29,'开发人员',17500,'2015-01-17'),
('黄佩','女',25,'开发人员',27100,'2014-12-25'),
('李必','女',30,'开发人员',19500,'2019-11-28'),
('吴耀','男',35,'顾问',16800,'2020-03-06'),
('彭郁婷','男',31,'开发人员',21000,'2021-12-10'),
('王秀','女',32,'业务经理',25500,'2015-11-03'),
('谢佳儒','女',26,'业务经理',28500,'2020-07-04'),
('罗静','女',24,'顾问',28000,'2022-03-26'),
('杨舒','男',28,'业务经理',14900,'2015-09-29'),
('蔡政琳','女',23,'业务经理',12200,'2020-10-16'),
('杨绍瑜','男',26,'业务经理',14700,'2018-03-19'),
('金育木','女',22,'顾问',24700,'2017-07-28'),
('杨韦','女',30,'业务经理',25600,'2017-07-18'),
('韩宁','女',31,'开发人员',21600,'2014-09-20'),
('蒋廷','男',24,'业务经理',22900,'2018-10-02'),
('毛展','女',34,'顾问',14000,'2018-11-18'),
('廖婉宏','女',24,'顾问',17900,'2019-10-07'),
('黄怡强','男',28,'业务经理',27300,'2019-08-05'),
('郭冰','女',31,'顾问',20900,'2015-08-21'),
('黄伟依','男',33,'开发人员',27300,'2015-01-20'),
('叶元','女',30,'顾问',24500,'2016-12-07'),
('林智超','女',31,'顾问',25100,'2017-11-25'),
('李姿','女',30,'顾问',17900,'2016-11-10'),
('李莉火','男',34,'业务经理',17300,'2015-12-10'),
('邱雅','男',23,'开发人员',26700,'2020-10-25'),
('王淑','男',35,'顾问',13100,'2015-08-10'),
('陈枝','男',27,'开发人员',12400,'2016-07-21'),
('高成','女',32,'业务经理',25900,'2016-02-03'),
('徐采伶','男',30,'开发人员',19500,'2014-11-02'),
('杨大雪','女',31,'开发人员',21200,'2019-10-02'),
('林彦','男',29,'业务经理',26200,'2014-06-18'),
('李升','男',28,'顾问',15300,'2014-11-05'),
('邱宜','男',25,'开发人员',12700,'2022-02-24'),
('陈政','女',22,'顾问',22800,'2018-07-24'),
('李宜豪','男',32,'业务经理',27200,'2015-04-10'),
('陈宜','男',23,'业务经理',12100,'2021-12-06'),
('陈志','男',32,'顾问',20500,'2014-03-14'),
('阮柔治','男',35,'业务经理',21600,'2016-02-25'),
('林乐','女',29,'开发人员',19600,'2016-11-29'),
('简健','女',31,'业务经理',26100,'2021-07-12'),
('廖雅','女',32,'业务经理',29600,'2018-03-06'),
('梁佩芬','男',23,'顾问',25000,'2018-07-20'),
('苏玮','男',35,'开发人员',16600,'2021-09-03'),
('秦娇真','男',27,'顾问',28200,'2016-11-08'),
('谢佳','女',27,'开发人员',21900,'2018-10-16'),
('李仁','男',22,'业务经理',12200,'2015-05-20'),
('李佳','男',31,'顾问',20000,'2016-09-28'),
('郭贤','男',34,'业务经理',13500,'2020-01-26'),
('吴怡','男',24,'业务经理',17500,'2017-02-27'),
('陈怡婷','男',26,'业务经理',17100,'2016-06-05'),
('阮晴','男',32,'顾问',20300,'2020-08-12'),
('辛翔坤','男',28,'顾问',22100,'2021-12-21'),
('林孟富','男',28,'开发人员',15200,'2016-03-19'),
('刘美玲','男',26,'顾问',12500,'2018-06-29'),
('涂昀琬','男',22,'顾问',21000,'2018-10-23'),
('白凯修','女',25,'开发人员',13000,'2022-03-13'),
('黄蓉芳','男',29,'顾问',20300,'2017-05-05'),
('赵吟琪','男',35,'开发人员',20200,'2018-09-10'),
('张裕','男',22,'业务经理',29600,'2018-08-19'),
('石春','女',27,'顾问',15800,'2015-06-26'),
('方美君','女',28,'顾问',15300,'2020-08-28'),
('潘右博','女',34,'开发人员',16900,'2016-03-11'),
('俞星如','男',29,'业务经理',28500,'2015-04-14'),
('张冠','男',23,'开发人员',20100,'2017-03-11'),
('钟庭','男',22,'开发人员',19600,'2018-11-21'),
('叶茜','男',34,'开发人员',27800,'2016-10-20'),
('陈伯','男',32,'顾问',26500,'2020-05-07'),
('陈昭','女',25,'顾问',24500,'2015-12-29'),
('陈伟伦','男',28,'业务经理',22700,'2016-01-02'),
('黄雅慧','女',24,'开发人员',28400,'2018-03-28'),
('郭子','男',28,'顾问',18700,'2018-12-20'),
('黄彦','女',32,'开发人员',22500,'2021-03-27'),
('宋合','男',24,'业务经理',15500,'2014-09-28'),
('许雅婷','女',23,'开发人员',17100,'2016-04-06'),
('王圣','女',29,'业务经理',19700,'2021-01-06'),
('何伶元','女',24,'开发人员',28400,'2014-04-08'),
('钟伦','男',29,'业务经理',14900,'2020-08-26'),
('蔡佳','女',23,'开发人员',21500,'2022-03-05'),
('溥康','男',22,'顾问',26100,'2020-10-31'),
('冯成轩','男',30,'业务经理',28900,'2019-09-24'),
('陈嘉','男',35,'开发人员',28100,'2015-04-21'),
('吴惠劭','男',32,'业务经理',29500,'2020-02-08'),
('谢健铭','男',31,'开发人员',12400,'2014-11-26'),
('林怡','女',28,'业务经理',21700,'2020-09-26'),
('廖佳','男',25,'业务经理',25800,'2018-03-03'),
('李佩','男',28,'业务经理',16100,'2017-08-24'),
('何珮甄','女',35,'开发人员',28700,'2021-02-15'),
('谢晓','男',29,'开发人员',19500,'2020-05-13'),
('许彦霖','男',23,'顾问',23800,'2021-01-15'),
('林威','男',30,'顾问',20200,'2020-12-15'),
('周佳勋','女',26,'业务经理',17900,'2019-04-10'),
('林静','男',34,'顾问',20500,'2018-04-03'),
('周筠','男',22,'开发人员',23200,'2017-07-22'),
('陈仲','女',26,'开发人员',17900,'2018-02-25'),
('胡东','男',27,'开发人员',22200,'2021-09-01'),
('陈绍翰','女',35,'业务经理',17000,'2022-03-20'),
('梁姵来','女',34,'顾问',21700,'2017-07-18'),
('陈雅','男',27,'开发人员',29100,'2014-03-03'),
('张莉雯','女',33,'顾问',18500,'2014-03-12'),
('陈韦','男',22,'开发人员',17800,'2017-11-16'),
('林素','女',32,'业务经理',18900,'2021-01-03'),
('李菁','男',28,'业务经理',12200,'2015-04-27'),
('蔡玉婷','男',30,'开发人员',29600,'2020-01-08'),
('郑智钧','男',31,'业务经理',28600,'2015-01-26'),
('吴孟钰','女',31,'开发人员',19300,'2015-04-12'),
('蔡国伟','男',28,'开发人员',19300,'2019-05-27'),
('连俊达','女',33,'业务经理',12800,'2018-02-27'),
('李雅婷','男',27,'业务经理',15200,'2020-11-12'),
('李礼','男',33,'业务经理',19800,'2018-02-24'),
('李忆孝','男',24,'顾问',26200,'2014-06-15'),
('黄静','女',34,'业务经理',13700,'2017-06-05'),
('陈淳','女',32,'业务经理',15400,'2018-10-17'),
('李文','男',34,'顾问',26700,'2022-01-31'),
('林佳蓉','男',29,'开发人员',13200,'2014-08-31'),
('罗依茂','女',29,'业务经理',21800,'2017-02-17'),
('李淑佩','男',30,'业务经理',14700,'2017-08-15'),
('谢怡君','男',34,'开发人员',20700,'2022-01-16'),
('王美','男',33,'业务经理',28800,'2016-09-02'),
('黄慧学','女',23,'业务经理',13400,'2017-08-05'),
('邓幸','男',35,'开发人员',27500,'2014-12-21'),
('陈秀琬','男',31,'开发人员',21700,'2014-04-07'),
('许岳','女',22,'开发人员',28100,'2022-05-07'),
('许爱礼','女',26,'业务经理',22800,'2015-03-29'),
('谢一忠','男',27,'业务经理',20200,'2018-01-12'),
('简志','女',22,'顾问',18600,'2016-10-14'),
('赵若喜','男',28,'顾问',24900,'2018-06-25'),
('许承','男',28,'开发人员',12200,'2016-01-21'),
('姚哲维','男',33,'业务经理',22700,'2018-06-26'),
('苏俊','男',27,'业务经理',25800,'2018-12-15'),
('郭礼钰','男',33,'顾问',27000,'2017-12-02'),
('姜佩珊','女',26,'开发人员',20800,'2019-01-20'),
('张鸿信','男',22,'顾问',14800,'2021-10-22'),
('秦欣瑜','女',26,'开发人员',22100,'2017-09-16'),
('李旺','男',27,'顾问',26600,'2016-01-11'),
('陈怡','女',22,'开发人员',20300,'2016-12-05'),
('陈秀德','女',30,'业务经理',25300,'2019-06-10'),
('张佳','女',32,'开发人员',13000,'2014-08-06'),
('郑凯','男',28,'顾问',17800,'2021-02-09'),
('郑雅','女',22,'顾问',19400,'2021-04-17'),
('黄国妹','男',31,'顾问',13800,'2014-10-05'),
('林芳','男',27,'业务经理',29400,'2017-10-04'),
('江骏','女',33,'业务经理',25900,'2014-08-01'),
('黄儒纯','男',32,'顾问',25800,'2017-05-28'),
('王培伦','女',23,'顾问',17900,'2017-09-26'),
('陈蕙','男',25,'业务经理',27100,'2018-06-20'),
('蔡宜慧','女',29,'业务经理',17200,'2016-12-18'),
('陈信','女',31,'顾问',18900,'2020-10-17'),
('陈惠','男',27,'顾问',22000,'2020-07-01'),
('张琇纶','女',30,'开发人员',28100,'2019-11-30'),
('黄碧仪','男',33,'业务经理',29400,'2018-03-16'),
('陈志文','男',32,'业务经理',27600,'2021-12-25'),
('谢懿富','女',34,'开发人员',18400,'2018-12-27'),
('杨凡','女',28,'顾问',21200,'2015-12-31'),
('蔡秀琴','女',35,'业务经理',12100,'2016-01-15'),
('温惠玲','男',28,'业务经理',18700,'2020-05-20'),
('林宗其','男',30,'顾问',27500,'2017-12-13'),
('林绍泰','男',35,'业务经理',16900,'2019-04-03'),
('何佳','女',28,'业务经理',19000,'2015-09-19'),
('蔡辰纶','女',29,'业务经理',15600,'2015-03-29'),
('王雅雯','女',25,'开发人员',13800,'2017-11-30'),
('叶怡财','男',35,'开发人员',25000,'2020-03-15'),
('冯雅筑','男',35,'开发人员',24700,'2021-03-18'),
('李伦圣','男',25,'顾问',23000,'2019-05-16'),
('彭正','女',23,'顾问',26100,'2020-04-05'),
('刘小','女',25,'开发人员',20900,'2019-07-07'),
('温燕','男',31,'开发人员',27500,'2015-04-04'),
('刘佳','女',23,'业务经理',29000,'2018-12-07'),
('吴婷','女',25,'业务经理',16600,'2018-01-30'),
('杨怡君','男',33,'顾问',15200,'2015-09-23'),
('黄康','女',33,'开发人员',24800,'2021-11-30'),
('林辰','男',31,'业务经理',21000,'2020-05-01'),
('陈世人','男',23,'业务经理',28200,'2019-12-05'),
('吴佩','男',34,'业务经理',13200,'2021-02-19'),
('张伟','男',29,'顾问',15800,'2017-01-07'),
('刘友淳','女',31,'业务经理',13600,'2019-03-19'),
('张瑞','女',32,'开发人员',17500,'2018-02-04'),
('洪紫芬','女',23,'业务经理',29700,'2022-02-26'),
('邓家伟','女',22,'顾问',24100,'2019-12-30'),
('谢佩任','女',29,'顾问',13300,'2020-12-24'),
('戎郁文','男',35,'开发人员',15900,'2019-08-05'),
('李治火','男',30,'业务经理',23000,'2016-06-22'),
('林石','女',31,'业务经理',27400,'2016-08-18'),
('郑雅','女',24,'开发人员',18600,'2016-08-22'),
('胡台','男',33,'顾问',24800,'2017-09-22'),
('陈怡盈','男',24,'业务经理',28400,'2021-09-19'),
('阙石','女',26,'业务经理',26100,'2021-10-06'),
('林盈','女',22,'顾问',22000,'2016-07-07'),
('林志嘉','男',29,'开发人员',25000,'2014-03-28'),
('李秀','男',28,'顾问',19500,'2015-07-27'),
('王彦','男',28,'顾问',20900,'2019-01-26'),
('叶惟','女',34,'开发人员',23800,'2018-11-13'),
('郑星钰','女',33,'业务经理',27100,'2018-03-13'),
('邱贞','男',27,'顾问',22100,'2018-05-19'),
('姚扬云','男',35,'顾问',12000,'2017-07-06'),
('涂武盛','女',25,'开发人员',13700,'2016-09-14'),
('王雅','女',31,'业务经理',13700,'2018-11-17'),
('唐欣','女',28,'开发人员',20900,'2014-08-16'),
('陈政','男',25,'开发人员',24200,'2015-09-21'),
('陈育','女',33,'开发人员',26400,'2022-02-21'),
('吴惠雯','女',32,'顾问',25000,'2019-01-25'),
('李淑','女',35,'顾问',23300,'2020-06-23'),
('黄莉','男',33,'顾问',17800,'2016-09-15'),
('赖俊军','男',31,'开发人员',16400,'2018-04-24'),
('荆彦','女',22,'顾问',21300,'2021-10-06'),
('白怡均','男',32,'开发人员',14100,'2021-10-06'),
('林姿','男',28,'业务经理',23300,'2016-12-01'),
('林雅慧','男',35,'顾问',26100,'2020-06-12'),
('詹允坚','男',26,'开发人员',24400,'2017-07-16'),
('赖淑珍','女',27,'业务经理',24600,'2021-03-08'),
('吴惠','女',23,'顾问',24400,'2016-12-14'),
('李凯婷','男',30,'业务经理',22700,'2017-01-14'),
('林承','女',28,'顾问',13800,'2017-02-24'),
('刘亭宝','男',26,'业务经理',22500,'2015-10-28'),
('宋慧元','女',25,'业务经理',26600,'2020-10-11'),
('连书','女',25,'开发人员',13800,'2014-08-25'),
('余仪礼','女',22,'开发人员',27600,'2016-03-08'),
('袁哲仪','女',25,'开发人员',26100,'2020-06-22'),
('杜怡臻','女',31,'开发人员',21200,'2018-07-07'),
('潘孝','男',33,'业务经理',17000,'2017-07-22'),
('周志合','女',27,'业务经理',17800,'2021-06-25'),
('刘力','女',33,'业务经理',27500,'2021-07-23'),
('林钰','女',25,'开发人员',27100,'2020-03-09'),
('林怡','男',29,'开发人员',25100,'2020-10-29'),
('林俊','女',24,'顾问',16600,'2015-01-25'),
('蔡于','女',34,'业务经理',18900,'2021-08-20'),
('蔡雅惠','男',33,'顾问',29400,'2021-06-16'),
('汪喜','女',22,'业务经理',13300,'2020-12-26'),
('陈铭','女',31,'开发人员',22400,'2016-02-22'),
('郭子','男',29,'业务经理',29200,'2020-04-30'),
('许伦吉','男',35,'业务经理',24500,'2017-09-12'),
('陈佳','男',34,'顾问',25300,'2020-01-13'),
('赖英贤','女',34,'业务经理',29300,'2018-10-17'),
('吴嘉茹','男',35,'顾问',19100,'2018-10-29'),
('陈永桂','女',31,'顾问',13200,'2021-03-27'),
('张文','女',35,'业务经理',13700,'2014-05-03'),
('唐欣','男',32,'顾问',15000,'2016-02-26'),
('丁绍','男',34,'业务经理',16600,'2014-04-08'),
('王雅','男',34,'开发人员',26500,'2015-06-05'),
('叶柏','女',22,'业务经理',13500,'2018-01-30'),
('王婉萍','女',29,'顾问',24600,'2017-11-27'),
('王宗','男',25,'开发人员',13100,'2015-12-30'),
('刘心霖','女',34,'顾问',28600,'2015-04-13'),
('吴柏','男',25,'业务经理',27900,'2017-01-12'),
('陈怡臻','男',27,'顾问',29400,'2019-07-06'),
('杜士豪','男',30,'顾问',20700,'2016-02-10'),
('李春勋','男',32,'顾问',14400,'2019-11-29'),
('黄雅慧','女',28,'开发人员',19200,'2014-05-30'),
('吴乔茂','男',32,'开发人员',14800,'2022-03-05'),
('郑婉','女',34,'开发人员',23200,'2020-06-19'),
('李育','男',35,'业务经理',20700,'2017-08-21'),
('黄静','男',35,'开发人员',19700,'2016-10-29'),
('赵一蓉','男',32,'业务经理',19500,'2019-02-02'),
('邱萱','男',32,'开发人员',17300,'2019-12-09'),
('周立','男',32,'开发人员',21100,'2021-02-09'),
('李宝','男',28,'顾问',15200,'2015-03-07'),
('张信豪','女',35,'顾问',20900,'2019-11-30'),
('李昆霖','女',28,'顾问',15200,'2016-01-01'),
('陈俊安','男',22,'顾问',14200,'2020-06-12'),
('林建','男',25,'业务经理',18000,'2016-07-08'),
('黄韦','男',33,'开发人员',19400,'2016-12-03'),
('李美','男',34,'顾问',13400,'2021-11-22'),
('张政','男',31,'顾问',21200,'2020-04-15'),
('郑惠玲','女',30,'顾问',18300,'2021-01-28'),
('柳忠','女',24,'顾问',24100,'2017-02-21'),
('黄美','女',28,'业务经理',18800,'2021-07-16'),
('许怡君','男',24,'业务经理',25200,'2021-06-15'),
('吴崇','男',31,'顾问',14900,'2017-01-27'),
('邱承','男',34,'开发人员',21800,'2018-08-22'),
('叶得梅','女',31,'开发人员',12400,'2021-07-20'),
('陈祯月','女',29,'顾问',18300,'2021-04-27'),
('杨宛','女',27,'顾问',24500,'2018-01-31'),
('阮肇宪','男',28,'开发人员',22000,'2016-11-12'),
('杨益','女',26,'业务经理',26200,'2021-01-16'),
('唐盛人','女',22,'开发人员',26200,'2014-07-23'),
('许平纬','男',25,'业务经理',26100,'2017-08-30'),
('许雅如','男',33,'业务经理',20400,'2017-11-27'),
('林秀绮','女',32,'顾问',21600,'2019-09-12'),
('刘昌','女',30,'顾问',20800,'2019-09-22'),
('张家荣','女',23,'业务经理',16300,'2020-01-02'),
('杨淑','女',23,'开发人员',22900,'2019-07-25'),
('吴俊','女',28,'业务经理',22100,'2015-06-07'),
('李彦','男',34,'顾问',24500,'2015-05-08'),
('李彦','女',34,'业务经理',20900,'2018-12-03'),
('王崇','女',22,'业务经理',26800,'2015-02-23'),
('王威全','女',33,'顾问',29000,'2022-02-22'),
('彭琳','男',22,'顾问',23100,'2019-09-25'),
('许志','女',29,'业务经理',17600,'2018-01-18'),
('陈嘉','女',23,'顾问',12400,'2022-05-10'),
('蔡志','男',33,'顾问',16800,'2020-01-13'),
('陈信','女',22,'开发人员',19500,'2014-11-16'),
('陈思','男',32,'业务经理',21100,'2017-01-05'),
('吴家','男',30,'开发人员',12500,'2018-11-16'),
('李宜','男',34,'顾问',12200,'2021-07-29'),
('杨毅民','女',24,'业务经理',25000,'2022-02-07'),
('林志平','女',26,'顾问',25700,'2014-06-21'),
('张坚','男',33,'顾问',16100,'2015-04-11'),
('林明春','女',29,'业务经理',25300,'2015-04-14'),
('戴火','男',29,'业务经理',22400,'2018-12-31'),
('傅予名','男',33,'开发人员',24100,'2020-09-28'),
('叶佩璇','女',33,'开发人员',25800,'2019-10-12'),
('陈雅雯','女',35,'开发人员',20400,'2020-06-29'),
('萧宗毅','女',28,'业务经理',21500,'2014-07-24'),
('郭淑','男',26,'顾问',18900,'2017-03-01'),
('刘淑卿','女',31,'顾问',16300,'2019-03-09'),
('陈雅萍','女',27,'开发人员',24600,'2019-07-15'),
('陈佩','男',32,'顾问',28100,'2019-06-02'),
('冯惠玲','女',28,'业务经理',12100,'2016-05-09'),
('吴乃亚','男',22,'业务经理',27900,'2017-06-09'),
('刘欣','男',22,'顾问',26500,'2019-10-25'),
('陈意婷','男',22,'开发人员',18900,'2018-04-15'),
('林明珠','男',29,'顾问',24900,'2016-05-31'),
('陈淑婷','男',32,'开发人员',17600,'2016-11-01'),
('徐宏','男',31,'顾问',20500,'2019-02-22'),
('李佳德','女',35,'顾问',29100,'2015-12-03'),
('蔡正信','女',28,'业务经理',12700,'2020-05-24'),
('李淑敏','男',25,'顾问',18800,'2015-03-28'),
('蒋佳','男',34,'开发人员',25400,'2019-10-20'),
('蔡佳','女',35,'顾问',15400,'2015-09-04'),
('简淑','男',32,'顾问',27300,'2020-09-07'),
('张雅菱','女',34,'开发人员',17600,'2021-08-29'),
('颜淳奇','男',25,'业务经理',23200,'2018-04-28'),
('刘芳','女',34,'顾问',22700,'2016-11-27'),
('陈俊','女',27,'开发人员',14200,'2016-07-13'),
('黄雯','女',29,'业务经理',15100,'2017-05-28'),
('侯文贤','男',24,'开发人员',18300,'2015-02-19'),
('郑雅雯','男',26,'业务经理',22300,'2016-07-21'),
('黄雅','女',35,'顾问',13800,'2016-03-03'),
('陈婉','女',25,'开发人员',22500,'2015-06-25'),
('郑智杰','男',27,'业务经理',12800,'2014-11-03'),
('林玉信','女',33,'开发人员',20800,'2018-02-11'),
('阮侑','男',26,'业务经理',15300,'2020-08-11'),
('潘怡','男',30,'开发人员',12800,'2022-02-05'),
('黄世祥','男',25,'业务经理',21400,'2014-03-22'),
('张韦','男',33,'顾问',19300,'2018-08-24'),
('黄彦慈','女',31,'顾问',21000,'2020-07-24'),
('张峻','女',30,'开发人员',20400,'2015-01-16'),
('宋轩','女',25,'业务经理',15500,'2016-04-27'),
('周妤军','女',24,'开发人员',19100,'2020-07-16'),
('江佩','女',26,'顾问',28900,'2014-12-11'),
('陈美芝','男',31,'业务经理',23500,'2020-01-01'),
('张伦启','男',24,'开发人员',19500,'2014-03-02'),
('陈敏爱','男',26,'顾问',12600,'2016-09-25'),
('杨毓','女',33,'顾问',21800,'2015-07-18'),
('谢姿君','男',26,'开发人员',20900,'2014-08-30'),
('赖姿泰','男',31,'顾问',16400,'2020-07-13'),
('黄圣','男',25,'开发人员',28100,'2018-03-05'),
('林柏','男',26,'顾问',16600,'2020-05-02'),
('黄馨','男',30,'业务经理',23600,'2021-04-27'),
('叶于','男',22,'开发人员',16200,'2020-04-14'),
('陈山茹','女',30,'顾问',20300,'2020-01-18'),
('魏得凤','男',35,'业务经理',13700,'2018-01-22'),
('张明','男',31,'顾问',12000,'2014-07-10'),
('林冠强','女',27,'顾问',29300,'2018-09-12'),
('李文荣','男',22,'开发人员',13300,'2019-11-18'),
('龚静','男',23,'开发人员',24600,'2018-09-02'),
('陈伟孝','男',27,'开发人员',17000,'2017-12-15'),
('刘信俊','女',34,'业务经理',22000,'2021-04-30'),
('李美治','女',34,'业务经理',27300,'2014-05-22'),
('徐景','男',30,'开发人员',20400,'2021-03-15'),
('刘怡','男',32,'开发人员',20000,'2020-04-15'),
('陈钰','女',35,'顾问',29200,'2014-05-22'),
('谢静','男',28,'顾问',25300,'2016-12-29'),
('戴惠','男',30,'业务经理',17900,'2017-04-13'),
('王香君','男',22,'开发人员',20400,'2018-05-03'),
('钟汉馨','男',30,'顾问',24700,'2021-07-01'),
('郑国','男',25,'业务经理',27800,'2018-10-02'),
('张哲','男',23,'顾问',12600,'2017-03-20'),
('詹南','男',31,'开发人员',20300,'2021-04-10'),
('潘秋福','男',30,'业务经理',26600,'2017-08-23'),
('黄奕','女',32,'顾问',28400,'2014-12-13'),
('郭琬','男',32,'顾问',27000,'2019-01-23'),
('冯家','男',22,'顾问',24900,'2015-05-30'),
('吴佩仁','男',28,'开发人员',13400,'2017-10-17'),
('周思','男',35,'业务经理',22200,'2017-03-05'),
('张柏钧','男',30,'业务经理',23000,'2018-01-26'),
('吴世伟','男',25,'顾问',20900,'2014-10-27'),
('朱佳琪','女',35,'顾问',12900,'2020-06-15'),
('陈宗馨','男',27,'开发人员',19700,'2019-03-14'),
('黄菁坚','男',30,'开发人员',21300,'2019-10-28'),
('郑建泉','男',33,'开发人员',22600,'2015-05-07'),
('许金','女',33,'开发人员',18300,'2018-01-25'),
('平信宏','女',24,'业务经理',19700,'2014-08-28'),
('蔡佳','男',35,'业务经理',27400,'2017-04-01'),
('杨佳宏','男',33,'顾问',12700,'2014-06-15'),
('陈皓雅','女',30,'业务经理',16200,'2018-03-13'),
('吴翊','男',28,'顾问',13200,'2017-12-26'),
('张佩','男',24,'开发人员',20800,'2020-05-27'),
('温欣','女',29,'顾问',14700,'2016-08-22'),
('王诗铭','女',35,'业务经理',14900,'2015-01-16'),
('许宜','男',32,'开发人员',23200,'2018-06-27'),
('林孟','女',34,'开发人员',14800,'2019-11-08'),
('黄善','女',31,'开发人员',20300,'2019-09-09'),
('王怡贵','男',24,'开发人员',27100,'2021-12-08'),
('许淑玫','男',31,'开发人员',19200,'2021-03-17'),
('张学玉','女',26,'业务经理',21600,'2020-03-14'),
('黄美','女',33,'业务经理',20400,'2021-04-29'),
('陈佳','男',26,'开发人员',27700,'2015-06-26'),
('宋其琪','女',22,'业务经理',27200,'2022-05-01'),
('陈致','女',30,'业务经理',20100,'2021-04-19'),
('王建福','女',26,'业务经理',15100,'2017-01-23'),
('刘莹睿','女',30,'开发人员',21000,'2016-07-20'),
('陈正','男',23,'开发人员',21500,'2021-12-09'),
('冯萱雨','男',31,'开发人员',14000,'2019-06-26'),
('金淑敏','女',23,'顾问',22500,'2014-05-16'),
('宋廷','男',22,'开发人员',20600,'2014-08-14'),
('吴承','男',30,'开发人员',28100,'2021-03-29'),
('陈家莲','女',30,'业务经理',23800,'2021-04-07');
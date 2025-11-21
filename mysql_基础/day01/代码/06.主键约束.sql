DROP TABLE product;

CREATE TABLE product(
   pid INT PRIMARY KEY,#主键约束
   pname VARCHAR(10),
   pdesc VARCHAR(10)
   
);

INSERT INTO product (pid,pname,pdesc) VALUES (1,'苹果手机','富士康的');
-- INSERT INTO product (pid,pname,pdesc) VALUES (1,'香蕉','非洲');
-- INSERT INTO product (pid,pname,pdesc) VALUES (null,'香蕉','非洲');

CREATE TABLE product(
   pid INT,
   pname VARCHAR(10),
   pdesc VARCHAR(10),
   PRIMARY KEY (pid)   
);

/*
  通过修改表结构的方式
  ALTER TABLE 表名 ADD [CONSTRAINT 名称] PRIMARY KEY (字段列表)
*/

CREATE TABLE product(
   pid INT,
   pname VARCHAR(10),
   pdesc VARCHAR(10)
);
ALTER TABLE product ADD PRIMARY KEY (pid);

/*
  联合主键
*/
CREATE TABLE student(
  xing VARCHAR(10),
  ming VARCHAR(10),
  city VARCHAR(10),
  PRIMARY KEY (xing,ming)
);


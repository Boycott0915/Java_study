CREATE TABLE category(
   cid INT PRIMARY KEY,# primary key为主键约束,此列不能重复
   cname VARCHAR(10),
   cdesc VARCHAR(10)
);

/*
 insert into 表名 (列名,列名) values (值1,值2)
*/
INSERT INTO category (cid,cname,cdesc) VALUES (1,'服装','纸的');

/*
 insert into 表名 (列名,列名) values (值1,值2),(值1,值2),(值1,值2)... -> 一把添加多个数据
*/
INSERT INTO category (cid,cname,cdesc) VALUES (2,'箱包','钛合金'),(3,'蔬菜','纯添加'),(4,'方便面','过期的');

/*
insert into 表名 values (值1,值2)
*/
INSERT INTO category VALUES (5,'水果','水多的');

CREATE TABLE person(
  pid INT PRIMARY KEY AUTO_INCREMENT,#主键自增长,主键列的序号会自动编号
  pname VARCHAR(10),
  psex VARCHAR(5)
);

INSERT INTO person (pid,pname,psex) VALUES (1,'元始天尊','男');

# 由于pid是主键自增长列,所以添加数据的时候不需要单独维护
INSERT INTO person (pname,psex) VALUES ('灵宝天尊','男');

# 如果添加数据的时候不指定列名,即使有逐渐自增长,填写的值也必须覆盖所有列
INSERT INTO person VALUES (NULL,'道德天尊','男');

INSERT INTO person VALUES (NULL,"玉皇大帝","男");

INSERT INTO person VALUES (NULL,"涛哥","男");
INSERT INTO person VALUES (NULL,"三上","女");


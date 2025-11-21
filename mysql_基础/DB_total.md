# day01_数据库基础

# 第一章.数据库介绍

## 1.数据库介绍

```java
1.概述:存储数据的仓库
2.作用:永久存储数据
3.问题:javase中数组和集合都是存储数据的容器,但是都是临时存储,所以我们要想将数据永久保存,我们可以使用IO流技术将数据保存到硬盘上,那么为啥还要学数据库呢?
      数据库的数据都是在表中存储,我们有数据库独特的sql语句可以快速定位到指定的位置,直接进行修改
      而且数据量大的话,我们也可以通过数据库相关技术,提交我们的操作速度(增删改查) 查询最重要
```

> 常见的关系型数据库:(存储数据的时候都在表格里面，在表格里找数据)
>
> mysql    oracle

## 2.数据库管理系统

```java
1.注意:我们操作数据库,不是我们程序员直接去操作,中间会有一个数据库管理系统
2.数据库管理系统:在安装数据库的时候就自动安装好了,作用是:维护数据库数据的安全性,可靠性,统一性 
```

<img src="D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/1739324291517.png" alt="1739324291517" style="zoom:80%;" />

## 3.数据库表

```java
1.注意:真正存数据的地方是数据库中的表(table)
```

## 4.数据库表和Java类的对应关系

```java
数据库表和javabean类联系在一起的
```

<img src="D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/1732325534049.png" alt="1732325534049" style="zoom:80%;" />

```java
  1.表名  ->  类名
  2.列名  ->  属性名
  3.单元格中的值 -> 属性值
  4.每一行数据  -> 对象

  第一行:  User user = new User(1,"tom","111")
  第二行:  User user = new User(2,"jack","222")
  第三行:  User user = new User(3,"rose","333")
```

### 4.1.javabean在开发中如何跟表联系起来的->添加数据

```
javabean将页面上的输入的数据封装成对象了,然后传递给dao层
```

<img src="D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/1726883880914.png" alt="1726883880914" style="zoom:80%;" />

### 4.2.javabean在开发中如何跟表联系起来的->查询数据

```java
将从数据库中查询出来的数据,都封装成一个一个的javabean对象,将多个javabean对象一起返回给页面展示
```

<img src="D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/1726885706658.png" alt="1726885706658" style="zoom:80%;" />

# 第二章.mysql8安装

## 1.MySQL数据库安装

![](D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/2.png)

![](D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/3.png)

![](D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/4.png)

![](D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/5.png)



![](D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/6.png)

![](D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/7.png)



![](D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/8.png)

![](D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/9.png)



![](D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/10.png)

![](D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/11.png)

![](D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/12.png)

![](D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/13.png)



## 2.数据库服务启动和停止

```java
MySQL软件的服务器端必须先启动，客户端才可以连接和使用使用数据库。
```

### 2.1.方式1:图形化方式

```java
* 计算机（点击鼠标右键）==》管理（点击）==》服务和应用程序（点击）==》服务（点击）==》MySQL57（点击鼠标右键）==》启动或停止（点击）
* 控制面板（点击）==》系统和安全（点击）==》管理工具（点击）==》服务（点击）==》MySQL57（点击鼠标右键）==》启动或停止（点击）
* 任务栏（点击鼠标右键）==》启动任务管理器（点击）==》服务（点击）==》MySQL57（点击鼠标右键）==》启动或停止（点击）
```

### 2.2.方式2:命令方式

```java
启动 MySQL 服务命令：
net start MySQL80

停止 MySQL 服务命令：
net stop MySQL80
```

## 3.配置数据库环境变量

### 3.1.方式1:使用MYSQL_HOME

| 环境变量名 | 操作 |              环境变量值              |
| :--------: | :--: | :----------------------------------: |
| MYSQL_HOME | 新建 | D:\ProgramFiles\mysql\MySQLServer5.7 |
|    path    | 编辑 |           %MYSQL_HOME%\bin           |

### 3.2.方式2:直接配置mysql的bin路径

| 环境变量名 | 操作 |                环境变量值                |
| :--------: | :--: | :--------------------------------------: |
|    path    | 编辑 | D:\ProgramFiles\mysql\MySQLServer5.7\bin |

## 4.数据库服务端安装之后登陆

```java
1.win+R-->调出黑窗口
2.登录命令:
  a.mysql -u用户名 -p密码->回车   -> 缺点,在登录的时候密码显示出来了
  b.mysql -u 用户名 -p   ->回车
    输入密码(密码将显示成小星星)
```

```mysql
问题:输入mysql命令出现"不是内部或外部命令"
原因:环境变量没配置
解决:将mysql安装路径下的bin目录复制到环境变量下的path中
    如果path下有,还出现了"不是内部或者外部命令",干掉重新配置一下
```

```java
问题:ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: YES)
原因:输入的mysql用户名或者密码有问题
```

```java
问题:ERROR 2003 (HY000): Can't connect to MySQL server on 'localhost' (10061)
原因:mysql服务没有启动
```

## 5.黑窗口乱码问题(可以忽略)

```java
1.在黑窗口中默认编码为GBK,而我们mysql为UTF-8,所以在黑窗口中操作中文就会乱码
2.解决:
  a.在黑窗口中输入:set names gbk   ->临时将mysql编码修改成gbk
  b.在mysql安装路径下修改my.ini文件，将涉及到编码的地方都修改了,重启服务所有地方生效。
```

```java
在路径：D:\ProgramFiles\mysql\MySQLServer8\Data 找到my.ini文件

修改内容1：
	找到[mysql]命令，大概在63行左右，在其下一行添加 
		default-character-set=utf8
修改内容2:
	找到[mysqld]命令，大概在76行左右，在其下一行添加
		character-set-server=utf8
		collation-server=utf8_general_ci

修改完毕后，重启MySQL57服务
```

```java
show variables like 'character_%';
show variables like 'collation_%';
```

![image-20210913231100322](D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/image-20210913231100322.png)



## 6.mysql客户端(可视化工具)安装

```java
例如：Navicat Preminum，SQLyog 等工具
```

### 6.1.SQLyog

![image-20210913231743884](D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/image-20210913231743884.png)

<img src="D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/image-20220402094150194.png" alt="image-20220402094150194" style="zoom:80%;" />

```java
通过黑窗口先登录数据库
处理无法连接：ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '你的密码';
```

<img src="D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/1684723765667.png" alt="1684723765667" style="zoom:80%;" />

### 6.2.Navicat

![image-20210913231808531](D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/image-20210913231808531.png)

# 第三章.sql语言

## 1.sql语言介绍

```java
1.什么叫做sql语言:是所有关系型数据库语法的一个标准,规范
2.作用:规范了关系型数据库的语法以及一写关键字的使用: create drop insert select update等
3.注意:不同的关系型数据库在都遵守sql语言规范的基础上,会有一些差异,这些差异叫做sql方言
```

## 2.sql语言分类

```java
- 数据定义语言：简称DDL(Data Definition Language)，用来定义数据库对象：数据库，表，列等。关键字：create，alter，drop等

- 数据操作语言：简称DML(Data Manipulation Language)，用来对数据库中表的记录进行操作。关键字：insert，delete，update等

- 数据控制语言：简称DCL(Data Control Language)，用来定义数据库的访问权限和安全级别，及创建用户。

- 数据查询语言：简称DQL(Data Query Language)，用来查询数据库中表的记录。关键字：select，from，where等
```

## 3.sql语句的通用语法

```sql
1.- SQL语句可以单行或多行书写，以分号结尾
2.- 可使用空格和缩进来增强语句的可读性:基本上一个单词就一个空格
3.- MySQL数据库的SQL语句不区分大小写，关键字建议使用大写
    
  - 例如：SELECT * FROM user。
4.- 同样可以使用/**/的方式完成注释  #
    /*
     我是一个注释
    */
    #我也是一个注释
   -- 我也是一个注释
```

## 4.sql中的数据类型

| **类型名称**          | 说明                                                         |
| --------------------- | ------------------------------------------------------------ |
| int                   | 整数类型                                                     |
| double                | 小数类型                                                     |
| decimal（m,d）        | 指定整数位与小数位长度的小数类型                             |
| date                  | 日期类型，格式为yyyy-MM-dd，包含年月日，不包含时分秒  2020-01-01 |
| datetime              | 日期类型，格式为 YYYY-MM-DD HH:mm:ss，包含年月日时分秒   到9999年 |
| timestamp             | 日期类型，时间戳  从1970年到2038年                           |
| varchar（字符串长度） | 文本类型， M为0~65535之间的整数                              |

### 举个例子：

```mysql
DECIMAL(5,2)
```

- 总共最多可以存储 **5 位数字**。
- 其中 **2 位是小数**，那么整数部分最多可以有 **3 位**。
- 可以存储的范围是：`-999.99` 到 `999.99`。

例如：

- ✅ `123.45` —— 合法（整数3位 + 小数2位）
- ❌ `1234.56` —— 不合法（整数部分4位，超过了总位数5）

```java
我们先学  mysql
```

# 第四章.mysql中语句

## 1.DDL之数据库操作：database

### 1.1 创建数据库

```mysql
1.关键字: create database
2.语法:
  create database `数据库名字`
```

```mysql
CREATE DATABASE `241229_database`;
```

> 涛哥建议:
>
> 只要是写库名,表名,列名的时候,建议用``包裹

<img src="D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/1739328800288.png" alt="1739328800288" style="zoom:80%;" />



<img src="D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/1739328909519.png" alt="1739328909519" style="zoom:80%;" />

### 1.2 查看数据库(了解)

```mysql
1.查看库:
  show databases;
```

```sql
-- 查看所有库
SHOW DATABASES;
```

### 1.3 删除数据库

```mysql
1.关键字: drop database
2.语法: drop database `库名`
```

```mysql
-- 删库
DROP DATABASE `241229_database2`;
```

<img src="D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/1739329086729.png" alt="1739329086729" style="zoom:80%;" />

### 1.4 使用数据库(切换数据库)

```mysql
1.语法: use 库名
```

```mysql
USE `241229_database`;
```

## 2.DDL之表操作->table

### 2.1 创建表

```mysql
1.关键字: create table
2.语法:
  create table `表名`(
    `字段名` 数据类型(长度)[约束],
    `字段名` 数据类型(长度)[约束],
    `字段名` 数据类型(长度)[约束]  
  )
  
3.注意:
  字段和字段之间用,隔开,如果我们写完最后一个字段,就不用加,了
```

```mysql
#创建表
CREATE TABLE `user`(
   `uid` INT,
   `username` VARCHAR(10),
   `password` VARCHAR(15)
);
```

<img src="D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/1739330691784.png" alt="1739330691784" style="zoom:80%;" />

### 2.3 查看表(了解)

```mysql
#查看所有表
show tables;

#查看表结构
desc 表名;
```

```mysql
#查看所有表
SHOW TABLES;

-- 查看表结构
DESC person;
```

### 2.4 删除表

```mysql
1.关键字: drop table
2.语法:drop table 表名
```

```mysql
-- 删除表
DROP TABLE `person`;
```

<img src="D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/1739330900550.png" alt="1739330900550" style="zoom:80%;" />

### 2.5修改表结构(了解) alter table操作

```java
alter table 表名 add 列名 类型(长度) [约束];
作用：添加列. 
```

```mysql
ALTER TABLE `user` ADD `gender` VARCHAR(2);
```

```mysql
alter table 表名 modify 列名 类型(长度) [约束];
  作用：修改列的类型,长度及约束.
```

```mysql
ALTER TABLE `user` MODIFY `gender` INT;
```

```mysql
  alter table 表名 change 旧列名 新列名 类型(长度) [约束]; 
  作用：修改列名.
```

```mysql
ALTER TABLE `user` CHANGE `gender` `sex` VARCHAR(10);
```

```mysql
  alter table 表名 drop 列名; 
  作用：修改表_删除列.
```

```mysql
ALTER TABLE `user` DROP `sex`;
```

```mysql
 rename table 表名 to 新表名; 
 作用：修改表名
```

```mysql
RENAME TABLE `user` TO `person`;
RENAME TABLE `person` TO `user`;
```

## 3.DML之数据操作语言

### 3.1 插入数据

```mysql
1.关键字: insert into values
2.语法:
  a.insert into 表名 (列名,列名) values (值1,值2)
  b.insert into 表名 (列名,列名) values (值1,值2),(值1,值2),(值1,值2)... -> 一把添加多个数据
  c.insert into 表名 values (值1,值2) -> 所写的值必须覆盖所有列，不能少写
3.注意:
  如果某列是varchar类型的,那么在添加数据的时候,数据要求用'',不要用双引号
  String sql = "INSERT INTO person VALUES (NULL,'玉皇大帝','男')";、
  原因是将来我们的sql语句会放到java代码中参与运行,那么sql语句在java代码中是用String表示的
  就会变成

  String sql = "INSERT INTO person VALUES (NULL,"玉皇大帝",'男')";
  "INSERT INTO person VALUES (NULL,"这样子匹配在一起
  
```

```mysql
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
```

> 细节:
>
> 列名,表名,库名用``
>
> varchar类型的值用''

### 3.2 删除数据

```mysql
1.关键字: delete from where
2.语法:
  delete from 表名 [where 条件]
```

| java | mysql      |
| ---- | ---------- |
| ==   | =          |
| >    | >          |
| <    | <          |
| >=   | >=         |
| <=   | <=         |
| !=   | != 或者 <> |

```sql
-- 删除cid为1的记录
-- 删除cid>=5的记录
-- 删除cid不等于3的记录
```

```sql
-- 直接将所有数据删除
DELETE FROM person;

-- 删除cid为1的记录
DELETE FROM category WHERE cid = 1;

-- 删除cid>=5的记录
DELETE FROM category WHERE cid >= 5;

-- 删除cid不等于3的记录

DELETE FROM category WHERE cid != 3;

DELETE FROM category WHERE cid <> 3;

DELETE FROM category WHERE  NOT (cid=3);
```

### 3.3 修改数据

```mysql
1.关键字: update set where
2.语法:
  update 表名 set 列名 = 新值 -> 将指定列中所有的数据都改成同一个新值
  update 表名 set 列名 = 新值 [where条件] -> 根据条件修改数据
```

```mysql
-- 将表中的显卡改成水杯

-- 将cid为4的cdesc改成涤纶



-- 将cid不等于1的cname都改成平板

```

```sql
UPDATE category SET cname = '手机';

-- 将表中的水杯改成显卡
UPDATE category SET cname = '显卡' WHERE cname = '水杯';

-- 将cid为4的cdesc改成涤纶
UPDATE category SET cdesc = '涤纶' WHERE cid = 4;

-- 将cid不等于1的cname都改成平板
UPDATE category SET cname = '平板' WHERE cid !=1;
```

# 第五章.约束

```java
1.制约指定列中的数据
```

## 1.主键约束

```mysql
1.关键字: primary key
2.特点:
  a.主键列的数据不能重复
  b.主键列的数据不能为null
3.注意:
  每个表中都应该有一个主键列,代表一条数据,相当于人得身份证号
```

### 1.1.添加方式1:在创建表时,在字段后面直接指定(重点)

```mysql
create table 表名(
  列名 数据类型(长度)[约束],
  列名 数据类型(长度)[约束],
  列名 数据类型(长度)[约束]
)
```

```sql
CREATE TABLE product(
   pid INT PRIMARY KEY,#主键约束
   pname VARCHAR(10),
   pdesc VARCHAR(10)
);

INSERT INTO product (pid,pname,pdesc) VALUES (1,'苹果手机','富士康的');
-- INSERT INTO product (pid,pname,pdesc) VALUES (1,'香蕉','非洲');
-- INSERT INTO product (pid,pname,pdesc) VALUES (null,'香蕉','非洲');
```

### 1.2.添加方式2:在constraint约束区域,去指定主键约束

```mysql
1.什么叫做constraint域
  创建表的时候,最后一列和右半个小括号之间的区域
2.语法:
  [constraint 名字] primary key (字段名)
3.注意:[constraint 名字]:可写可不写    
```

```mysql
CREATE TABLE product(
   pid INT,
   pname VARCHAR(10),
   pdesc VARCHAR(10),
   PRIMARY KEY (pid)   
);
```

<img src="D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/1739348308682.png" alt="1739348308682" style="zoom:80%;" />

### 1.3.添加方式3:通过修改表结构的方式

```mysql
1.格式:ALTER TABLE 表名 ADD [CONSTRAINT 名称] PRIMARY KEY (字段列表)
2.注意:[CONSTRAINT 名称]可以省略不写
```

```mysql
CREATE TABLE product(
   pid INT,
   pname VARCHAR(10),
   pdesc VARCHAR(10)
);
ALTER TABLE product ADD PRIMARY KEY (pid);

```

### 1.4.联合主键

```mysql
1.概述:多个列共同称之为是一个主键
2.特点:
  联合主键中的多个列数据不能完全一样
  不能为null
```

```mysql
/*
  联合主键
*/
CREATE TABLE student(
  xing VARCHAR(10),
  ming VARCHAR(10),
  city VARCHAR(10),
  PRIMARY KEY (xing,ming)
);
```

<img src="D:/data/JAVA/Database/day01/资料/day01数据库笔记/img/1739349347997.png" alt="1739349347997" style="zoom:80%;" />

### 1.5.删除主键约束

```mysql
ALTER TABLE 表名 DROP PRIMARY KEY->删除主键约束
```

```mysql
ALTER TABLE person DROP PRIMARY KEY;
```

## 2.自增长约束

### 2.1.基本操作

```mysql
1.关键字:auto_increment
2.特点:
  a.自增长约束都是和主键约束一起使用
  b.主键自增长列中的数据mysql会自动维护
3.注意:
  如果是主键自增长列的数据,那么删除之后,再重新添加,序号会从被删除数据的序号后一个序号编号
```

``` mysql
DROP TABLE category;

CREATE TABLE category(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  cname VARCHAR(10),
  cdesc VARCHAR(10)
);

INSERT INTO category (cid,cname,cdesc) VALUES (NULL,'蔬菜','纯野生');

INSERT INTO category VALUES (NULL,'水果','偷的');

INSERT INTO category VALUES (NULL,'海鲜','核污染的');

DELETE FROM category WHERE cid = 3; #删除之后不会重新编号

#摧毁表结构
TRUNCATE TABLE category;
```

> ```mysql
> /*
> 自增长是一个约束,操作起来和其他约束不太一样
> 
> 如果自增长约束和主键约束合起来使用想删除
> 
> 先删除自增长约束
> 再删除主键约束
> 
> */
> 
> drop table category;//永久删除category数据表
> create table category(
> cid int primary key auto_increment,
> cname varchar(100)
> );
> 
> alter table category modify cid int;//只会消除自增长 但主键约束仍然存在（因为 MODIFY 不会自动删主键）
> alter table category drop primary key;
> ```

### 2.2.truncate和delete区别

```mysql
1.delete:如果是主键自增长,删除之后,再次添加,编号不会重新编号,会接着被删除的那个编号往下继续编
2.truncate:摧毁表结构,主键自增长列,会重新编号
```

## 3.非空约束

```mysql
1.关键字:NOT NULL
2.特点:
  此列不能为NULL
```

```mysql
DROP TABLE category;
#非空约束

CREATE TABLE category(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  cname VARCHAR(10) NOT NULL,
  cdesc VARCHAR(10)
);

INSERT INTO category (cid,cname,cdesc) VALUES (NULL,'蔬菜','纯野生');

#相当于String s = null
-- INSERT INTO category (cid,cname,cdesc) VALUES (NULL,NULL,'纯野生');

#相当于String s = "null"
INSERT INTO category (cid,cname,cdesc) VALUES (NULL,'null','纯野生');

#相当于String s = ""
INSERT INTO category (cid,cname,cdesc) VALUES (NULL,'','纯野生');
```

## 4.唯一约束

```mysql
1.关键字:UNIQUE
2.特点:
  唯一约束的列,数据不能重复
3.唯一约束和主键约束区别:
  a.一个表中只能有一个主键约束
  b.一个表中能有多个唯一约束
  c.主键约束可以代表一行数据,相当于人得身份证号
  d.唯一约束只能限制数据不重复,不能完全代表一行数据
```

```mysql
DROP TABLE category;
#非空约束

CREATE TABLE category(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  cname VARCHAR(10) UNIQUE,
  cdesc VARCHAR(10)
);

INSERT INTO category (cid,cname,cdesc) VALUES (NULL,'蔬菜','纯野生');

#INSERT INTO category (cid,cname,cdesc) VALUES (NULL,'蔬菜','扣大棚');

INSERT INTO category (cid,cname,cdesc) VALUES (NULL,'蔬菜1','扣大棚');
```

```mysql
删除唯一约束:
 ALTER TABLE 表名 DROP INDEX 名称   [名称是CONSTRAINT后面的名称]
```

# day02-查询

```java
课前回顾:
 1.创建库:create database `库名`
 2.删除库:drop database `库名`
 3.创建表:
   create table `表名`(
     列名 类型 (长度) [约束],
     列名 类型 (长度) [约束],
     列名 类型 (长度) [约束]  
   );
 4.删除表:drop table `表名`
 5.修改表结构: alter table
 6.添加数据:
   insert into `表名` (`列名`,`列名`) values (值1,值2);
   insert into `表名` (`列名`,`列名`) values (值1,值2),(值1,值2),(值1,值2);
   insert into `表名` values (值1,值2); -> 填写的值需要匹配所有列
 7.删除数据:
   delete from 表名 [where条件]
 8.修改数据:
   update 表名 set 列名 = 新值 [where条件]
 9.约束:
   a.主键约束: primary key  一张表都应该有一个主键列
   b.自增长: auto_increment -> 编号数据库自动管理
   c.非空约束: not null
   d.唯一约束: unique

今日重点:
  a.只要关于查询的都是重点
  b.必须分清表和表之间的关系 : 一对一   一对多   多对多    
```

# 第一章.单表查询

```sql
#创建商品表：
create table product(
	pid int primary key,
	pname varchar(20),
	price double
);


INSERT INTO product(pid,pname,price) VALUES(1,'联想',5000);
INSERT INTO product(pid,pname,price) VALUES(2,'海尔',3000);
INSERT INTO product(pid,pname,price) VALUES(3,'雷神',5000);
INSERT INTO product(pid,pname,price) VALUES(4,'JACK JONES',800);
INSERT INTO product(pid,pname,price) VALUES(5,'真维斯',200);
INSERT INTO product(pid,pname,price) VALUES(6,'花花公子',440);
INSERT INTO product(pid,pname,price) VALUES(7,'劲霸',2000);
INSERT INTO product(pid,pname,price) VALUES(8,'香奈儿',800);
INSERT INTO product(pid,pname,price) VALUES(9,'相宜本草',200);
INSERT INTO product(pid,pname,price) VALUES(10,'面霸',5);
INSERT INTO product(pid,pname,price) VALUES(11,'好想你枣',56);
INSERT INTO product(pid,pname,price) VALUES(12,'香飘飘奶茶',1);
INSERT INTO product(pid,pname,price) VALUES(13,'果9',1);
```

## 1.简单查询

```sql
1.关键字: select  from 
2.语法:
  a.select * from 表名  -> 查询所有数据,*代表的是展示所有列
  b.select 列名,列名 from 表名 -> 查询所有数据,展示指定的列
  
3.注意:
  查询出来的结果都是以表的形式展示,我们可以和这个查询出来的结果称之为"伪表",这个"伪表"是只读的,不能改里面的数据
```

```mysql
-- 查询product所有数据 1


-- 查询product 所有数据,展示pname和pid 1


/*
  去重复值
  
  关键字: distinct(列名) 
*/



/*
  给列中的数据做计算
*/
-- 查询所有数据,给price列中所有的数据+100 1



/*
  给列和表取别名
  
  as 别名 1
  
  as可以省略
*/


-- 也可以给表取别名,但是不涉及到多表查询,给表取别名看不出效果来

```

```sql
-- 查询product所有数据
SELECT * FROM product;
-- 查询product 所有数据,展示pname和pid
SELECT pid,pname FROM product;
/*
  去重复值
  
  关键字: distinct(列名)
*/
SELECT DISTINCT(price) FROM product;

/*
  给列中的数据做计算
*/
-- 查询所有数据,给price列中所有的数据+100
SELECT pid,pname,price+100 FROM product;

/*
  给列和表取别名
  
  as 别名
  
  as可以省略
*/
SELECT pid,pname,price+100 `price` FROM product;


-- 也可以给表取别名,但是不涉及到多表查询,给表取别名看不出效果来
SELECT * FROM product `p`;
```

## 2.条件查询

```sql
1.格式:
  select 列名 from 表名 where 条件
```

| **比较运算符** | > <  <=  >=   =  <>   | 大于、小于、大于(小于)等于、不等于                           |
| -------------- | --------------------- | ------------------------------------------------------------ |
|                | BETWEEN  ...AND...    | 显示在某一区间的值(含头含尾)                                 |
|                | 字段 IN(set)          | 显示在in列表中的值，例：price in(100,200)  查询id为1,3,7的商品: id  in(1,3,7) |
|                | 列名 LIKE ‘张pattern’ | 模糊查询，Like语句中，% 代表零个或多个任意字符，_ 代表一个字符， 例如：`first_name like '_a%';`   <br/>比如:查询姓张的人:name like '张%'<br> 查询商品名中带香的商品: pname like '%香%'<br>查询第二个字为想的商品: like '_想%'<br>查询商品名为四个字的商品:like '____' |
|                | IS NULL               | 判断是否为空    不为空的就是 IS NOT NULL                     |
| **逻辑运行符** | and  (与)             | 多个条件同时成立  全为true,整体才为true                      |
|                | or(或)                | 多个条件任一成立   有真则真                                  |
|                | not(非)               | 不成立，例：`where not(salary>100); `                        |

```mysql
-- 查询商品名为'花花公子'的商品所有信息
1

-- 查询价格为800的商品
1

-- 查询商品价格大于60元的所有商品信息
1

-- 查询商品价格在200-1000之间的所有商品信息
1


-- 查询商品价格是200或者800的商品
1

-- 查询以'香'开头的商品
1

-- 查询含有'霸'的商品
1

-- 查询商品名为NULL的
1

-- 查询商品名不为NULL的
1
```

```sql
-- 查询商品名为'花花公子'的商品所有信息
SELECT * FROM product WHERE pname = '花花公子';
-- 查询价格为800的商品
SELECT * FROM product WHERE price = 800;
-- 查询商品价格大于60元的所有商品信息
SELECT * FROM product WHERE price>60;
-- 查询商品价格在200-1000之间的所有商品信息
SELECT * FROM product WHERE price BETWEEN 200 AND 1000;

SELECT * FROM product WHERE price>=200 AND price<=1000;

-- 查询商品价格是200或者800的商品
SELECT * FROM product WHERE price = 200 OR price = 800;
SELECT * FROM product WHERE price IN (200,800);

-- 查询以'香'开头的商品
SELECT * FROM product WHERE pname LIKE '香%';

-- 查询含有'霸'的商品
SELECT * FROM product WHERE pname LIKE '%霸%';

-- 查询商品名为NULL的
SELECT * FROM product WHERE pname IS NULL;

-- 查询商品名不为NULL的
SELECT * FROM product WHERE pname IS NOT NULL;
```

## 3.排序查询

```sql
1.关键字: order by
2.语法:
  select 列名 from 表名 order by 排序列名 asc|desc
3.asc和desc解释:
  asc:升序(默认的)
  desc:降序
4.问题:
  先查询,还是先排序
  
  一定是先查询,最后排序
```

```mysql
书写sql语句关键字的顺序
select （列）
from 	（表）
where 	（范围）
group by （分组）
having 	（类似where）
order by	（排序）

执行顺序:
from 
where 
group by 
having 
select 
order by

先定位到要查询哪个表,然后根据什么条件去查,表确定好了,条件也确定好了,开始利用select查询
查询得出一个结果,在针对这个结果进行一个排序
```

```mysql
-- 使用价格排序(降序)
1

-- 使用价格排序(升序)
1

-- 显示商品的价格(去重复),并排序(降序)
1
```

```sql
-- 使用价格排序(降序)
SELECT * FROM product ORDER BY price DESC;


-- 使用价格排序(升序)
SELECT * FROM product ORDER BY price ASC;


-- 显示商品的价格(去重复),并排序(降序)
SELECT DISTINCT(price) FROM product ORDER BY price DESC;
```

## 4.聚合查询

```mysql
1.特点:纵向查询-> 操作指定列

2.需要聚合函数: 聚合函数查询结果是单值
  count(*) 统计总记录数
  sum(列名) 对指定列求和
  avg(列名) 对指定列求平均值
  max(列名) 对指定列求最大值
  min(列名) 对指定列求最小值
  
3.语法: 只要用函数,都放到select后面
  select 聚合函数(列名) from 表名 where 条件
```

```mysql
-- 统计product的总记录数
1

-- 查询所有商品的价格总和
1

-- 查询pid为1,3,7 商品的价格平均值
1


-- 查询商品的最高价格以及最低价格
1

#================================
CREATE TABLE person(
  pid INT,
  pname VARCHAR(10)
);

SELECT COUNT(*) FROM person;  # 不管有没有null,将所有数据都统计出来

SELECT COUNT(pid) FROM person; # 如果指定的列有NULL,不记录
```

```sql
-- 统计product的总记录数
SELECT COUNT(*) FROM product;


-- 查询所有商品的价格总和
SELECT SUM(price) FROM product;


-- 查询pid为1,3,7 商品的价格平均值
SELECT AVG(price) FROM product WHERE pid IN(1,3,7);


-- 查询商品的最高价格以及最低价格
SELECT MIN(price) `minprice`,MAX(price) `maxprice` FROM product;

#================================
CREATE TABLE person(
  pid INT,
  pname VARCHAR(10)
);

SELECT COUNT(*) FROM person;  # 不管有没有null,将所有数据都统计出来

SELECT COUNT(pid) FROM person; # 如果指定的列有NULL,不记录
```

## 5.分组查询

```mysql
1.关键字: group by
2.语法:
  select 聚合函数(列名) from 表名 group by 分组列 having 条件
3.注意: 分组查询都是和聚合函数一起使用
4.分析按照那一列分组: 
  相同的合并为一组
  不同的单独为一组
  
```

```mysql
书写sql语句关键字的顺序:偏向的是关键字
select 
from 
where 
group by 
having 
order by

执行顺序:偏向的是逻辑
from 
where 
group by 
having 
select 
order by

先定位到要查询哪个表,然后根据什么条件去查,表确定好了,条件也确定好了,开始利用select查询
查询得出一个结果,在针对这个结果进行一个排序
```

### **SQL 语句的书写顺序 ≠ 实际执行顺序**

------

#### ✅ 一、书写顺序（语法顺序）——给人看的

这是你写 SQL 时必须遵守的**语法规范**，顺序不能乱：

```sql
SELECT     -- ① 写在最前面（但不是最先执行！）
FROM       -- ②
WHERE      -- ③
GROUP BY   -- ④
HAVING     -- ⑤
ORDER BY   -- ⑥
```

> 💡 这个顺序是 SQL 语言规定的“写作模板”，方便程序员阅读和编写。

------

#### 🔁 二、实际执行顺序 —— 给数据库引擎用的

数据库在真正运行这条 SQL 时，**内部逻辑执行顺序完全不同**：

```text
1. FROM       → 确定从哪张表（或哪些表）查数据
2. WHERE      → 对原始数据进行行级过滤（条件筛选）
3. GROUP BY   → 将过滤后的数据按指定列分组
4. HAVING     → 对分组后的结果再进行过滤（只能用聚合函数或分组字段）
5. SELECT     → 选择要返回的列（此时才“投影”出最终字段，可使用别名）
6. ORDER BY   → 对最终结果集排序
```

> 🧠 这个顺序反映了**数据处理的逻辑流程**：先有数据源 → 筛选 → 分组 → 再筛选 → 选字段 → 排序

------

####  举个例子说明

假设我们有订单表 `orders`：

| order_id | customer | amount |
| -------- | -------- | ------ |
| 1        | Alice    | 100    |
| 2        | Bob      | 200    |
| 3        | Alice    | 150    |
| 4        | Charlie  | 80     |

我们要：**找出总消费超过 200 的客户，并按总金额降序排列**

```sql
SELECT customer, SUM(amount) AS total
FROM orders
WHERE amount > 50
GROUP BY customer
HAVING total > 200
ORDER BY total DESC;
```

#### 数据库实际怎么执行？

1. **FROM orders**
   → 加载整张 `orders` 表
2. **WHERE amount > 50**
   → 去掉第4行（Charlie 的 80 不满足？不，80>50，所以保留。这里只是为了演示）
3. **GROUP BY customer**
   → 分成三组：Alice、Bob、Charlie
4. **HAVING total > 200**
   → 计算每组 SUM(amount)：Alice=250, Bob=200, Charlie=80
   → 只保留 Alice（250 > 200）
5. **SELECT customer, SUM(amount) AS total**
   → 此时才生成 `customer` 和 `total` 这两列（注意：`total` 是这时才定义的别名！）
6. **ORDER BY total DESC**
   → 按 total 降序排（虽然只有一行，但逻辑如此）

------

#### 为什么这个区别很重要？

##### 1. **别名不能在 WHERE 或 GROUP BY 中使用**

```sql
-- ❌ 错误！WHERE 执行时，SELECT 还没运行，total 不存在
SELECT customer, SUM(amount) AS total
FROM orders
WHERE total > 200;  -- 报错！

-- ✅ 正确：用 HAVING（它在 SELECT 之后执行）
SELECT customer, SUM(amount) AS total
FROM orders
GROUP BY customer
HAVING total > 200;
```

##### 2. **理解性能优化**

- `WHERE` 在早期过滤，能大幅减少后续处理的数据量。
- `HAVING` 是对分组后结果过滤，代价更高。

------

#### 总结一句话：

> **你写的 SQL 是“声明式”的（告诉数据库要什么），但数据库内部是“过程式”执行的（一步步处理数据）。书写顺序是为了语法清晰，执行顺序才是真实逻辑流程。**

```sql
-- 查询相同商品的价格总和
0

-- 查询相同商品的价格总和并排序
1

-- 查询相同商品的价格总和,再展示出价格总和大于等于2000的商品

```

```sql
-- 查询相同商品的价格总和
SELECT pname,SUM(price) FROM product GROUP BY pname;

-- 查询相同商品的价格总和并排序
SELECT pname,SUM(price) FROM product GROUP BY pname ORDER BY price DESC;

/*
  以上sql语句不好使
  
  原因是:我们都是先查询,最后排序
  我们会先做一个分组查询,查询出一个伪表来
  然后针对伪表进行排序
  但是伪表中价格列不叫price,叫做SUM(price)
  所以我们排序的时候要按照SUM(price)来排序
*/
SELECT pname,SUM(price) FROM product GROUP BY pname ORDER BY SUM(price) DESC;

SELECT pname,SUM(price) `newprice` FROM product GROUP BY pname ORDER BY `newprice` DESC;

-- 查询相同商品的价格总和,再展示出价格总和大于等于2000的商品
SELECT pname,SUM(price) `newprice` FROM product GROUP BY pname WHERE `newprice` >= 2000;

/*
  以上sql有问题
  因为where要在group by关键字之前
*/
SELECT pname,SUM(price) `newprice` FROM product WHERE `newprice` >= 2000 GROUP BY pname;

/*
  从执行顺序上来看,先走where再走select语句
  在执行where的时候newprice这个别名产生了嘛?-> 没有产生
*/

SELECT pname,SUM(price) `newprice` FROM product WHERE `price` >= 2000 GROUP BY pname;

/*
  以上sql有问题,分组查询之后果9是2000,但是结果没有果9
  原因:走where的时候还没有真正的分组查询呢
       没有分组查询之前,有两个果9(没合并)
       一个果9是1块钱;一个果9是1999
       所以先执行where的时候直接将两个果9排除了
       
  解决:我们应该找一个关键字,从书写顺序和执行顺序上都在分组查询之后去晒选条件
       关键字:having
            
*/
SELECT pname,SUM(price) `newprice` FROM product GROUP BY pname HAVING `newprice` >= 2000;

```

<img src="D:/data/JAVA/Database/day02/资料/day02笔记/img/1739501840822.png" alt="1739501840822" style="zoom:80%;" />

## 6.分页查询

```mysql
1.语法:
  select * from 表名 limit m,n
  
2.字母代表啥:
  m:每页的起始位置
  n:每页显示条数
3.小技巧:
  我们将整个表的每一条数据进行编号,从0开始
  
4.每页的起始位置快速算法:
  (当前页-1)*每页显示条数
  
  当前页 -> 第几页
  
5.其他分页参数:
  a.每页的起始位置:
    (当前页-1)*每页显示条数
  b.int curPage = 2; -- 当前页数
  c.int pageSize = 5; -- 每页显示数量
  d.int startRow = (curPage - 1) * pageSize; -- 当前页, 记录开始的位置(行数)计算
  
  e.int totalSize = select count(*) from products; -- 记录总数量
  f.int totalPage = Math.ceil(totalSize * 1.0 / pageSize); -- 总页数
                总页数 = (总记录数/每页显示条数)向上取整
```

```mysql
-- select * from 表名 limit m,n

-- 第一页
SELECT * FROM product LIMIT 0,5;

-- 第二页
SELECT * FROM product LIMIT 5,5;

-- 第三页
SELECT * FROM product LIMIT 10,5;

-- 第四页
SELECT * FROM product LIMIT 15,5;

```

<img src="D:/data/JAVA/Database/day02/资料/day02笔记/img/1732506843896.png" alt="1732506843896" style="zoom:80%;" />

# 第二章.数据库的备份与还原

## 1.用命令去操作数据库的备份与还原

### 1.1.命令操作备份

```mysql
mysqldump  -u用户名 -p密码 数据库名>生成的脚本文件路径

生成的脚本文件路径:指定备份的路径,写路径时最后要指明备份的sql文件名,命令后不要加;
```

### 1.2.命令操作还原

```mysql
mysql  -uroot  -p密码 数据库名 < 文件路径

注意:我们利用命令备份出来的sql文件中没有单独创建数据库的语句,所以如果利用命令去还原的话,需要我们自己手动先创建对应的库
    命令后不要加;
```

## 2.利用点击去操作数据库的备份与还原

### 2.1.利用点击去备份

<img src="D:/data/JAVA/Database/day02/资料/day02笔记/img/1680058707816.png" alt="1680058707816" style="zoom:80%;" />

### 2.2.利用点击去还原

![1680058782201](D:/data/JAVA/Database/day02/资料/day02笔记/img/1680058782201.png)

# 第三章.数据库三范式

```java
好的数据库设计对数据的存储性能和后期的程序开发，都会产生重要的影响。建立科学的，规范的数据库就需要满足一些规则来优化数据的设计和存储，这些规则就称为范式。
```

## 1第一范式: **确保每列保持原子性**

第一范（1NF）式是最基本的范式。如果数据库表中的所有字段值都是不可分解的原子值，就说明该数据库表满足了第一范式。

第一范式的合理遵循需要根据系统的实际需求来定。比如某些数据库系统中需要用到“地址”这个属性，本来直接将“地址”属性设计成一个数据库表的字段就行。但是如果系统经常会访问“地址”属性中的“城市”部分，那么就非要将“地址”这个属性重新拆分为省份、城市、详细地址等多个部分进行存储，这样在对地址中某一部分操作的时候将非常方便。这样设计才算满足了数据库的第一范式，如下表所示。

![](D:/data/JAVA/Database/day02/资料/day02笔记/img/tu_11.png)

如果不遵守第一范式，查询出数据还需要进一步处理（查询不方便）。遵守第一范式，需要什么字段的数据就查询什么数据（方便查询）

```java
列名:详细地址手机号
     
    北京市昌平区北七家镇宏福苑小区19号楼1501087xxxx -> 不行,因为数据可以拆分,不符合第一范式原子性
```

## 2 第二范式: **确保表中的每行都能唯一区分**

第二范式（2NF)第二范式（2NF）是在第一范式（1NF）的基础上建立起来的，即满足第二范式（2NF）必须先满足第一范式（1NF）。第二范式（2NF）要求数据库表中的每个实例或行必须可以被惟一的区分。为实现区分通常需要为表加上一个列，以存储各个实例的惟一标识。

它要求：

> **跟“整个主键”没关系的信息，不能放在这张表里！**
>
> **第二范式就是：不要把“只跟主键一部分有关”的信息，塞进一张以“多个字段当主键”的表里。要拆开，避免重复和混乱！**

## 3 第三范式: **3NF:非主键字段不能相互依赖**

假设有一个员工表，其中包含员工ID（主键）、员工姓名、部门名称和部门负责人。在这里，“部门负责人”依赖于“部门名称”，而“部门名称”又依赖于“员工ID”，因此“部门负责人”传递依赖于“员工ID”。这不符合3NF。需要将部门相关信息拆分到另一个表中，例如一个独立的部门表。（==说白了部门表是部门表，员工表是员工表，把他两拆开，不要放在一起，后续有外键约束将二者联系起来==）

通过逐步满足这三个范式，可以设计出更加规范化、减少冗余和依赖关系的数据库结构，从而提高数据的完整性和查询效率。  

# 第四章.多表之间的关系（选定一个数据看）

在关系数据库管理系统中，很多表之间是有关系的，表之间的关系分为一对一关系、一对多关系和多对多关系。

## 4.1.一对一

该关系中第一个表中的一个行只可以与第二个表中的一个行相关，且第二个表中的一个行也只可以与第一个表中的一个行相关。

例如，"人员信息表","身份证表",一个人只能有一个身份证号,反过来一个身份证号只能对应一个人

<img src="D:/data/JAVA/Database/day02/资料/day02笔记/img/1727048556779.png" alt="1727048556779" style="zoom:80%;" />

## 4.2.一对多

==第一个表中的一个行可以与第二个表中的一个或多个行相关，但第二个表中的一个行只可以与第一个表中的一个行相关==。(正着看一对多，倒着看一对一)

例如，“商品分类表”和“商品信息表”。一个商品分类对应多个商品,反过来一个商品只属于一个分类,形成了一对多

<img src="D:/data/JAVA/Database/day02/资料/day02笔记/img/1727048576499.png" alt="1727048576499" style="zoom:80%;" />

## 4.3.多对多

该关系中第一个表中的一个行可以与第二个表中的一个或多个行相关。第二个表中的一个行也可以与第一个表中的一个或多个行相关。通常两个表的多对多关系会借助第三张表，转换为两个一对多的关系。

例如，选课系统的“学生信息表”和“课程信息表”是多对多关系。一个学生可以选择多门课，一门课程可以被多个学生选择，即“学生信息表”中一条记录可以与“课程信息表”多条记录对应，反过来“课程信息表”的一条记录也可以与“学生信息表”中多条记录对应。它们之间借助第三张“选课信息表”实现关联关系，而“学生信息表”与“选课信息表”是一对多关系，“课程信息表”与“选课信息表”也是一对多关系。“选课信息表”中“学号”字段与“学生信息表”中“学号”字段意义相同。“课程信息表”中“课程编号”字段与“课程信息表”中“课程编号”字段意义相同。

<img src="D:/data/JAVA/Database/day02/资料/day02笔记/img/1727048600042.png" alt="1727048600042" style="zoom:80%;" />

> 一对一:
>
> ​    正着看,倒着看都是一对一
>
> 一对多:
>
> ​    正着看一对多,倒着看一对一
>
> 多对多:
>
> ​     正着看一对多,倒着看一对多

# 第五章.创建外键约束

```java
创建外键约束的原因:表和表之间是有联系的,那么将来有联系的表应该有数据约束,比如:
两张表:
   商品分类表   商品信息表  -> 比如有蔬菜分类,那么商品表中可以有黄瓜,西红柿,茄子,土豆等
                            但是没有水果分类,那么商品表中不能有水果相关的
       
默认情况下两张独立的表谁也不能限制谁->所以只有创建了外键约束,一张表中的数据才会限制另外一张表       
```

# 第五章.创建外键约束

```mysql
格式:alter table 从表 add [constraint 外键名称(自定义)] foreign key 从表(外键列名) references 主表(主键列名)
```

## 1.一对多的表创建外键约束

```java
1.分析商品分类表和商品信息表的关系:一对多
   从分类表往商品信息表看:一个分类对应多个商品 -> 一对多
   从商品表往分类表看:一个商品只对应一个分类 -> 一对一

2.要分清主表和从表:假设如果这张表建立约束之后,谁限制谁?
  如果分类表和商品表之间将来建议约束,分类表中的数据会限制商品表中的数据
  所以分类表为主表,信息表为从表

3.如果没有建立约束,两张独立的表不会相互制约,只有建立了外键约束,表中的数据才会制约
   首先我们应该创建一个外键列,而外键列一般都放到从表中,存储主表的主键
```

<img src="D:/data/JAVA/Database/day02/资料/day02笔记/img/1739518431040.png" alt="1739518431040" style="zoom:80%;" />

```mysql
    #商品分类表->主表    
    CREATE TABLE category (
      cid VARCHAR(32) PRIMARY KEY ,
      cname VARCHAR(50)
    );

    #商品表->从表
    CREATE TABLE products(
      pid VARCHAR(32) PRIMARY KEY ,
      pname VARCHAR(50),
      price DOUBLE,
      category_id VARCHAR(32)-- 外键  存储的是主表的主键内容
    );  
    
    /*
     格式:alter table 从表 add [constraint 外键名称(自定义)] foreign key 从表(外键列名) 
          references 主表(主键列名)    
    */
    
    ALTER TABLE products ADD CONSTRAINT cp1 FOREIGN KEY products(category_id) REFERENCES category(cid);
    
            
```

<img src="D:/data/JAVA/Database/day02/资料/day02笔记/img/1739519349308.png" alt="1739519349308" style="zoom:80%;" />

## 2.多对多的表创建外键约束

<img src="D:/data/JAVA/Database/day02/资料/day02笔记/img/1739519606360.png" alt="1739519606360" style="zoom:80%;" />

```mysql
# 订单表 -> 主表
 CREATE TABLE `orders`(
  `oid` VARCHAR(32) PRIMARY KEY ,
  `totalprice` DOUBLE 	#总计
  );
   
#订单项表->中间表->从表
CREATE TABLE orderitem(
  pid VARCHAR(50),-- 商品id->外键
  oid VARCHAR(50)-- 订单id ->外键
);

```

<img src="D:/data/JAVA/Database/day02/资料/day02笔记/img/1739519806558.png" alt="1739519806558" style="zoom:80%;" />

> 将来开发一般不会上来就创建外键约束,不方便我们用测试数据测试功能;都是测试完毕,最后建立外键约束

# 第六章.多表查询

数据准备

```mysql
    # 分类表
    CREATE TABLE category (
      cid VARCHAR(32) PRIMARY KEY ,
      cname VARCHAR(50)
    );

    #商品表
    CREATE TABLE products(
      pid VARCHAR(32) PRIMARY KEY ,
      pname VARCHAR(50),
      price DOUBLE,
      flag VARCHAR(2), #是否上架标记为：1表示上架、0表示下架
      category_id VARCHAR(32), -- 外键
      CONSTRAINT products_fk FOREIGN KEY (category_id) REFERENCES category (cid)
    );
    #分类
INSERT INTO category(cid,cname) VALUES('c001','家电');
INSERT INTO category(cid,cname) VALUES('c002','服饰');
INSERT INTO category(cid,cname) VALUES('c003','化妆品');
#商品
INSERT INTO products(pid, pname,price,flag,category_id) VALUES('p001','联想',5000,'1','c001');
INSERT INTO products(pid, pname,price,flag,category_id) VALUES('p002','海尔',3000,'1','c001');
INSERT INTO products(pid, pname,price,flag,category_id) VALUES('p003','雷神',5000,'1','c001');

INSERT INTO products (pid, pname,price,flag,category_id) VALUES('p004','JACK JONES',800,'1','c002');
INSERT INTO products (pid, pname,price,flag,category_id) VALUES('p005','真维斯',200,'1','c002');
INSERT INTO products (pid, pname,price,flag,category_id) VALUES('p006','花花公子',440,'1','c002');
INSERT INTO products (pid, pname,price,flag,category_id) VALUES('p007','劲霸',2000,'1','c002');

INSERT INTO products (pid, pname,price,flag,category_id) VALUES('p008','香奈儿',800,'1','c003');
INSERT INTO products (pid, pname,price,flag,category_id) VALUES('p009','相宜本草',200,'1','c003');
```

## 1.交叉查询

```mysql
1.语法: select 列名 from 表A,表B
```

```mysql
-- 查询所有商品的具体信息
SELECT * FROM category,products;

SELECT * FROM category,products WHERE category.cid = products.category_id;

-- 给表取别名
SELECT * FROM category c,products p WHERE c.cid = p.category_id;
```

<img src="D:/data/JAVA/Database/day02/资料/day02笔记/img/1739521176952.png" alt="1739521176952" style="zoom:80%;" />

## 2.内连接查询

**“显式内连接”和“隐式内连接”效果完全一样，只是写法不同。**

on的作用是告诉数据库:两张表怎么关联

> 但 **推荐用显式（`JOIN ... ON`）**，因为更清晰、更安全、更现代！

```mysql
1.关键字: inner join on  -> inner可以省略

2.分类:
  a.显示内连接:select 列名 from 表A join 表B on 条件 
  b.隐式内连接:select 列名 from 表A,表B where 条件 
```

```mysql
-- 查询具体的商品信息->隐式内连接
1

-- 查询具体的商品信息->显示内连接
1

-- 用显示内连接的方式查询"化妆品"的商品信息
1
```

```sql
-- 查询具体的商品信息->隐式内连接
SELECT * FROM category c,products p WHERE c.cid = p.category_id;

-- 查询具体的商品信息->显示内连接
SELECT * FROM category c JOIN products p ON c.`cid` = p.`category_id`;

-- 用显示内连接的方式查询"化妆品"的商品信息

/*
   on 条件1 and 条件2  -> 条件1和条件2是一个大条件
   on 条件1 where 条件2 -> 两个条件
*/
SELECT * FROM category c JOIN products p ON c.`cid` = p.`category_id` AND c.`cname` = '化妆品'

SELECT * FROM category c JOIN products p ON c.`cid` = p.`category_id` WHERE c.`cname` = '化妆品'
```

## 3.外连接

```mysql
1.关键字:outer join on -> outer可以省略
2.分类:
  a.左外连接: select 列名 from 表A left join 表B on 条件
  b.右外连接: select 列名 from 表A right join 表B on 条件
3.区分左表和右表
  join左边的就是左表
  join右边的就是右表
  
4.左外连接和右外连接以及内连接区别:
  a.左外连接:查询的是和右表的交集,以及左边的全部
  b.右外连接:查询的是和左表的交集,以及右表的全部
  c.内连接:查询的是两张表的交集
```

```mysql
-- 查询所有的商品信息 左外连接
1

-- 查询所有的商品信息 右外连接
1

-- 查询所有的商品信息内连接
1
```

```sql
-- 查询所有的商品信息 左外连接
SELECT * FROM category c LEFT JOIN products p ON c.`cid` = p.`category_id`;

-- 查询所有的商品信息 右外连接
SELECT * FROM category c RIGHT JOIN products p ON c.`cid` = p.`category_id`;

-- 查询所有的商品信息内连接
SELECT * FROM category c,products p WHERE c.`cid` = p.`category_id`;
```

<img src="D:/data/JAVA/Database/day02/资料/day02笔记/img/1739522811375.png" alt="1739522811375" style="zoom:80%;" />



<img src="D:/data/JAVA/Database/day02/资料/day02笔记/img/1739522887416.png" alt="1739522887416" style="zoom:80%;" />



<img src="D:/data/JAVA/Database/day02/资料/day02笔记/img/1739522934838.png" alt="1739522934838" style="zoom:80%;" />

## 4.union联合查询实现全外连接查询（了解）

```java
首先要明确，联合查询不是多表连接查询的一种方式。联合查询是将多条查询语句的查询结果合并成一个结果并去掉重复数据。
全外连接查询的意思就是将左表和右表的数据都查询出来，然后按照连接条件连接
    
只要将两个结果一连接,左表和右表没有交叉的部分也就都查出来了
```

```java
1.union的语法:
  查询语句1 union 查询语句2 union 查询语句3 ...
```

```mysql
-- 查询所有的商品信息 左外连接
SELECT * FROM category c LEFT JOIN products p ON c.`cid` = p.`category_id`;

-- 查询所有的商品信息 右外连接
SELECT * FROM category c RIGHT JOIN products p ON c.`cid` = p.`category_id`;

-- 查询所有的商品信息内连接
SELECT * FROM category c,products p WHERE c.`cid` = p.`category_id`;


-- 全外连接 (左+右)

SELECT * FROM category c LEFT JOIN products p ON c.`cid` = p.`category_id`

UNION

SELECT * FROM category c RIGHT JOIN products p ON c.`cid` = p.`category_id`;
```

## 5.子查询

```mysql
一条查询语句作为另外一条查询语句的条件使用
```

```mysql
-- 查询products表中'化妆品'的商品信息
1

-- 查询products表中化妆品和家电的商品信息
1
```

```sql
-- 查询products表中'化妆品'的商品信息
SELECT * FROM products WHERE category_id = 'c003'; 

/*
  单纯看products表我们不知道c003到底代表是啥
  因为c003是从category中得来的
  所以c003需要从category表中确定,是否为化妆品
*/
-- 先从categroy表中查询出化妆品对应的cid
SELECT cid FROM category WHERE cname = '化妆品';

-- 将以上的查询结果当成条件使用
SELECT * FROM products WHERE category_id = (SELECT cid FROM category WHERE cname = '化妆品');

-- 查询products表中化妆品和家电的商品信息
SELECT * FROM products WHERE category_id IN ('c001','c003');

-- 将c001和c003从category表中查询出来,当成条件使用
SELECT cid FROM category WHERE cname IN ('家电','化妆品');

SELECT * FROM products WHERE category_id IN (SELECT cid FROM category WHERE cname IN ('家电','化妆品'));
```

## 6.子查询作为伪表使用

```mysql
1.查询语句的结果是一张伪表,这个伪表也可以当成一个表和其他的表做查询
```

```mysql
-- 查询化妆品的所有商品信息
1
-- 查询所有化妆品和家电的商品信息

```

```sql
-- 查询化妆品的所有商品信息
SELECT * FROM category c,products p WHERE c.`cid` = p.`category_id` AND cname = '化妆品';

-- 先将化妆品从category中查询出来
SELECT * FROM category WHERE cname = '化妆品';

SELECT * FROM (SELECT * FROM category WHERE cname = '化妆品') c,products p WHERE c.`cid` = p.`category_id`;

-- 查询所有化妆品和家电的商品信息

-- 先查询家电和化妆品
SELECT * FROM category WHERE cname IN('化妆品','家电');

SELECT * FROM (SELECT * FROM category WHERE cname IN('化妆品','家电')) c,products p WHERE c.`cid` = p.`category_id`;

```

<img src="D:/data/JAVA/Database/day02/资料/day02笔记/img/1739524357900.png" alt="1739524357900" style="zoom:80%;" />

# 第七章.sql练习

## 1.创建数据库

```mysql
CREATE DATABASE mytest01;
USE mytest01;
```

## 2.创建表以及添加数据

```mysql
# 创建部门表dept  部门表中包含 部门id 部门名称  
CREATE TABLE dept(
  id INT PRIMARY KEY AUTO_INCREMENT,
  NAME VARCHAR(20)
)

INSERT INTO dept (NAME) VALUES ('开发部'),('市场部'),('财务部');  
```

```mysql
# 创建员工表
CREATE TABLE emp (
  id INT PRIMARY KEY AUTO_INCREMENT,
  NAME VARCHAR(10),
  gender CHAR(1),   -- 性别
  salary DOUBLE,   -- 工资
  join_date DATE,  -- 入职日期
  dept_id INT,
  FOREIGN KEY (dept_id) REFERENCES dept(id) -- 外键，关联部门表(部门表的主键)
)  

INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('小松松','男',7200,'2013-02-24',1);
INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('鱼小鱼','女',3600,'2015-12-02',2);
INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('小霈霈','男',8000,'2013-12-02',3);
INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('亮仔','男',5000,'2017-11-11',2);
INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('坤仔','男',8000,'2012-02-02',1);
INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('福姐','女',6500,'2011-09-12',3);
INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('熊姐','女',10500,'2018-12-02',3);
INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('猛哥','男',9500,'2016-07-08',2);
INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('栋栋','男',8500,'2018-06-28',2);
```

## 3.练习

-- 1.查询员工和部门的名字
-- 2.查询鱼小鱼的信息，显示员工id，姓名，性别，工资和所在的部门名称(使用显式内连接)
-- 3.将上面查到的内容 表头使用别名的形式展示 比如显示id为员工id  name为姓名 等
-- 4.在部门表中增加一个销售部 
-- 5.==查询所有的部门信息关联查询出该部门中的所有员工信息== 
-- 6.查询所有的部门信息关联查询出该部门中的所有员工的名字  部门 以及 工资 
-- 7.统计出 每个部门的员工人数   查询显示 部门名称 人数 
-- 8.统计出 每个部门员工 平均薪资 按照 薪资排序 查询显示 部门名称 平均薪资 
-- 9.==统计出，每个部门的平均薪资 按照薪资排序 并且筛选出平均薪资>7000的部门==
-- 10.==查询最高工资是多少==
-- 11.==根据最高工资到员工表查询到对应的员工信息==
-- 12.查询工资小于平均工资的员工有哪些
-- 13.==查询工资大于5000的员工，来自于哪些部门的名字==  
-- 14.查询开发部与财务部所有的员工信息
-- 15.==查询出2011年以后入职的员工信息，包括部门名称==



```mysql
-- 1.查询员工和部门的名字
SELECT emp.`name`, dept.`name` FROM emp,dept WHERE emp.`dept_id` = dept.`id`;
```

```mysql
-- 2.查询鱼小鱼的信息，显示员工id，姓名，性别，工资和所在的部门名称(使用显式内连接)
SELECT * FROM emp e INNER JOIN dept d ON e.`dept_id` = d.`id` WHERE e.`name`='鱼小鱼';
```

```mysql
-- 3.将上面查到的内容 表头使用别名的形式展示 比如显示id为员工id  name为姓名 等
SELECT e.id 编号,e.name 姓名,e.gender 性别,e.salary 工资,d.name 部门名字 FROM emp e INNER JOIN dept d ON e.dept_id = d.id WHERE e.name='鱼小鱼';
```

```mysql
-- 4.在部门表中增加一个销售部 
INSERT INTO dept (NAME) VALUES ('销售部');
SELECT * FROM dept;
```

```mysql
-- 5.查询所有的部门信息关联查询出该部门中的所有员工信息 
SELECT * FROM dept d LEFT JOIN emp e ON d.`id` = e.`dept_id`;
```

```mysql
-- 6.查询所有的部门信息关联查询出该部门中的所有员工的名字  部门 以及 工资 
SELECT e.name 姓名,d.name 部门, e.salary 工资 FROM dept d LEFT JOIN emp e ON d.id = e.dept_id;
```

```mysql
-- 7.统计出 每个部门的员工人数   查询显示 部门名称 人数 
SELECT d.name 部门,COUNT(e.name) 人数 FROM dept d LEFT JOIN emp e ON d.id = e.dept_id GROUP BY d.name;
```

```mysql
-- 8.统计出 每个部门员工 平均薪资 按照 薪资排序 查询显示 部门名称 平均薪资 
SELECT d.name 部门,AVG(e.salary) `平均薪资` FROM dept d LEFT JOIN emp e ON d.id = e.dept_id GROUP BY d.name ORDER BY salary;
```

```mysql
-- 9.统计出，每个部门的平均薪资 按照薪资排序 并且筛选出平均薪资>7000的部门
SELECT d.name 部门,AVG(e.salary) 人数 FROM dept d LEFT JOIN emp e ON d.id = e.dept_id 
GROUP BY d.name HAVING AVG(e.salary)>7000 ORDER BY salary;
```

```mysql
-- 10.查询最高工资是多少
SELECT MAX(salary) FROM emp;
```

```mysql
-- 11.根据最高工资到员工表查询到对应的员工信息
SELECT * FROM emp WHERE salary=(SELECT MAX(salary) FROM emp)
```

```mysql
-- 12.查询工资小于平均工资的员工有哪些
SELECT * FROM emp WHERE salary < (SELECT AVG(salary) FROM emp);
```

```mysql
-- 13.查询工资大于5000的员工，来自于哪些部门的名字  
 SELECT dept.name FROM dept WHERE dept.id IN (SELECT dept_id FROM emp WHERE salary > 5000)
```

```mysql
-- 14.查询开发部与财务部所有的员工信息
SELECT * FROM emp WHERE dept_id IN (SELECT id FROM dept WHERE NAME IN('开发部','财务部'));
```

```mysql
-- 15.查询出2011年以后入职的员工信息，包括部门名称
SELECT * FROM dept d, (SELECT * FROM emp WHERE join_date > '2011-1-1') e WHERE e.dept_id = d.id;
```

# SQL 查询的执行顺序（重点！）

理解这个问题的核心是记住 **SQL 子句的实际执行顺序**（不是书写顺序）：

| 步骤 | 子句                                  | 作用阶段                               |
| ---- | ------------------------------------- | -------------------------------------- |
| 1    | `FROM`                                | 确定数据来源（包括 JOIN）              |
| 2    | `ON`                                  | 过滤 JOIN 的匹配条件                   |
| 3    | `WHERE`                               | 过滤行（在分组前）                     |
| 4    | `GROUP BY`                            | 将数据分组                             |
| 5    | **聚合函数计算**（如 `AVG`, `COUNT`） |                                        |
| 6    | `HAVING`                              | **过滤分组后的结果**（可使用聚合函数） |
| 7    | `SELECT`                              | 选择要显示的列                         |
| 8    | `ORDER BY`                            | 排序                                   |
| 9    | `LIMIT`                               | 限制返回行数                           |

HAVING 和GROUP BY合用

# day03.函数_jdbc

```mysql
课前回顾:
  1.简单查询: select 列名 from 表名
  2.条件查询: select 列名 from 表名 where 条件
  3.表关系:
    一对一:  正反都是一对一
    一对多:  正着看一对多,倒着看一对一
    多对多:  正反都是一对多
  4.交叉查询:
    select 列名 from 表A,表B
  5.内连接:
    a.隐式内连接:select 列名 from 表A,表B where 条件
    b.显式内连接:select 列名 from 表A join 表B on 条件
  6.外连接:
    a.左外连接:select 列名 from 表A left join 表B on 条件
    b.右外连接:select 列名 from 表A right join 表B on 条件
  7.子查询: 一条select作为另外一条select语句的条件使用 
  
今日重点:
  1.会字符串函数以及流程函数的使用
  2.从第三章到第四章都是重点
```

# 第一章.MySQL的常用函数

```java
1.数据库中的函数都是操作一列数据
2.都是写在select后面
```

##  1.字符串函数

### 1.1 字符串函数列表概览

| 函数                                  | 用法                                          |
| ------------------------------------- | --------------------------------------------- |
| CONCAT(S1,S2,......,Sn)               | 连接S1,S2,......,Sn为一个字符串               |
| CONCAT_WS(separator, S1,S2,......,Sn) | 连接S1一直到Sn，并且中间以separator作为分隔符 |
| UPPER(s) 或 UCASE(s)                  | 将字符串s的所有字母转成大写字母               |
| LOWER(s)  或LCASE(s)                  | 将字符串s的所有字母转成小写字母               |
| TRIM(s)                               | 去掉字符串s开始与结尾的空格                   |
| SUBSTRING(s,index,len)                | 返回从字符串s的index位置其len个字符           |

### 1.2 环境准备

```mysql
-- 用户表
CREATE TABLE t_user (
  id int(11) NOT NULL AUTO_INCREMENT,
  uname varchar(40) DEFAULT NULL,
  age int(11) DEFAULT NULL,
  sex int(11) DEFAULT NULL,
  PRIMARY KEY (id)
);
insert  into t_user values (null,'zs',18,1);
insert  into t_user values (null,'ls',20,0);
insert  into t_user values (null,'ww',23,1);
insert  into t_user values (null,'zl',24,1);
insert  into t_user values (null,'lq',15,0);
insert  into t_user values (null,'hh',12,0);
insert  into t_user values (null,'wzx',60,null);
insert  into t_user values (null,'lb',null,null);
```

### 1.3 字符串连接函数

字符串连接函数主要有2个：

| 函数或操作符                          | 描述                                     |
| ------------------------------------- | ---------------------------------------- |
| concat(str1, str2, ...)               | 字符串连接函数，可以将多个字符串进行连接 |
| concat_ws(separator, str1, str2, ...) | 可以指定间隔符将多个字符串进行连接；     |

练习1：使用concat函数显示出 你好uname 的结果

```mysql
/*
  concat(str1, str2, ...)
  字符串连接函数，可以将多个字符串进行连接
  
  concat_ws(separator, str1, str2, ...)->可以指定间隔符将多个字符串进行连接
*/
-- 拼接字符串练习 练习1：使用concat函数显示出 你好uname 的结果

```

```sql
/*
  concat(str1, str2, ...)
  字符串连接函数，可以将多个字符串进行连接
  
  concat_ws(separator, str1, str2, ...)->可以指定间隔符将多个字符串进行连接
*/
-- 拼接字符串练习 练习1：使用concat函数显示出 你好uname 的结果
SELECT id,CONCAT('你好',uname) uname,age,sex FROM t_user;
```

练习2：使用concat_ws函数显示出 你好,uname 的结果

```mysql
-- 练习2：使用concat_ws函数显示出 你好,uname 的结果
SELECT id,CONCAT_WS(',','你好',uname) uname,age,sex FROM t_user;
```

### 1.4 字符串大小写处理函数

字符串大小写处理函数主要有2个：

| 函数或操作符 | 描述              |
| ------------ | ----------------- |
| upper(str)   | 得到str的大写形式 |
| lower(str)   | 得到str的小写形式 |

练习1： 将字符串 uname 转换为大写显示

```mysql
-- 将hello转成大写
SELECT UPPER('hello');

-- 查询t_user,uname变成大写
SELECT id,UPPER(uname) uname,age,sex FROM t_user;
```

练习2：将uname 转换为小写显示

```mysql
-- 查询t_user,uname变成小写
SELECT id,LOWER(uname) uname,age,sex FROM t_user;
```

### 1.5 移除空格函数

可以对字符串进行按长度填充满、也可以移除空格符

| 函数或操作符 | 描述                  |
| ------------ | --------------------- |
| trim(str)    | 将str两边的空白符移除 |

练习1： 将用户id为9的用户的姓名的两边空白符移除

```mysql
-- 将用户id为9的用户的姓名的两边空白符移除
SELECT id,TRIM(uname) uname,age,sex FROM t_user WHERE id = 9;
```

### 1.6 子串函数

字符串也可以按条件进行截取，主要有以下可以截取子串的函数;

| 函数或操作符          | 描述                                                         |
| --------------------- | ------------------------------------------------------------ |
| substr()、substring() | 获取子串： 1：substr(str, pos) 、substring(str, pos)； 2：substr(str, pos, len)、substring(str, pos, len) |

```mysql
/*
  substring(str, pos)
            str:被截取的字符串
            pos:从第几个字符开始截取
  substring(str, pos, len)
            str:被截取的字符串
            pos:从第几个字符开始截取
            len:截取多少个字符
*/
SELECT SUBSTRING('abcdefg',2);

SELECT SUBSTRING('abcdefg',2,2);
```

练习1：获取 hello,world 从第二个字符开始的完整子串

```mysql
SELECT SUBSTR('hello,world',2)sout;
```

练习2：获取 hello,world 从第二个字符开始但是长度为4的子串

```mysql
SELECT SUBSTR('hello,world',2,4)sout;
```

## 2.数值函数

### 2.1. 数值函数列表

| 函数     | 用法                              |
| -------- | --------------------------------- |
| ABS(x)   | 返回x的绝对值                     |
| CEIL(x)  | 返回大于x的最小整数值【向上取整】 |
| FLOOR(x) | 返回小于x的最大整数值【向下取整】 |
| RAND()   | 返回0~1的随机值                   |
| POW(x,y) | 返回x的y次方                      |

### 2.2. 常用数值函数练习

```mysql
-- 练习1： 获取 -12 的绝对值


-- 练习2： 将 -11.2 向上取整


-- 练习3： 将 1.6 向下取整


-- 练习4： 获得2的2次幂的值



-- 练习5： 获得一个在0-100之间的随机数

```

```sql
-- 练习1： 获取 -12 的绝对值
SELECT ABS(-12);
-- 练习2： 将 -11.2 向上取整
SELECT CEIL(-11.2);

-- 练习3： 将 1.6 向下取整
SELECT FLOOR(1.6);

-- 练习4： 获得2的2次幂的值
SELECT POW(2,2);

-- 练习5： 获得一个在0-100之间的随机数
SELECT RAND()*100;
```

## 3.日期函数

### 3.1 日期函数列表

| 函数                                                         | 用法                                                      |
| ------------------------------------------------------------ | --------------------------------------------------------- |
| **CURDATE()** 或 CURRENT_DATE()                              | 返回当前日期  年月日                                      |
| **CURTIME()** 或 CURRENT_TIME()                              | 返回当前时间  时分秒                                      |
| **NOW()** / SYSDATE() / CURRENT_TIMESTAMP() / LOCALTIME() / LOCALTIMESTAMP() | 返回当前系统日期时间                                      |
| DATEDIFF(date1,date2) / TIMEDIFF(time1, time2)               | 返回date1 - date2的日期间隔 / 返回time1 - time2的时间间隔 |

### 3.2 常用日期函数的练习

```mysql
-- 练习1：获取当前的日期(仅仅需要年月日)


-- 练习2： 获取当前的时间（仅仅需要时分秒）


-- 练习3： 获取当前日期时间（包含年月日时分秒）



-- 练习4: 获取到12月1日还有多少天

```

```java
-- 练习1：获取当前的日期(仅仅需要年月日)
SELECT CURDATE();

-- 练习2： 获取当前的时间（仅仅需要时分秒）
SELECT CURTIME();

-- 练习3： 获取当前日期时间（包含年月日时分秒）
SELECT NOW();

-- 练习4: 获取到5月1日还有多少天
SELECT DATEDIFF('2025-5-1',NOW());
```

## 4.流程函数_判断

| 函数                                                         | 用法                                         |
| ------------------------------------------------------------ | -------------------------------------------- |
| IF(比较,t ,f)<br>里面的t和f是两个结果                        | 如果比较是真，返回t，否则返回f               |
| IFNULL(value1, value2)                                       | 如果value1不为空，返回value1，否则返回value2 |
| CASE WHEN 条件1 THEN result1 WHEN 条件2 THEN result2 .... [ELSE resultn] END | 相当于Java的if...else if...else...           |

* 练习1：获取用户的姓名、性别，如果性别为1则显示'男'，否则显示'女'；要求使用if函数查询：

  ```mysql
  SELECT id,uname,IF(sex=1,'男','女') sex FROM t_user;
  ```


* 练习2：获取用户的姓名、性别，如果性别为null则显示为0；要求使用ifnull函数查询：

  ```mysql
  SELECT id,uname,IFNULL(sex,0) sex FROM t_user;
  ```


* 练习3：如果age<=12,显示儿童,如果age<=18,显示少年,如果age<=40,显示中年,否则显示老年

  ```mysql
  SELECT id,uname,CASE WHEN age<=12 THEN '儿童' 
  WHEN age<=18 THEN '少年' 
  WHEN age<=40 THEN '中年' 
  ELSE '老年' END age FROM t_user;
  ```

# 第二章 DCL语句

我们现在默认使用的都是root用户，超级管理员，拥有全部的权限。但是，一个公司里面的数据库服务器上面可能同时运行着很多个项目的数据库。所以，我们应该根据不同的项目建立不同的用户，分配不同的权限来管理和维护数据库。

<img src="D:/data/JAVA/Database/day03/img/1739583676873.png" alt="1739583676873" style="zoom:80%;" />

## 2.1 创建用户

```mysql
CREATE USER '用户名'@'主机名' IDENTIFIED BY '密码';
```

**关键字说明：**

```java
1.用户名:创建的用户名
2.主机名:指定该用户在哪个主机上可以登录,如果是本地用户,可以用'localhost',如果想让该用户可以任意远程主机登录,可以使用通配符%
3.密码:该用户登录的密码,密码可以为空,如果为空,该用户可以不输入密码就可以登录mysql
```

**具体操作：**

```sql
-- user1用户只能在localhost这个IP登录mysql服务器
CREATE USER 'user1'@'localhost' IDENTIFIED BY '123';
-- user2用户可以在任何电脑上登录mysql服务器
CREATE USER 'user2'@'%' IDENTIFIED BY '123';
```

## 2.2 授权用户

用户创建之后，基本没什么权限！需要给用户授权
![](D:/data/JAVA/Database/day03/img/DCL02.png)

**授权格式**：

```sql
GRANT 权限1, 权限2... ON 数据库名.表名 TO '用户名'@'主机名';
```

**关键字说明**：

```java
a.GRANT:授权关键字
b.授予用户的权限,比如  'select' 'insert' 'update'等,如果要授予所有的权限,使用 'ALL'
c.数据库名.表名:该用户操作哪个数据库的哪些表,如果要授予该用户对所有数据库和表的相关操作权限,就可以用*表示: *.*
d.'用户名'@'主机名':给哪个用户分配权限
```

**具体操作：**

1. 给user1用户分配对test这个数据库操作的权限

   ```
   .*的意思是可以操控该数据库下的所有表
   *.*的意思是可以操控所有数据库以及下面的所有表
   ```

   ```sql
   GRANT CREATE,ALTER,DROP,INSERT,UPDATE,DELETE,SELECT ON test.* TO 'user1'@'localhost';
   ```

   ![](D:/data/JAVA/Database/day03/img/DCL03.png)

2. 给user2用户分配对所有数据库操作的权限

   ```sql
   GRANT ALL ON *.* TO 'user2'@'%';
   ```

   ![](D:/data/JAVA/Database/day03/img/DCL04.png)

## 2.3 撤销授权

```sql
REVOKE  权限1, 权限2... ON 数据库.表名 FROM '用户名'@'主机名';
```

**具体操作：**

* 撤销user1用户对test操作的权限

  ```sql
  REVOKE ALL ON test.* FROM 'user1'@'localhost';
  ```

  ![](D:/data/JAVA/Database/day03/img/DCL05.png)

## 2.4 查看权限

```sql
SHOW GRANTS FOR '用户名'@'主机名';
```

**具体操作：**

* 查看user1用户的权限

  ```sql
  SHOW GRANTS FOR 'user1'@'localhost';
  ```

  ![](D:/data/JAVA/Database/day03/img/DCL06.png)

## 2.5 删除用户

```sql
DROP USER '用户名'@'主机名';
```

**具体操作：**

* 删除user2

  ```sql
   DROP USER 'user2'@'%';
  ```

  ![](D:/data/JAVA/Database/day03/img/DCL07.png)

```mysql
/*
  分配用户:
    create:创建
    user:用户
    'user1'@'localhost' : 用户名以及可以访问的主机地址
    IDENTIFIED BY '123' : 分配密码
    
    %:可以在任意远程主机上登录
*/
-- user1用户只能在localhost这个IP登录mysql服务器
CREATE USER 'user1'@'localhost' IDENTIFIED BY '123';
-- user2用户可以在任何电脑上登录mysql服务器
CREATE USER 'user2'@'%' IDENTIFIED BY '123';


/*
   grant:分配权限关键字
   grant后面跟的就是具体的操作权限:select insert update等,如果分配所有权限就写ALL
   
   on:后面跟的是数据库名字 -> 指定啥数据库那么用此用户登录就只能看到哪个数据库名字
   
   `220706_mysql03`.* -> 指定库中所有的表 * 代表所有,如果想要看到所有的库以及所有的表我们就写*.*
   
   to:指明此权限要给的用户
*/
-- 给用户1分配权限
GRANT SELECT ON `230222_day02_2`.* TO 'user1'@'localhost';

-- 给用户2分配权限
GRANT ALL ON *.* TO 'user2'@'%';

/*
  drop:删除用户关键字
*/
DROP USER 'user2'@'%';
DROP USER 'user1'@'localhost';
```

## 2.6 修改用户密码

### 2.6.1 修改管理员密码

```sql
mysqladmin -uroot -p password 新密码  -- 新密码不需要加上引号
```

>注意：需要在未登陆MySQL的情况下操作。

**具体操作：**

   ```sql
mysqladmin -uroot -p password root
输入老密码
   ```

   ![](D:/data/JAVA/Database/day03/img/DCL08.png)

### 2.6.2 修改普通用户密码

```sql
set password for '用户名'@'主机名' = password('新密码');
```

>注意：需要在登陆MySQL的情况下操作。

**具体操作：**

   ```sql
set password for 'user1'@'localhost' = password('666666');
   ```

   ![](D:/data/JAVA/Database/day03/img/DCL09.png)

# 第三章.JDBC

## 1.JDBC介绍

```java
1.概述:Java DataBase Connectivity(Java语言连接数据库)
      也是数据库和java连接的一套标准
2.为啥要用它:
  将来我们不可能直接在数据库中写sql语句,我们肯定是将sql语句放到java代码中参与运行,所以我们就需要jdbc中的API
```

<img src="D:/data/JAVA/Database/day03/img/1739586154043.png" alt="1739586154043" style="zoom:80%;" />

## 2.JDBC准备(导入jar包)

```java
1.导入JDBC核心jar包:
  mysql-connector-java-8.0.25.jar
2.JDBC四大核心对象:
  a.DriverManager类:用于注册驱动->我们操作的哪款数据库呀?就注册哪款数据库的驱动
  b.Connection接口(连接对象) : 用于连接数据库
  c.Statement接口(执行平台对象): 用于执行sql语句的
  d.ResultSet接口(结果集对象): 用于处理查询出来的数据
```

## 3.JDBC开发步骤以及详解

JDBC连接Mysql数据库并执行SQL操作的基本流程

```
1.注册驱动:
2.获取连接:
3.准备sql语句:
4.获取执行平台:
5.执行sql:
6.处理结果集:
7.关闭资源:
```

```java
1.注册驱动:DriverManager类,但是mysql会自动注册驱动
         mysql会自动扫描jar包中services下面的文件java.sql.Driver
2.获取连接:Connection对象
  获取:DriverManager中的静态方法:
      static Connection getConnection(String url, String user, String password)  
          
       url:代表的是数据库地址
       user:代表的是登录数据库的用户名
       password:代表的是登录数据库的密码
           
           
3.准备sql语句:
  用字符串String表示一条sql语句
      
4.获取执行平台:Statement对象
  获取:Connection中的方法
      Statement createStatement()
      
5.执行sql:
  Statement中的方法:
     int executeUpdate(String sql) ->  专门操作增删改的 
     ResultSet executeQuery(String sql) -> 专门操作查询的,返回的是结果集    
6.处理结果集:Resultset对象:
while (rs.next()) { //   判断有没有下一个  移动到下一行，首次调用移到第一行
    int id = rs.getInt("id"); //b.getxxx() 获取查询出来的数据
    String name = rs.getString("name");
    System.out.println(id + ": " + name);
}

7.关闭资源:
  结果集对象,执行平台对象,连接对象都要close
```

## 4.JDBC注册驱动

```mysql
CREATE TABLE `user`(
  uid INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(20),
  `password` VARCHAR(20)
);
```

```java
       /*
          1.注册驱动
            DriverManager.registerDriver(Driver driver)
            Driver是一个接口,我们需要传递

          2.注意:我们一创建Driver对象,Driver对象就会加载,我们发现里面有一个静态代码块
            当我们一new,里面的静态代码块直接执行,静态代码块中还有一句注册驱动的代码
            所以我们用此种方式相当于一下子注册了两次驱动
        */
//DriverManager.registerDriver(new Driver());

```

```java
Class.forName("com.mysql.cj.jdbc.Driver");
```

> 其实我们不用自己手动注册驱动:jdbc会自动扫描一个包下的资源->java.sql.driver下的驱动资源

## 5.JDBC获取连接

```java
        /*
           2.获取连接:DriverManager对象
             static Connection getConnection(String url, String user, String password)

             url:代表的是数据库地址->jdbc:mysql://localhost:3306/数据库名字
             user:代表的是登录数据库的用户名
             password:代表的是登录数据库的密码

             jdbc:mysql://localhost:3306/数据库名字,如果后面有请求参数那么在后面加?
             ?后面的内容就是请求参数-> 请求参数都是key=value形式
             jdbc:mysql://localhost:3306/数据库名字?key=value&key=value
         */
        String url = "jdbc:mysql://localhost:3306/241229_database03";
        String user = "root";
        String password = "root";
        Connection connection = DriverManager.getConnection(url,user,password);
        System.out.println("connection = " + connection);
```

> <img src="D:/data/JAVA/Database/day03/img/1739589975580.png" alt="1739589975580" style="zoom:80%;" />![1739590010033](D:/data/JAVA/Database/day03/img/1739590010033.png)
>
> ![1739590015520](D:/data/JAVA/Database/day03/img/1739590015520.png)

## 6.JDBC实现增删改操作

```java
    @Test
    public void insert() throws Exception {
       /*
          1.注册驱动
            DriverManager.registerDriver(Driver driver)
            Driver是一个接口,我们需要传递

          2.注意:我们一创建Driver对象,Driver对象就会加载,我们发现里面有一个静态代码块
            当我们一new,里面的静态代码块直接执行,静态代码块中还有一句注册驱动的代码
            所以我们用此种方式相当于一下子注册了两次驱动
        */
        //DriverManager.registerDriver(new Driver());

        Class.forName("com.mysql.cj.jdbc.Driver");

        /*
           2.获取连接:DriverManager对象
             static Connection getConnection(String url, String user, String password)

             url:代表的是数据库地址->jdbc:mysql://localhost:3306/数据库名字
             user:代表的是登录数据库的用户名
             password:代表的是登录数据库的密码

             jdbc:mysql://localhost:3306/数据库名字,如果后面有请求参数那么在后面加?
             ?后面的内容就是请求参数-> 请求参数都是key=value形式
             jdbc:mysql://localhost:3306/数据库名字?key=value&key=value
         */
        String url = "jdbc:mysql://localhost:3306/241229_database03";
        String user = "root";
        String password = "root";
        Connection connection = DriverManager.getConnection(url,user,password);

        //3.准备sql
        String sql = "insert into user (username,password) values ('tom','111')";

        /*
            4.获取执行平台->Statement对象
              Connection中的方法:Statement createStatement()
         */
        Statement statement = connection.createStatement();

        /*
            5.执行sql语句:Statement中的方法:
               int executeUpdate(String sql) ->  专门操作增删改的 ,不用处理结果集
               ResultSet executeQuery(String sql) -> 专门操作查询的,返回的是结果集
         */
        statement.executeUpdate(sql);

        //6.关闭资源
        statement.close();
        connection.close();
    }
```

```java
 @Test
    public void delete() throws Exception {
        //1.注册驱动
        Class.forName("com.mysql.cj.jdbc.Driver");

        //2.获取连接
        String url = "jdbc:mysql://localhost:3306/241229_database03";
        String user = "root";
        String password = "root";
        Connection connection = DriverManager.getConnection(url,user,password);

        //3.准备sql
        String sql = "delete from user where uid = 1";

        /*
            4.获取执行平台->Statement对象
         */
        Statement statement = connection.createStatement();

        /*
            5.执行sql语句:Statement中的方法:
               int executeUpdate(String sql) ->  专门操作增删改的 ,不用处理结果集
        */
        statement.executeUpdate(sql);

        //6.关闭资源
        statement.close();
        connection.close();
    }
```

```java
    @Test
    public void update() throws Exception {
        //1.注册驱动
        Class.forName("com.mysql.cj.jdbc.Driver");

        //2.获取连接
        String url = "jdbc:mysql://localhost:3306/241229_database03";
        String user = "root";
        String password = "root";
        Connection connection = DriverManager.getConnection(url,user,password);

        //3.准备sql
        String sql = "update user set password = '666' where uid = 2";

        /*
            4.获取执行平台->Statement对象
         */
        Statement statement = connection.createStatement();

        /*
            5.执行sql语句:Statement中的方法:
               int executeUpdate(String sql) ->  专门操作增删改的 ,不用处理结果集
        */
        statement.executeUpdate(sql);

        //6.关闭资源
        statement.close();
        connection.close();
    }
```

> 1.我们可以将在java代码中写的sql语句放到sqlyog中去检测是否正确
>
> 2.或者先从sqlyog中吧sql语句写出来,粘贴到java代码中

## 7.JDBC实现查询操作

```java
1.Statement中的方法:
  ResultSet executeQuery(String sql)
2.处理结果集:ResultSet接口中的方法
  a.boolean next()  判断有没有下一个元素
  b.int getInt(int columnIndex) ->获取int型列的数据,传递的是第几列 
    int getInt(String columnLabel)  ->获取int型列的数据,传递的是列名
    String getString(int columnIndex) -> 获取varchar型列的数据,传递的是第几列
    String getString(String columnLabel) -> 获取varchar型列的数据,传递的是列名 
    
    Object getObject(int columnIndex)  获取数据,传递第几列
    Object getObject(String columnLabel)  获取数据,传递列名
```

```java
    @Test
    public void query() throws Exception {
        //1.注册驱动
        Class.forName("com.mysql.cj.jdbc.Driver");

        //2.获取连接
        String url = "jdbc:mysql://localhost:3306/241229_database03";
        String user = "root";
        String password = "root";
        Connection connection = DriverManager.getConnection(url, user, password);

        //3.准备sql
        String sql = "select * from user";

         /*
            4.获取执行平台->Statement对象
         */
        Statement statement = connection.createStatement();

        //5.执行sql语句:Statement中的方法:
        ResultSet resultSet = statement.executeQuery(sql);

        //6.处理结果集
        while (resultSet.next()) {
            int uid = resultSet.getInt("uid");
            String username = resultSet.getString("username");
            String pwd = resultSet.getString("password");
            System.out.println(uid + " " + username + " " + pwd);
        }
        //7.关闭资源
        resultSet.close();
        statement.close();
        connection.close();
    }   
```

## 8.JDBC工具类使用

```properties
driverClassName=com.mysql.cj.jdbc.Driver
url=jdbc:mysql://localhost:3306/241229_database03
user=root
password=root
```

```java
public class JDBCUtils {
    private JDBCUtils() {
    }

    private static String url = null;
    private static String user = null;
    private static String password = null;

    static {
        try {
            //创建properties集合
            Properties properties = new Properties();
            //读取配置文件
            InputStream in = JDBCUtils.class.getClassLoader().getResourceAsStream("jdbc.properties");
            properties.load(in);
            //解析
            Class.forName(properties.getProperty("driverClassName"));
            url = properties.getProperty("url");
            user = properties.getProperty("user");
            password = properties.getProperty("password");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //获取连接
    public static Connection getConnection() {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(url, user, password);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }

    //关闭资源
    public static void close(Connection connection, Statement statement, ResultSet resultSet) {
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

```

```java
public class Demo02JDBC {
    @Test
    public void insert() throws Exception {
        //1.获取连接
        Connection connection = JDBCUtils.getConnection();
        //2.准备sql
        String sql = "insert into user values(null,'zhangsan','123')";
        //3.获取执行平台->Statement对象
        Statement statement = connection.createStatement();
        //4.执行sql
        statement.executeUpdate(sql);
        //5.关闭资源
        JDBCUtils.close(connection, statement, null);
    }
}

```

## 9.获取最新添加的数据的id

```mysql
1.mysql函数:
  SELECT LAST_INSERT_ID()
2.注意:
  id列不能自己手动指定,需要让mysql自动编号
  
```

```java
 public class Demo03JDBC {
    @Test
    public void insert() throws Exception {
        //获取连接
        Connection connection = JDBCUtils.getConnection();
        //准备sql
        String add = "INSERT INTO `user` (username,`password`) VALUES ('王五','888');";
        String selectLastInsertId = "SELECT LAST_INSERT_ID();";

        //获取执行平台
        Statement statement = connection.createStatement();
        //执行sql
        statement.executeUpdate(add);
        ResultSet resultSet = statement.executeQuery(selectLastInsertId);
        while (resultSet.next()) {
            System.out.println(resultSet.getInt(1));
        }
        //关闭资源
        JDBCUtils.close(connection, statement, resultSet);
    }
}
```

> ```mysql
> INSERT INTO `user` (username,`password`) VALUES ('lisi','456');
> 
> 
> #INSERT INTO `user` (uid,username,`password`) VALUES (8,'lisi','456');
> SELECT LAST_INSERT_ID();
> ```

# 第四章.PreparedStatement预处理对象

<img src="D:/data/JAVA/Database/day03/img/1739604597621.png" alt="1739604597621" style="zoom:80%;" />![1739605307150](D:/data/JAVA/Database/day03/img/1739605307150.png)

## 1.==sql注入==的问题以及解决方式(预处理对象)

```java
public class UserLogin {
    public static void main(String[] args)throws Exception {
        //1.创建Scanner对象
        Scanner sc = new Scanner(System.in);
        //2.录入用户名和密码
        System.out.println("请您输入用户名:");
        String username = sc.nextLine();
        System.out.println("请您输入密码:");
        String password = sc.nextLine();
        //3.获取连接
        Connection connection = JDBCUtils.getConnection();
        //4.准备sql
        String sql = "select * from user where username = '"+username+"' and password = '"+password+"'";
        System.out.println(sql);
        //5.获取执行平台
        Statement statement = connection.createStatement();
        //6.执行sql
        ResultSet rs = statement.executeQuery(sql);
        //7.处理结果集
        if (rs.next()){
            System.out.println("登录成功!");
        }else {
            System.out.println("登录失败!");
        }

        //8.关闭资源
        JDBCUtils.close(connection,statement,rs);
    }
}

```

![1739605312886](D:/data/JAVA/Database/day03/img/1739605312886.png)

> 密码输入:111' or '1' = '1  以上程序不行了->sql注入

## 1.使用预处理对象(PreparedStatement)实现操作

```java
1.概述:PreparedStatement 是 Statement的子接口
2.作用:支持sql中有占位符 -> ?
  String sql = "select * from user username = ? and password = ?"
3.使用:
  a.获取:Connection中的方法
    PreparedStatement prepareStatement(String sql)  
  b.为?赋值:PreparedStatement中的方法
    void setObject(int parameterIndex, Object x)
                   parameterIndex:指的是第几个?
                   x:为?赋的值
  c.执行方法:PreparedStatement中的方法
    int executeUpdate() :针对于增删改操作 
    ResultSet executeQuery() :针对于查询
```

<img src="D:/data/JAVA/Database/day03/img/1739606190421.png" alt="1739606190421" style="zoom:80%;" />

## 2.使用预处理对象(PreparedStatement)实现增删改查操作

```java
public class Demo04JDBC {
    @Test
    public void insert()throws Exception{
        Connection connection = JDBCUtils.getConnection();
        String sql = "INSERT INTO `user` (username,`password`) VALUES (?,?);";
        PreparedStatement pst = connection.prepareStatement(sql);
        //为sql语句中的?赋值
        pst.setObject(1,"tianqi");
        pst.setObject(2,"999");
        pst.executeUpdate();
        JDBCUtils.close(connection,pst,null);
    }

    @Test
    public void delete()throws Exception{
        Connection connection = JDBCUtils.getConnection();
        String sql = "delete from user where uid = ?";
        PreparedStatement pst = connection.prepareStatement(sql);
        //为sql语句中的?赋值
        pst.setObject(1,2);
        pst.executeUpdate();
        JDBCUtils.close(connection,pst,null);
    }

    @Test
    public void update()throws Exception{
        Connection connection = JDBCUtils.getConnection();
        String sql = "update user set password = ? where uid = ?";
        PreparedStatement pst = connection.prepareStatement(sql);
        //为sql语句中的?赋值
        pst.setObject(1,"111");
        pst.setObject(2,3);
        pst.executeUpdate();
        JDBCUtils.close(connection,pst,null);
    }

    @Test
    public void query()throws Exception{
        Connection connection = JDBCUtils.getConnection();
        String sql = "select username,password from user where uid = ?";
        PreparedStatement pst = connection.prepareStatement(sql);
        //为sql语句中的?赋值
        pst.setObject(1,4);
        ResultSet resultSet = pst.executeQuery();
        while (resultSet.next()){
            String username = resultSet.getString("username");
            String password = resultSet.getString("password");
            System.out.println(username+"--"+password);
        }
        JDBCUtils.close(connection,pst,resultSet);
    }
}

```

> 注意:?占位符只能代表值

```java
public class UserLogin {
    public static void main(String[] args)throws Exception {
        //1.创建Scanner对象
        Scanner sc = new Scanner(System.in);
        //2.录入用户名和密码
        System.out.println("请您输入用户名:");
        String username = sc.nextLine();
        System.out.println("请您输入密码:");
        String password = sc.nextLine();
        //3.获取连接
        Connection connection = JDBCUtils.getConnection();
        //4.准备sql
        //String sql = "select * from user where username = '"+username+"' and password = '"+password+"'";
        String sql = "select * from user where username = ? and password = ?";
        //5.获取执行平台
        PreparedStatement pst = connection.prepareStatement(sql);
        //为?赋值
        pst.setObject(1,username);
        pst.setObject(2,password);
        //6.执行sql
        ResultSet rs = pst.executeQuery();
        //7.处理结果集
        if (rs.next()){
            System.out.println("登录成功!");
        }else {
            System.out.println("登录失败!");
        }

        //8.关闭资源
        JDBCUtils.close(connection,pst,rs);
    }
}

```

```java
select * from user where username = 'tom' and password = '111' or '1' = '1'

如果用的是PreparedStatement即使传入了111' or '1' = '1,拼接到了sql语句中会自动将输入'转义
变成了:
select * from user where username = 'tom' and password = '111\' or \'1\' = \'1'
123\' or \'1\' = \'1 是一整个大的字符串,被包裹在了''中   
```

> ?只能给sql语句中的具体的数据占位

> 完成注册功能:作业
>
> ​    输入用户名和密码
>
> ​     根据用户名查询,是否有该用户
>
> ​     如果有,注册失败
>
> ​     否则,将用户名和密码insert到数据库中,显示注册成功

```java
package com.JDBC;

import utils.JDBCUTILS;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class homework {
    public static void main(String[] args) throws Exception {
        //
        Scanner scanner = new Scanner(System.in);
        System.out.println("请输入用户名");
        String username = scanner.nextLine();
        System.out.println("请输入密码");
        String password = scanner.nextLine();
        Connection connection = JDBCUTILS.getConnection();
        //2.sql
        String sql="select * from user where username =?";
        //3.连接
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        //4.
        preparedStatement.setObject(1,username);
        ResultSet resultSet = preparedStatement.executeQuery();
        //5.读取
        if(resultSet.next()){
            System.out.println("注册失败,此用户名已存在!");
        }else{
            //开始注册
            String register="insert into user values(null,?,?)";
            PreparedStatement pr = connection.prepareStatement(register);
            pr.setObject(1,username);
            pr.setObject(2,password);
            pr.executeUpdate();
            System.out.println("注册成功!");
            JDBCUTILS.close(connection,pr,null);
        }
        //6.退出
        JDBCUTILS.close(connection,preparedStatement,resultSet);
    }
}

```

# day04.连接池-DBUtils-事务

```java
课前回顾:
  1.函数:放到select后面用
    字符串函数:和java中的String方法差不多
    判断函数: if  ifnull  case when
  2.DCL:用于分配用户,以及给用户分配权限
  3.JDBC:java连接数据库的一套标准
  4.开发步骤:
    a.注册驱动:Class.forName("Driver的全限定名");
    b.获取连接:
      Connection connection = DriverManager.getConnection("数据库url","数据库账号","数据库密码")
    c.准备sql
    d.获取执行平台:
      Statement st = connection.createStatement()
    e.执行sql
      st.executeUpdate(sql)
      ResultSet rs = st.executeQuery(sql)
    f.处理结果集
      boolean next() 判断有没有下一个数据
      getxxx()获取数据
  5.PreparedStatement:是Statement接口的子接口
    a.特点:支持占位符,防止sql注入问题
    b.获取:
      PreparedStatement pst = connection.preparedStatement(sql)
    c.为?赋值
      setxxx(第几个?,为?赋的值)
    d.执行方法:
      st.executeUpdate()
      ResultSet rs = st.executeQuery()
          
今日重点:
  1.会批量添加操作
  2.使用德鲁伊连接池
  3.会使用DBUtils工具包中的核心类进行增删改查
  4.要知道事务是干啥的
  5.要会使用事务管理一组操作(多条sql语句)
  6.会使用ThreadLocal    
```

# 第一章.PreparedStatement预处理对象

## 1.PreparedStatement实现批量添加

```mysql
CREATE TABLE category(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  cname VARCHAR(10)
);
```

```java
1.注意:mysql默认是不会做批量添加,默认都是一个数据,一个数据的添加,所以需要我们手动开启批量添加操作
2.用到PreparedStatement中的方法:
  void addBatch() -> 将一组数据保存起来,给数据打包,放到内存中
  executeBatch() -> 将打包好的数据一起发送给mysql
      
3.如果想实现批量添加的话,我们需要在url后面添加一个参数:
  ?rewriteBatchedStatements=true
      
  jdbc:mysql://localhost:3306/241023_database3?rewriteBatchedStatements=true

  请求路径?username=tom&password=123

  url?请求参数 -> 请求参数都是key=value形式
```

```properties
driverClassName=com.mysql.cj.jdbc.Driver
url=jdbc:mysql://localhost:3306/241229_database04?rewriteBatchedStatements=true
user=root
password=root
```

```java
public class JDBCUtils {
    private JDBCUtils() {
    }

    private static String url = null;
    private static String user = null;
    private static String password = null;

    static {
        try {
            //创建properties集合
            Properties properties = new Properties();
            //读取配置文件
            InputStream in = JDBCUtils.class.getClassLoader().getResourceAsStream("jdbc.properties");
            properties.load(in);
            //解析
            Class.forName(properties.getProperty("driverClassName"));
            url = properties.getProperty("url");
            user = properties.getProperty("user");
            password = properties.getProperty("password");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //获取连接
    public static Connection getConnection() {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(url, user, password);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }

    //关闭资源
    public static void close(Connection connection, Statement statement, ResultSet resultSet) {
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

```

```java
   @Test
    public void insert()throws Exception{
        //1.获取连接
        Connection connection = JDBCUtils.getConnection();
        //2.准备sql
        String sql = "insert into category (cname) values (?)";
        //3.获取执行平台->PreparedStatement对象
        PreparedStatement pst = connection.prepareStatement(sql);
        for (int i = 0; i < 1000; i++) {
            pst.setObject(1,"java" + i);
            //将要添加的数据打包,放到内存中
            pst.addBatch();
        }
        //4.将内存中打包好的数据批量执行
        pst.executeBatch();
        //5.关闭资源
        JDBCUtils.close(connection,pst,null);
    }
```

# 第二章.连接池

```java
我们现在每做一个操作,我们都要获取一条连接对象(Connection),操作完之后,我们就要关闭Connection对象,如果我们频繁的创建连接对象,销毁连接对象,会非常耗费内存资源,所以我们就想,能不能让连接对象能循环利用?可以了,所以我们就有了"连接池"的概念,先创建一个存有连接对象的容器,用的时候从容器中获取连接对象,用完还回去
```

<img src="D:/data/JAVA/Database/day04笔记/img/1739755768268.png" alt="1739755768268" style="zoom:80%;" />

## 1.连接池之C3p0(扩展)

```java
1.导入C3P0的jar包
  c3p0-0.9.5.2.jar 
  mchange-commons-java-0.2.12.jar  
2.创建C3P0的配置文件(xml):
   a.取名:c3p0-config.xml(名字不能错)
         右键->新建->file-> xxx.xml 
   b.写xml的配置:
     <c3p0-config>
    <!-- 使用默认的配置读取连接池对象 -->
    <default-config>
        <!--  连接参数 -->
        <property name="driverClass">com.mysql.cj.jdbc.Driver</property>
        <property name="jdbcUrl">jdbc:mysql://localhost:3306/nini?rewriteBatchedStatements=true</property>
        <property name="user">root</property>
        <property name="password">1234</property>

        <!--
          连接池参数
          初始连接数(initialPoolSize)：刚创建好连接池的时候准备的连接数量
          最大连接数(maxPoolSize)：连接池中最多可以放多少个连接
          最大等待时间(checkoutTimeout)：连接池中没有连接时最长等待时间,单位毫秒
          最大空闲回收时间(maxIdleTime)：连接池中的空闲连接多久没有使用就会回收,单位毫秒
         -->
        <property name="initialPoolSize">5</property>
        <property name="maxPoolSize">10</property>
        <property name="checkoutTimeout">2000</property>
        <property name="maxIdleTime">1000</property>
    </default-config>
</c3p0-config>
```

```java
C3P0实现类:ComboPooledDataSource
```

```java
public class C3P0Utils {
    private C3P0Utils() {
    }
    //创建连接池对象
    private static DataSource dataSource = null;

    static {
        try {
            dataSource = new ComboPooledDataSource();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //获取连接
    public static Connection getConnection() {
        Connection connection = null;
        try {
            //从连接池中获取连接对象
            connection = dataSource.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }

    //关闭资源
    public static void close(Connection connection, Statement statement, ResultSet resultSet) {
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        /**
         * 将连接对象归还连接池
         */
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

```

```java
public class Demo01C3P0 {
    @Test
    public void insert() throws Exception {
        //获取连接
        Connection connection = C3P0Utils.getConnection();
        //准备sql
        String sql = "insert into category (cname) values (?)";
        //获取执行平台
        PreparedStatement pst = connection.prepareStatement(sql);
        pst.setObject(1,"蔬菜");
        //执行sql
        pst.executeUpdate();
        //关闭资源
        C3P0Utils.close(connection,pst,null);
    }
}
```

> ```java
> 1.概述:xml -> 可扩展性标记语言 -> 可扩展(标签名可以自定义) 标记(文件中的内容都是标签形式)
> 2.标签:
> a.闭合标签:一个标签由开始标签和结束标签组成
>  <标签名>标签体</标签名>  
> b.自闭合标签
>  <标签名 />  
> 
> c.注意:标签体中可以嵌套标签,或者直接写文本也行  
> 
> 3.标签中有属性 -> key=value形式
> <标签名 属性名 = "值" 属性名 = "值"></标签名>
> <标签名 属性名 = "值" />    
> ```

## 2.连接池之Druid(德鲁伊)

```java
1.概述:是阿里巴巴开发的
2.导入jar包:
  druid-1.1.10.jar
3.编写配置文件:properties配置文件
  a.取名为:xxx.properties
  b.文件中的配置:
    driver=com.mysql.cj.jdbc.Driver 
    url=jdbc:mysql://localhost:3306/220227_java4
    username=root
    password=root
    initialSize=5
    maxActive=10
    maxWait=1000
        
4.怎么读取配置文件:
  DruidDataSourceFactory.createDataSource(properties集合)  
```

```java
public class DruidUtils {
    private DruidUtils() {
    }
    //创建连接池对象
    private static DataSource dataSource = null;
    static {
        try {
            Properties properties = new Properties();
            properties.load(DruidUtils.class.getClassLoader().getResourceAsStream("druid.properties"));
            dataSource = DruidDataSourceFactory.createDataSource(properties);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //获取连接
    public static Connection getConnection() {
        Connection connection = null;
        try {
            //从连接池中获取连接对象
            connection = dataSource.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }

    //关闭资源
    public static void close(Connection connection, Statement statement, ResultSet resultSet) {
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        /**
         * 将连接对象归还连接池
         */
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

```

```java
public class Demo01Druid {
    @Test
    public void insert() throws Exception {
        //获取连接
        Connection connection = DruidUtils.getConnection();
        //准备sql
        String sql = "insert into category (cname) values (?)";
        //获取执行平台
        PreparedStatement pst = connection.prepareStatement(sql);
        pst.setObject(1,"水果");
        //执行sql
        pst.executeUpdate();
        //关闭资源
        DruidUtils.close(connection,pst,null);
    }
}
```

# 第三章.DBUtils工具包

## 1.准备工作

<img src="D:/data/JAVA/Database/day04笔记/img/1739759928667.png" alt="1739759928667" style="zoom:80%;" />

## 2.DBUtils的介绍

```java
1.概述:DBUtils是简化jdbc开发步骤的工具包
2.三大核心对象:
  a.QueryRunner:执行sql
  b.ResultSetHandler:处理结果集
  c.DButils:关闭资源,事务处理
```

## 3.QueryRunner

### 3.1.空参的QueryRunner的介绍以及使用

```java
1.构造:
  QueryRunner()
2.特点:
  a.我们需要自己维护连接对象
  b.支持占位符?
3.方法:
  int update(Connection conn, String sql, Object... params)->针对于增删改操作
             conn:连接对象
             sql:sql语句
             params:自动为sql中的?赋值 -> 直接传递给?赋予的值->传递的第一个值就自动找第一个?,以此类推    
  query(Connection conn, String sql, ResultSetHandler<T> rsh, Object... params)->针对于查询  
             conn:连接对象
             sql:sql语句
             rsh:处理结果集的方式,传递哪个实现类对象,就会自动按照哪个实现类对象处理结果集
             params:自动为sql中的?赋值 -> 直接传递给?赋予的值->传递的第一个值就自动找第一个?,以此类推    
```

```java
 public class Demo01DBUtils {
    @Test
    public void insert()throws Exception{
        QueryRunner qr = new QueryRunner();
        //1.获取连接对象
        Connection conn = DruidUtils.getConnection();
        //2.准备sql
        String sql = "insert into category(cname) values (?)";
        //3.执行sql
        qr.update(conn,sql,"箱包");
        //4.关闭资源
        DruidUtils.close(conn,null,null);
    }

    @Test
    public void delete()throws Exception{
        QueryRunner qr = new QueryRunner();
        //1.获取连接对象
        Connection conn = DruidUtils.getConnection();
        //2.准备sql
        String sql = "delete from category where cid = ?";
        //3.执行sql
        qr.update(conn,sql,1);
        //4.关闭资源
        DruidUtils.close(conn,null,null);

    }

    @Test
    public void update()throws Exception{
        QueryRunner qr = new QueryRunner();
        //1.获取连接对象
        Connection conn = DruidUtils.getConnection();
        //2.准备sql
        String sql = "update category set cname = ? where cid = ?";
        //3.执行sql
        qr.update(conn,sql,"手机",2);
        //4.关闭资源
        DruidUtils.close(conn,null,null);

    }
}
```

### 3.2.有参QueryRunner的介绍以及使用

```java
1.构造:
  QueryRunner(DataSource ds)
2.特点:
  a.我们不需要自己维护连接对象
  b.支持占位符?
3.方法:
  int update(String sql, Object... params)->针对于增删改操作
             sql:sql语句
             params:自动为sql中的?赋值 -> 直接传递给?赋予的值->传递的第一个值就自动找第一个?,以此类推    
  query(String sql, ResultSetHandler<T> rsh, Object... params)->针对于查询  
             sql:sql语句
             rsh:处理结果集的方式,传递哪个实现类对象,就会自动按照哪个实现类对象处理结果集
             params:自动为sql中的?赋值 -> 直接传递给?赋予的值->传递的第一个值就自动找第一个?,以此类推  
```

```java
public class DruidUtils {
    private DruidUtils() {
    }
    //创建连接池对象
    private static DataSource dataSource = null;
    static {
        try {
            Properties properties = new Properties();
            properties.load(DruidUtils.class.getClassLoader().getResourceAsStream("druid.properties"));
            dataSource = DruidDataSourceFactory.createDataSource(properties);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     *新加的方法,返回工具类中创建好的DataSource连接池对象,给有参的QueryRunner用
     */
    public static DataSource getDataSource() {
        return dataSource;
    }

    //获取连接
    public static Connection getConnection() {
        Connection connection = null;
        try {
            //从连接池中获取连接对象
            connection = dataSource.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }

    //关闭资源
    public static void close(Connection connection, Statement statement, ResultSet resultSet) {
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        /**
         * 将连接对象归还连接池
         */
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

```

```java
    @Test
    public void insert()throws Exception{
        QueryRunner qr = new QueryRunner(DruidUtils.getDataSource());
        //2.准备sql
        String sql = "insert into category(cname) values (?)";
        //3.执行sql
        qr.update(sql,"飞机");
    }
```

```java
// 情况 A：传 DataSource → QueryRunner 自动管理连接
QueryRunner qr = new QueryRunner(dataSource);
qr.update(sql, "飞机"); // 自动开/关 connection

// 情况 B：传 Connection → QueryRunner 不会关闭 connection！
Connection conn = dataSource.getConnection();
QueryRunner qr = new QueryRunner();
qr.update(conn, sql, "飞机"); // ❗️connection 需要你手动关闭！
```



## 4.ResultSetHandler结果集

### 4.1.BeanHandler<T>

```java
1.作用:将查询出来的结果集中的第一行数据封装成javabean对象
2.方法:
  query(String sql, ResultSetHandler<T> rsh, Object... params)>有参QueryRunner时使用
  query(Connection conn, String sql, ResultSetHandler<T> rsh, Object... params)->空参QueryRunner时使用
3.构造:
  BeanHandler(Class type)
  传递的class对象其实就是我们想要封装的javabean类的class对象
  想将查询出来的数据封装成哪个javabean对象,就写哪个javabean的class对象
4.怎么理解:
  将查询出来的数据为javabean中的成员变量赋值
```

```java
    @Test
    public void beanHandler()throws Exception{
        QueryRunner qr = new QueryRunner(DruidUtils.getDataSource());
        String sql = "select * from category where cid = ?";
        Category category = qr.query(sql, new BeanHandler<Category>(Category.class),3);
        System.out.println(category);
    }
```

### 4.2.BeanListHandler<T>

```java
1.作用:将查询出来的结果每一条数据都封装成一个一个的javabean对象,将这些javabean对象放到List集合中
2.构造:
  BeanListHandler(Class type)
  传递的class对象其实就是我们想要封装的javabean类的class对象
  想将查询出来的数据封装成哪个javabean对象,就写哪个javabean的class对象
      
3.怎么理解:
  将查询出来的多条数据封装成多个javabean对象,将多个javabean对象放到List集合中
```

```java
    @Test
    public void beanListHandler()throws Exception{
        QueryRunner qr = new QueryRunner(DruidUtils.getDataSource());
        String sql = "select * from category";
        List<Category> list = qr.query(sql, new BeanListHandler<Category>(Category.class));
        for (Category category : list) {
            System.out.println(category);
        }
    }
```

### 4.3.ScalarHandler

```java
1.作用:主要是处理单值的查询结果的,执行的select语句,结果集只有1个
2.构造:
  ScalarHandler(int columnIndex)->不常用->指定第几列
  ScalarHandler(String columnName)->不常用->指定列名
  ScalarHandler()->常用 -> 默认代表查询结果的第一行第一列数据
3.注意:
  ScalarHandler和聚合函数使用更有意义
```

```java
    @Test
    public void scalarHandler()throws Exception{
        QueryRunner qr = new QueryRunner(DruidUtils.getDataSource());
        //String sql = "select * from category";
        String sql = "select count(*) from category";
        Object o = qr.query(sql, new ScalarHandler<>());
        System.out.println(o);
    }
```

### 4.4.ColumnListHandler

```java
1.作用:将查询出来的结果中的某一列数据,存储到List集合中
2.构造:
  ColumnListHandler(int columnIndex)->指定第几列
  ColumnListHandler(String columnName)->指定列名
  ColumnListHandler()-> 默认显示查询结果中的第一列数据
3.注意:
 ColumnListHandler可以指定泛型类型,如果不指定,返回的List泛型就是Object类型,可以不指定泛型
```

```java
    @Test
    public void columnListHandler()throws Exception{
        QueryRunner qr = new QueryRunner(DruidUtils.getDataSource());
        String sql = "select * from category";
        List<Integer> list = qr.query(sql, new ColumnListHandler<Integer>("cid"));
        System.out.println(list);
    }
```

# 第四章.事务

## 1.事务

### 1.1.事务_转账分析图

<img src="D:/data/JAVA/Database/day04笔记/img/1739773719969.png" alt="1739773719969" style="zoom:80%;" />

不允许发生上面一条执行成功，下面一条执行失败的情况。必须二者同时成功或失败。==》事务

```mysql
CREATE TABLE account(
  `name` VARCHAR(10),
  money INT
);
```

### 1.2.实现转账(不加事务)

```java
public class Demo04Transfer {
    public static void main(String[] args)throws Exception {
        //1.创建QueryRunner对象
        QueryRunner qr = new QueryRunner();
        //2.获取连接
        Connection conn = DruidUtils.getConnection();
        //3.准备sql
        String outMoney = "update account set money = money-? where name = ?";
        String inMoney = "update account set money = money+? where name = ?";
        //4.执行sql
        qr.update(conn,outMoney,1000,"taoge");

        //System.out.println(1/0);

        qr.update(conn,inMoney,1000,"yixing");
        //5.关闭资源
        DruidUtils.close(conn,null,null);
    }
}
```

### 1.3.事务的介绍

```java
1.事务:是用来管理一组操作的(一组操作包含了多条sql语句),使其要么全部执行成功,要么全部执行失败,默认情况下,mysql自带事务管理,只不过自带的事务一次只能管理一条sql语句;如果我们想要管理多条sql语句,我们就必须要先将mysql自带的事务关闭,开启手动事务,手动管理
2.事务怎么管理一组操作的:说白了就是调用三个方法 -> Connection中的方法
  a.setAutoCommit(boolean autoCommit)->当参数为false,证明关闭mysql自带事务,自动开启手动事务
  b.void commit() -> 提交事务 -> 事务一旦提交,数据将永久保存,不能自动回到原来的数据了
  c.void rollback() -> 回滚事务 -> 数据将恢复到原来的样子 -> 前提是事务没有提交
```

==注意:想让以上三个方法成功管理一组操作,需要三个方法用同一条Connection对象调用== 

### 1.4.DBUtils实现转账(添加事务)

```java
public class Demo05Transfer2 {
    public static void main(String[] args) {
        //1.创建QueryRunner对象
        QueryRunner qr = new QueryRunner();
        //2.获取连接
        Connection conn = DruidUtils.getConnection();
        try {

            //关闭mysql自带事务,开启手动事务
            conn.setAutoCommit(false);
            //3.准备sql
            String outMoney = "update account set money = money-? where name = ?";
            String inMoney = "update account set money = money+? where name = ?";
            //4.执行sql
            qr.update(conn, outMoney, 1000, "taoge");

            //System.out.println(1/0);

            qr.update(conn, inMoney, 1000, "yixing");

            //提交事务
            conn.commit();

            System.out.println("转账成功!");

        } catch (Exception e) {
            //回滚事务
            try {
                conn.rollback();
                System.out.println("转账失败");
            } catch (SQLException ex) {
               ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            //5.关闭资源
            DruidUtils.close(conn, null, null);
        }
    }
}
```

### 1.5.mysql中操作事务_了解

```mysql
#开启事务
BEGIN;

UPDATE account SET money = money-1000 WHERE `name` = 'taoge';
UPDATE account SET money = money+1000 WHERE `name` = 'yixing';

#提交事务
COMMIT;

#回滚事务
ROLLBACK;
```

### 1.6.分层思想介绍以及架构搭建

```java
1.三层架构:
  表现层(Controller): 接受请求,回响应
  业务层(Service) : 处理业务逻辑
  持久层(Dao): 和数据库打交道-> 写jdbc代码
```

```java
com.atguigu.controller -> 专门放接受请求,回响应相关类
com.atguigu.service -> 专门放处理业务相关类
com.atguigu.dao -> 专门放和数据库打交道的相关类
com.atguigu.utils -> 专门放工具类
com.atguigu.pojo(entity) -> 专门放javabean的
```

<img src="D:/data/JAVA/Database/day04笔记/img/1739775538142.png" alt="1739775538142" style="zoom:80%;" />

#### 1.6.1.转账_表现层实现

```java
public class AccountController {
    public static void main(String[] args) {
        //1.创建Scanner对象
        Scanner sc = new Scanner(System.in);
        //2.键盘录入出钱人姓名,收钱人姓名,转账金额
        System.out.println("请您输入出钱人姓名:");
        String outName = sc.next();
        System.out.println("请您输入收钱人姓名:");
        String inName = sc.next();
        System.out.println("请您输入转账金额:");
        int money = sc.nextInt();
        //3.将录入的三个数据传递给service层
        AccountService accountService = new AccountService();
        accountService.transfer(outName,inName,money);
    }
}
```

#### 1.6.2.转账_service层实现

```java
public class AccountService {
    /**
     * @param outName 出钱人姓名
     * @param inName  收钱人姓名
     * @param money   转账金额
     */
    public void transfer(String outName, String inName, int money) {
        //1.创建dao层对象
        AccountDao accountDao = new AccountDao();

        //获取连接对象,操作事务
        Connection conn = DruidUtils.getConnection();

        try {
            //开启事务
            conn.setAutoCommit(false);

            //2.调用dao层方法进行减钱
            accountDao.outMoney(conn,outName, money);

            System.out.println(1 / 0);

            //3.调用dao层方法进行加钱
            accountDao.inMoney(conn,inName, money);

            System.out.println("转账成功");

            //提交事务
            conn.commit();

        } catch (Exception e) {
            //回滚事务
            try {
                conn.rollback();
                System.out.println("转账失败");
            } catch (SQLException ex) {
                ex.printStackTrace();
            }

            e.printStackTrace();
        }finally {
            DruidUtils.close(conn, null, null);
        }
    }
}
```

#### 1.6.3.转账_dao层实现

```java
public class AccountDao {
    /**
     * 减钱
     * @param outName  出钱人姓名
     * @param money    转账金额
     */
    public void outMoney(Connection conn,String outName, int money) throws SQLException {
        QueryRunner qr = new QueryRunner();
        String sql = "update account set money = money - ? where name = ?";
        qr.update(conn, sql, money, outName);

    }

    /**
     * 加钱
     * @param inName 收钱人姓名
     * @param money 转账金额
     */
    public void inMoney(Connection conn,String inName, int money) throws SQLException {
        QueryRunner qr = new QueryRunner();
        String sql = "update account set money = money + ? where name = ?";
        qr.update(conn, sql, money, inName);
    }
}
```

>    问题1:我们为啥要用三层架构写代码?
>
>    ​            a.解耦
>
>    ​            b.自己类干自己该干的事儿:controller就干接请求回响应的事儿,service就干处理业务逻辑的事儿,dao就干和数据库相关的事儿 -> 好维护
>
>    问题2:获取连接对象是Service应该干的吗? 不是,获取连接的活儿应该是dao干
>
>    问题3: 如果获取连接的代码不在service干,那么怎么将连接对象传递给dao层?不将连接传递给dao层那么怎么保证多个操作用的是同一条连接对象,无法保证多个操作使用同一条连接,事务怎么生效?
>
>    
>
>    问题解决:
>
>    a.获取连接,事务操作应该直接从service抽离出来,单独形成一个工具类
>
>    b.还要保证service和dao层使用的连接是同一条

## 2.ThreadLocal

### 2.1.ThreadLocal基本使用和原理

```java
1.概述:容器
2.创建:
  ThreadLocal<E> 对象名 = new ThreadLocal<>()
3.方法:
  set(数据): 存数据
  get():取数据
  remove():清空ThreadLocal
      
4.注意:
  a.一次只能存储一个数据
  b.在一个线程中往ThreadLocal中存储数据,在其他线程中获取不到
  c.在同一个线程中往TheadLocal中存储的数据,在此线程的其他位置都能共享     
  d.如果往ThreadLocal中存储数据,当前线程会和值直接绑死,只能在当前线程中获取,其他线程中获取不到
```

```java
public class Test01 {
    public static void main(String[] args) {
        ThreadLocal<String> tl = new ThreadLocal<>();
        tl.set("abc");
        String s = tl.get();
        System.out.println("s = " + s);

        new Thread(()->{
            System.out.println(tl.get());
        }).start();
    }
}

```

<img src="D:/data/JAVA/Database/day04笔记/img/1739781013508.png" alt="1739781013508" style="zoom:80%;" />

### 2.2.连接对象管理类(小秘书)

```java
public class ConnectionManager {
    //创建ThreadLocal对象
    private static ThreadLocal<Connection> threadLocal = new ThreadLocal<>();

    /**
     * 从连接池中获取连接转存到ThreadLocal中
     * @return
     */
    public static Connection getConn() {
        //先从ThreadLocal中获取连接
        Connection connection = threadLocal.get();
        //判断从TheadLocal中获取的Connection是否为null
        if (connection == null) {
            //如果Connection为null,证明之前没有往ThreadLocal中存过,没有存过就要从连接池中获取
            connection = DruidUtils.getConnection();
            //将连接转存到ThreadLocal中
            threadLocal.set(connection);
        }
        return connection;
    }

    /**
     * 开启事务
     */
    public static void begin() throws SQLException {
        //获取连接
        Connection connection = getConn();
        connection.setAutoCommit(false);
    }

    /**
     * 提交事务
     */
    public static void commit() throws SQLException {
        //获取连接
        Connection connection = getConn();
        connection.commit();
    }

    /**
     * 回滚事务
     */
    public static void rollback() throws SQLException {
        //获取连接
        Connection connection = getConn();
        connection.rollback();
    }

    /**
     * 释放资源
     */
    public static void close() {
        //获取连接
        Connection connection = getConn();
        //释放资源
        DruidUtils.close(connection, null, null);
        //从ThreadLocal中移除连接
        threadLocal.remove();
    }
}
```

```java
public class AccountService {
    /**
     * @param outName 出钱人姓名
     * @param inName  收钱人姓名
     * @param money   转账金额
     */
    public void transfer(String outName, String inName, int money) {
        //1.创建dao层对象
        AccountDao accountDao = new AccountDao();

        try {
            //开启事务
            ConnectionManager.begin();

            //2.调用dao层方法进行减钱
            accountDao.outMoney(outName, money);

            System.out.println(1 / 0);

            //3.调用dao层方法进行加钱
            accountDao.inMoney(inName, money);

            System.out.println("转账成功");

            //提交事务
            ConnectionManager.commit();

        } catch (Exception e) {
            //回滚事务
            try {
                ConnectionManager.rollback();
                System.out.println("转账失败");
            } catch (SQLException ex) {
                ex.printStackTrace();
            }

            e.printStackTrace();
        }finally {
            ConnectionManager.close();
        }
    }
}

```

```java
public class AccountDao {

    /**
     * 减钱
     * @param outName  出钱人姓名
     * @param money    转账金额
     */
    public void outMoney(String outName, int money) throws SQLException {
        QueryRunner qr = new QueryRunner();
        String sql = "update account set money = money - ? where name = ?";
        qr.update(ConnectionManager.getConn(), sql, money, outName);

    }

    /**
     * 加钱
     * @param inName 收钱人姓名
     * @param money 转账金额
     */
    public void inMoney(String inName, int money) throws SQLException {
        QueryRunner qr = new QueryRunner();
        String sql = "update account set money = money + ? where name = ?";
        qr.update(ConnectionManager.getConn(), sql, money, inName);
    }
}

```

<img src="D:/data/JAVA/Database/day04笔记/img/1739782089059.png" alt="1739782089059" style="zoom:80%;" />

## 3.事务的特性以及隔离级别

###  3.1.事务特性：ACID

- 原子性（Atomicity）原子性是指事务是一个不可分割的工作单位，事务中的操作要么都发生，要么都不发生。 

- 一致性（Consistency）事务前后数据的完整性必须保持一致。

- 隔离性（Isolation）事务的隔离性是指多个用户并发访问数据库时，一个用户的事务不能被其它用户的事务所干扰，多个并发事务之间数据要相互隔离,正常情况下数据库是做不到这一点的,可以设置隔离级别,但是效率会非常低。
- 持久性（Durability）持久性是指一个事务一旦被提交，它对数据库中数据的改变就是永久性的，接下来即使数据库发生故障也不应该对其有任何影响。

### 3.2 并发访问问题

如果不考虑隔离性，事务存在3中并发访问问题。

1. 脏读：一个事务读到了另一个事务未提交的数据.

2. 不可重复读：一个事务读到了另一个事务已经提交(update)的数据。引发另一个事务，在事务中的多次查询结果不一致。
3. 虚读 /幻读：一个事务读到了另一个事务已经提交(insert)的数据。导致另一个事务，在事务中多次查询的结果不一致。

### 3.3 隔离级别：解决问题

- 数据库规范规定了4种隔离级别，分别用于描述两个事务并发的所有情况。

1. **read uncommitted** 读未提交，一个事务读到另一个事务没有提交的数据。

   a)存在：3个问题（脏读、不可重复读、虚读）。

   b)解决：0个问题

2. **read committed** 读已提交，一个事务读到另一个事务已经提交的数据。

   a)存在：2个问题（不可重复读、虚读）。

   b)解决：1个问题（脏读）

3. **repeatable read**:可重复读，在一个事务中读到的数据始终保持一致，无论另一个事务是否提交。

   a)存在：1个问题（虚读）。

   b)解决：2个问题（脏读、不可重复读）

   4.**serializable 串行化**，同时只能执行一个事务，相当于事务中的单线程。

a)存在：0个问题。

b)解决：3个问题（脏读、不可重复读、虚读）

- 安全和性能对比
  - 安全性：`serializable > repeatable read > read committed > read uncommitted`
  - 性能 ： `serializable < repeatable read < read committed < read uncommitted`
- 常见数据库的默认隔离级别：
  - MySql：`repeatable read`
  - Oracle：`read committed`

### 3.4 演示

- 隔离级别演示参考：资料/隔离级别操作过程.doc【增强内容,了解】

- 查询数据库的隔离级别

```mysql
show variables like '%isolation%';
或
select @@tx_isolation;
```



- 设置数据库的隔离级别
  - `set session transactionisolation level` 级别字符串
  - 级别字符串：`readuncommitted`、`read committed`、`repeatable read`、`serializable`
  - 例如：`set session transaction isolation level read uncommitted;`

- 读未提交：readuncommitted
  - A窗口设置隔离级别
    - AB同时开始事务
    - A 查询
    - B 更新，但不提交
    - A 再查询？-- 查询到了未提交的数据
    - B 回滚
    - A 再查询？-- 查询到事务开始前数据

- 读已提交：read committed
  - A窗口设置隔离级别
    - AB同时开启事务
    - A查询
    - B更新、但不提交
    - A再查询？--数据不变，解决问题【脏读】
    - B提交
    - A再查询？--数据改变，存在问题【不可重复读】
- 可重复读：repeatable read
  - A窗口设置隔离级别
    - AB 同时开启事务
    - A查询
    - B更新， 但不提交
    - A再查询？--数据不变，解决问题【脏读】
    - B提交
    - A再查询？--数据不变，解决问题【不可重复读】
    - A提交或回滚
    - A再查询？--数据改变，另一个事务
- 串行化：serializable
  - A窗口设置隔离级别
  - AB同时开启事务
  - A查询
    - B更新？--等待(如果A没有进一步操作，B将等待超时)
    - A回滚
    - B 窗口？--等待结束，可以进行操作



```java
- 原子性（Atomicity）原子性是指事务是一个不可分割的工作单位，事务中的操作要么都发生，要么都不发生。 
- 一致性（Consistency）事务前后数据的完整性必须保持一致。
- 隔离性（Isolation）事务的隔离性是指多个用户并发访问数据库时，一个用户的事务不能被其它用户的事务所干扰，多个并发事务之间数据要相互隔离,正常情况下数据库是做不到这一点的,可以设置隔离级别,但是隔离级别越高,效率会非常低。
- 持久性（Durability）持久性是指一个事务一旦被提交，它对数据库中数据的改变就是永久性的，接下来即使数据库发生故障也不应该对其有任何影响。
```

```java
如果不考虑隔离性，事务存在3中并发访问问题。(如果隔离级别低,事务跟事务之间有可能互相影响)

1. 脏读：一个事务读到了另一个事务未提交的数据.
2. 不可重复读：一个事务读到了另一个事务已经提交(update)的数据。引发另一个事务，在事务中的多次查询结果不一致。
3. 虚读 /幻读：一个事务读到了另一个事务已经提交(insert)的数据。导致另一个事务，在事务中多次查询的结果不一致。
```

```java
总结:
  我们最理想的状态是:一个事务和其他事务互不影响
  
  但是如果不考虑隔离级别的话,就会出现多个事务之间互相影响
  
  而事务互相影响的表现方式为:
    脏读
    不可重复读
    虚读/幻读
```


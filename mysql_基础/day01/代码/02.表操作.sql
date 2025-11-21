#创建表
CREATE TABLE `user`(
   `uid` INT,
   `username` VARCHAR(10),
   `password` VARCHAR(15)
);

#查看所有表
SHOW TABLES;

-- 查看表结构
DESC person;

-- 删除表
DROP TABLE `person`;

/*
 ALTER TABLE 表名 ADD 列名 类型(长度) [约束];
 作用：添加列. 
*/
ALTER TABLE `user` ADD `gender` VARCHAR(2);

/*
  alter table 表名 modify 列名 类型(长度) [约束];
  作用：修改列的类型,长度及约束.
*/
ALTER TABLE `user` MODIFY `gender` INT;

/*
  alter table 表名 change 旧列名 新列名 类型(长度) [约束]; 
  作用：修改列名.
*/
ALTER TABLE `user` CHANGE `gender` `sex` VARCHAR(10);

/*
   alter table 表名 drop 列名; 
   作用：修改表_删除列.
*/
ALTER TABLE `user` DROP `sex`;

/*
   rename table 表名 to 新表名; 
   作用：修改表名
*/
RENAME TABLE `user` TO `person`;
RENAME TABLE `person` TO `user`;



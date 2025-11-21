-- 统计product的总记录数
SELECT COUNT(*) FROM product;


-- 查询所有商品的价格总和
SELECT SUM(price) FROM product;


-- 查询pid为1,3,7 商品的价格平均值
SELECT AVG(price) FROM product WHERE pid IN(1,3,7);


-- 查询商品的最高价格以及最低价格
SELECT MIN(price) `minprice`,MAX(price) `maxprice` FROM product;

#==============================
CREATE TABLE person(
  pid INT,
  pname VARCHAR(10)
);

SELECT COUNT(*) FROM person;  # 不管有没有null,将所有数据都统计出来

SELECT COUNT(pid) FROM person; # 如果指定的列有NULL,不记录
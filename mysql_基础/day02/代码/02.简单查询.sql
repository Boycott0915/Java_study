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






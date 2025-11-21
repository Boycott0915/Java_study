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







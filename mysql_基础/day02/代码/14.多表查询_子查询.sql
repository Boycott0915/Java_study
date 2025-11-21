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
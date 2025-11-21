-- 查询化妆品的所有商品信息
SELECT * FROM category c,products p WHERE c.`cid` = p.`category_id` AND cname = '化妆品';

-- 先将化妆品从category中查询出来
SELECT * FROM category WHERE cname = '化妆品';

SELECT * FROM (SELECT * FROM category WHERE cname = '化妆品') c,products p WHERE c.`cid` = p.`category_id`;

-- 查询所有化妆品和家电的商品信息

-- 先查询家电和化妆品
SELECT * FROM category WHERE cname IN('化妆品','家电');

SELECT * FROM (SELECT * FROM category WHERE cname IN('化妆品','家电')) c,products p WHERE c.`cid` = p.`category_id`;

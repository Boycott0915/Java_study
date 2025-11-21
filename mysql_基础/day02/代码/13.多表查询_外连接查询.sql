-- 查询所有的商品信息 左外连接
SELECT * FROM category c LEFT JOIN products p ON c.`cid` = p.`category_id`;

-- 查询所有的商品信息 右外连接
SELECT * FROM category c RIGHT JOIN products p ON c.`cid` = p.`category_id`;

-- 查询所有的商品信息内连接
SELECT * FROM category c,products p WHERE c.`cid` = p.`category_id`;


-- 全外连接

SELECT * FROM category c LEFT JOIN products p ON c.`cid` = p.`category_id`

UNION

SELECT * FROM category c RIGHT JOIN products p ON c.`cid` = p.`category_id`;


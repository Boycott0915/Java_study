-- 查询所有商品的具体信息
SELECT * FROM category,products;

SELECT * FROM category,products WHERE category.cid = products.category_id;

-- 给表取别名
SELECT * FROM category c,products p WHERE c.cid = p.category_id;
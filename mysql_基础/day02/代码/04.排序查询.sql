-- 使用价格排序(降序)
SELECT * FROM product ORDER BY price DESC;


-- 使用价格排序(升序)
SELECT * FROM product ORDER BY price ASC;


-- 显示商品的价格(去重复),并排序(降序)
SELECT DISTINCT(price) FROM product ORDER BY price DESC;
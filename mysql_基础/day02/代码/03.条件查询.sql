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
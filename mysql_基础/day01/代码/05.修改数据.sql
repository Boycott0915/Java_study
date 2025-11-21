UPDATE category SET cname = '手机';

-- 将表中的水杯改成显卡
UPDATE category SET cname = '显卡' WHERE cname = '水杯';

-- 将cid为4的cdesc改成涤纶
UPDATE category SET cdesc = '涤纶' WHERE cid = 4;

-- 将cid不等于1的cname都改成平板
UPDATE category SET cname = '平板' WHERE cid !=1;
DROP TABLE category;

CREATE TABLE category(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  cname VARCHAR(10),
  cdesc VARCHAR(10)
);

INSERT INTO category (cid,cname,cdesc) VALUES (NULL,'蔬菜','纯野生');

INSERT INTO category VALUES (NULL,'水果','偷的');

INSERT INTO category VALUES (NULL,'海鲜','核污染的');

DELETE FROM category WHERE cid = 3; #删除之后不会重新编号

#摧毁表结构
TRUNCATE TABLE category;
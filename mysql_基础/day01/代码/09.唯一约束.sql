DROP TABLE category;
#非空约束

CREATE TABLE category(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  cname VARCHAR(10) UNIQUE,
  cdesc VARCHAR(10)
);

INSERT INTO category (cid,cname,cdesc) VALUES (NULL,'蔬菜','纯野生');

#INSERT INTO category (cid,cname,cdesc) VALUES (NULL,'蔬菜','扣大棚');

INSERT INTO category (cid,cname,cdesc) VALUES (NULL,'蔬菜1','扣大棚');
DROP TABLE category;
#非空约束

CREATE TABLE category(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  cname VARCHAR(10) NOT NULL,
  cdesc VARCHAR(10)
);

INSERT INTO category (cid,cname,cdesc) VALUES (NULL,'蔬菜','纯野生');

#相当于String s = null
-- INSERT INTO category (cid,cname,cdesc) VALUES (NULL,NULL,'纯野生');

#相当于String s = "null"
INSERT INTO category (cid,cname,cdesc) VALUES (NULL,'null','纯野生');

#相当于String s = ""
INSERT INTO category (cid,cname,cdesc) VALUES (NULL,'','纯野生');
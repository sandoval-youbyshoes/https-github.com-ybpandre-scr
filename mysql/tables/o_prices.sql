CREATE TABLE `o_prices` (
  `company_id` int(11) NOT NULL,
  `company_code` text,
  `mc` char(30) NOT NULL,
  `price` double DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`mc`,`company_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `o_stocks_on_hand` (
  `company_id` int(11) NOT NULL,
  `sku` char(30) NOT NULL,
  `qty` decimal(32,0) DEFAULT NULL,
  PRIMARY KEY (`company_id`,`sku`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
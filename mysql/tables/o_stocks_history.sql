CREATE TABLE `o_stocks_history` (
  `company_id` int(11) NOT NULL,
  `company_code` char(4) DEFAULT NULL,
  `location_id` int(11) NOT NULL,
  `location_name` char(30) DEFAULT NULL,
  `sku` char(30) NOT NULL,
  `qty` int(11) DEFAULT NULL,
  `day` date NOT NULL,
  PRIMARY KEY (`company_id`,`location_id`,`sku`,`day`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

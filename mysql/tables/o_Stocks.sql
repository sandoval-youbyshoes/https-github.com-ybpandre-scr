CREATE TABLE `o_stocks` (
  `company_id` int(11) NOT NULL,
  `company_code` char(4) DEFAULT NULL,
  `location_id` int(11) NOT NULL,
  `location_name` char(30) DEFAULT NULL,
  `sku` char(30) NOT NULL,
  `qty` int(11) DEFAULT NULL,
  `first_move` datetime DEFAULT NULL,
  `last_move` datetime DEFAULT NULL,
  PRIMARY KEY (`company_id`,`location_id`,`sku`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

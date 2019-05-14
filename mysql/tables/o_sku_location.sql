CREATE TABLE `o_sku_location` (
  `company_id` int(11) NOT NULL,
  `sku` char(30) NOT NULL,
  `first_move` datetime DEFAULT NULL,
  PRIMARY KEY (`company_id`,`sku`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

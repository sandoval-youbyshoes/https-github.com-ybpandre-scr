CREATE TABLE `o_stocks_in_transit_purchase` (
  `company_id` int(11) NOT NULL,
  `sku` char(30) NOT NULL,
  `qty` int(11) DEFAULT NULL,
  PRIMARY KEY (`company_id`,`sku`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

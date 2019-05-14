CREATE TABLE `o_stock_days` (
  `company_id` int(11) NOT NULL,
  `sku` char(30) NOT NULL,
  `days` bigint(21) NOT NULL DEFAULT '0',
  PRIMARY KEY (`company_id`,`sku`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

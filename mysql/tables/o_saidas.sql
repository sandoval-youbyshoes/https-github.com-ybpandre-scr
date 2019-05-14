CREATE TABLE `o_saidas` (
  `origin_company_id` int(11) NOT NULL,
  `sku` char(30) NOT NULL,
  `qty` int(11) DEFAULT NULL,
  PRIMARY KEY (`origin_company_id`,`sku`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

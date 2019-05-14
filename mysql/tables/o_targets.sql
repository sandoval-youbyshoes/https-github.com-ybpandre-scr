CREATE TABLE `o_targets` (
  `company_id` int(11) NOT NULL,
  `company_code` text,
  `sku` char(30) NOT NULL,
  `qty` int(11) DEFAULT NULL,
  `create_date` text,
  `write_date` text,
  PRIMARY KEY (`sku`,`company_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

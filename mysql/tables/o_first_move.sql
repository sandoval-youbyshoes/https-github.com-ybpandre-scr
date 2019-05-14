CREATE TABLE `o_first_move` (
  `company_id` int(11) NOT NULL,
  `sku` varchar(30) NOT NULL,
  `first_move` text CHARACTER SET latin1,
  PRIMARY KEY (`company_id`,`sku`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

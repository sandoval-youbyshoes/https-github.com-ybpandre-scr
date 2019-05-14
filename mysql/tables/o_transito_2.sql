CREATE TABLE `o_transito_2` (
  `sku` char(30) NOT NULL,
  `quantidade` int(11) DEFAULT NULL,
  PRIMARY KEY (`sku`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

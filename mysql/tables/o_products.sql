CREATE TABLE `o_products` (
  `sku` char(30) NOT NULL,
  `id` int(11) DEFAULT NULL,
  `create_date` text,
  `write_date` text,
  `name` text,
  `ean13` text,
  `cost_price` double DEFAULT NULL,
  `collection` text,
  `footwear_kind` text,
  `product_class` text,
  `size` text,
  `champion` text,
  `markup` float DEFAULT NULL,
  `PrOrig` float DEFAULT NULL,
  `mc` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`sku`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

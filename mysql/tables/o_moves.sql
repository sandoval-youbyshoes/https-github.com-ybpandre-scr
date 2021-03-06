CREATE TABLE `o_moves` (
  `operation` text,
  `fiscal_category` text,
  `origin_company_id` int(11) DEFAULT NULL,
  `origin_company_code` text,
  `origin_location_id` int(11) DEFAULT NULL,
  `origin_location_name` text,
  `destination_company_id` int(11) DEFAULT NULL,
  `destination_company_code` text,
  `destination_location_id` int(11) DEFAULT NULL,
  `destination_location_name` text,
  `sku` char(30) NOT NULL,
  `product_qty` double DEFAULT NULL,
  `state` text,
  `date` varchar(30) DEFAULT NULL,
  `pos_order_name` varchar(100) DEFAULT NULL,
  `cancel` varchar(1) DEFAULT NULL,
  `payment_form` varchar(30) DEFAULT NULL,
  `price_unit` varchar(10) DEFAULT NULL,
  `discount` varchar(10) DEFAULT NULL,
  `price_subtotal` varchar(10) DEFAULT NULL,
  `client` varchar(30) DEFAULT NULL,
  KEY `moves_origin` (`origin_company_id`) USING BTREE,
  KEY `moves_destination` (`destination_company_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

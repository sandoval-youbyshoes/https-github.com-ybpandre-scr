CREATE TABLE `locais` (
  `LocalC` varchar(30) NOT NULL,
  `LocalM` varchar(45) NOT NULL,
  `company_id` int(11) NOT NULL,
  PRIMARY KEY (`company_id`) USING BTREE,
  KEY `idx_company_id` (`company_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

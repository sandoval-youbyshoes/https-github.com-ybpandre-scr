CREATE TABLE `o_champions` (
  `mc` varchar(14) DEFAULT NULL,
  `champion` char(1) CHARACTER SET latin1 DEFAULT NULL,
  `Count` tinyint(3) DEFAULT NULL,
  `first_date_on` varchar(10) DEFAULT NULL,
  `last_date_on` varchar(10) DEFAULT NULL,
  `first_date_off` varchar(10) DEFAULT NULL,
  `last_date_off` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

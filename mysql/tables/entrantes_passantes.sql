CREATE TABLE `entrantes_passantes` (
  `interval_start` datetime DEFAULT NULL,
  `interval_stop` datetime DEFAULT NULL,
  `local` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `camera` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `in` int(11) DEFAULT NULL,
  `out` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `chips_multimarketing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numero` varchar(15) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `observacao` varchar(500) DEFAULT NULL,
  `operadora` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

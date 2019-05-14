CREATE TABLE `o_payments` (
  `id` int(11) DEFAULT NULL,
  `pedido` varchar(45) DEFAULT NULL,
  `forma` varchar(30) DEFAULT NULL,
  `valor` float DEFAULT NULL,
  `data` date DEFAULT NULL,
  `hora` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

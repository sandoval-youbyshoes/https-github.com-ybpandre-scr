CREATE TABLE `tamanholojas` (
  `Loja` varchar(20) NOT NULL,
  `CapacidadeMax` int(11) DEFAULT NULL,
  `CapacidadeMin` int(11) DEFAULT NULL,
  PRIMARY KEY (`Loja`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

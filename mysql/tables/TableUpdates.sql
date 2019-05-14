CREATE TABLE `tableupdates` (
  `NomeTabela` varchar(99) NOT NULL,
  `LUpdate` datetime DEFAULT NULL,
  `User` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`NomeTabela`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

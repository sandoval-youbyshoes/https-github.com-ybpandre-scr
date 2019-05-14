CREATE TABLE `o_dias` (
  `dia` date NOT NULL,
  `calculated` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`dia`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

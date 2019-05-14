CREATE TABLE `paramsrelats` (
  `Param` varchar(20) NOT NULL,
  `Valor` varchar(800) NOT NULL,
  PRIMARY KEY (`Param`) USING BTREE,
  UNIQUE KEY `Param_UNIQUE` (`Param`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

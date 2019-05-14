CREATE TABLE `o_equivs` (
  `MCAtual` tinytext NOT NULL,
  `MCAntigo` tinytext NOT NULL,
  KEY `idx_o_equivs_MCAtual` (`MCAtual`(20)) USING BTREE,
  KEY `idx_o_equivs_MCantigo` (`MCAntigo`(20)) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

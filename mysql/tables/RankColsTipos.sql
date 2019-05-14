CREATE TABLE `rankcolstipos` (
  `MCRank` int(11) DEFAULT NULL,
  `Colecao` varchar(20) DEFAULT NULL,
  `TipoNovo` varchar(30) DEFAULT NULL,
  `ModeloCor` varchar(20) DEFAULT NULL,
  `VdasUn` int(11) DEFAULT NULL,
  `VendasFin` decimal(10,2) DEFAULT NULL,
  UNIQUE KEY `idx_RankColsTipos_MC` (`ModeloCor`) USING BTREE,
  KEY `idx_RankColsTipos_Tipo` (`TipoNovo`) USING BTREE,
  KEY `idx_RankColsTipos_Col` (`Colecao`) USING BTREE,
  KEY `idx_RankColsTipos_Rank` (`MCRank`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

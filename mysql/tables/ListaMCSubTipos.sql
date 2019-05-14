CREATE TABLE `listamcsubtipos` (
  `Modelo` varchar(20) NOT NULL,
  `Tipo` text,
  `SubtipoOrig` text,
  `SubSubtipo` text,
  `TamSalto` text,
  `Salto` text,
  `TipoNome` text,
  `SubTipo` varchar(99) GENERATED ALWAYS AS (if((`SubTipoOrig` = 'Scarpin'),concat('Scarpin Salto ',`Salto`),`SubTipoOrig`)) STORED,
  PRIMARY KEY (`Modelo`) USING BTREE,
  KEY `idx_ listamcsubtipos_tipo` (`Tipo`(20)) USING BTREE,
  KEY `idx_ listamcsubtipos_salto` (`Salto`(15)) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

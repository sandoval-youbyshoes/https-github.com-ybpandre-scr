CREATE TABLE `o_stock_history` (
  `nome_estoque` char(50) NOT NULL,
  `location_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `location_dest_id` int(11) DEFAULT NULL,
  `sku` char(30) NOT NULL,
  `qtde` int(11) NOT NULL,
  PRIMARY KEY (`nome_estoque`,`company_id`,`location_id`,`sku`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

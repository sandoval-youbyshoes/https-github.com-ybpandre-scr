CREATE TABLE `o_vendas` (
  `company_id` int(11) NOT NULL,
  `sku` char(30) NOT NULL,
  `unidades_vendidas_bruto` int(11) NOT NULL,
  `unidades_vendidas_liquido` int(11) NOT NULL,
  `valor_total_vendas_bruto` double NOT NULL,
  `valor_total_vendas_liquido` double NOT NULL,
  PRIMARY KEY (`company_id`,`sku`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

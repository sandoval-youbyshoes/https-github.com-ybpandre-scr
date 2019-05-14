ALTER ALGORITHM = UNDEFINED DEFINER = `TI` @`%` SQL SECURITY DEFINER VIEW `vendas` AS
select
  `m`.`Data` AS `Data`,
  `m`.`Hora` AS `Hora`,
  `m`.`Local` AS `Local`,
  `m`.`Ticket` AS `Pedido`,
  `m`.`SKU` AS `Recurso`,
  `m`.`Quantidade` AS `Quantidade`,
  `m`.`Total` AS `Valor`,
  `p`.`cost_price` AS `Custo`,
  if(
    (`m`.`Quantidade` = 0),
    0,
    if(
      (`m`.`Total` > 0.00),(
        (
          (`m`.`Total` - `p`.`cost_price`) - (`p`.`cost_price` * 0.03)
        ) - (`p`.`cost_price` * 0.06)
      ),
      `m`.`Total`
    )
  ) AS `Margem`,
  date_format(`m`.`Data`, '%Y/%m') AS `Mês`
from
  (
    `movimentos` `m`
    join `o_products` `p`
  )
where
  (
    (`m`.`Tipo` = 'V Adq Terc p Consumo')
    and (`m`.`SKU` = convert(`p`.`sku` using utf8))
  );
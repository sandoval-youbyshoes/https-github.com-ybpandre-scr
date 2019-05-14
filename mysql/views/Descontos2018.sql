ALTER ALGORITHM = UNDEFINED DEFINER = `TI` @`%` SQL SECURITY DEFINER VIEW `descontos2018` AS
select
  `m`.`Local` AS `Local`,
  `m`.`SKU` AS `SKU`,
  `m`.`Data` AS `Data`,
  `m`.`Hora` AS `Hora`,
  `m`.`Quantidade` AS `Quantidade`,
  `m`.`Valor` AS `Valor`,
  `m`.`TotalE` AS `TotalE`,
  `m`.`Ticket` AS `Ticket`,
  `m`.`CPFouCNPJ` AS `CPFouCNPJ`,
  `m`.`DataHora` AS `DataHora`,
  `m`.`Dia` AS `Dia`,
  `m`.`MC` AS `MC`,
  `m`.`Tam` AS `Tam`,
  `m`.`isCPF` AS `isCPF`,
  `m`.`CPFok` AS `CPFok`,
  `m`.`Total` AS `Total`,
  `c`.`tipo` AS `Tipo`,
  `c`.`colecao` AS `Colecao`,
  round(`c`.`PrecoOriginal`, 2) AS `PrecoOriginal`,
  if((`m`.`Valor` < (`c`.`PrecoOriginal` * 0.81)), 1, 0) AS `Descontado`,
  round(
    (
      round((1 - (`m`.`Valor` / `c`.`PrecoOriginal`)), 1) * 100
    ),
    0
  ) AS `Desconto`
from
  (
    `youhist`.`movimentos` `m`
    join `youhist`.`cadastro` `c` on((convert(`c`.`SKU` using utf8) = `m`.`SKU`))
  )
where
  (
    (`m`.`Tipo` = 'V Adq Terc p Consumo')
    and (`m`.`Dia` > '2017-12-01')
    and (`m`.`Quantidade` > 0)
    and (`c`.`tipo` <> 'Palmilhas')
    and (`c`.`tipo` <> 'meias')
    and (`c`.`tipo` <> 'Outros')
  );
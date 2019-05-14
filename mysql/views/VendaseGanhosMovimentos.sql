ALTER ALGORITHM = UNDEFINED DEFINER = `TI` @`%` SQL SECURITY DEFINER VIEW `vendaseganhosmovimentos30d` AS
select
  `m`.`LocalC` AS `LocalC`,
  any_value(`e`.`Local`) AS `Local`,
  `m`.`SKU` AS `SKU`,
  any_value(`m`.`ModeloCor`) AS `ModeloCor`,
  any_value(`e`.`Tipo`) AS `Tipo`,
  any_value(`e`.`COL`) AS `Colecao`,
  sum(`m`.`Quantidade`) AS `VendasLiqUn`,
  max(`e`.`UnidVendLiq`) AS `VendasLiqUnEval`,
  sum(`m`.`Total`) AS `VendasLiqValor`,
  min(`e`.`CustoUni`) AS `CustoUn`,
  count(distinct `m`.`Ticket`) AS `NumTickets`,
  sum(
    (
      `m`.`Total` - (`m`.`Quantidade` * `e`.`CustoUni`)
    )
  ) AS `Ganho`,
  round(
    (
      (
        (
          sum(
            (
              `m`.`Total` - (`m`.`Quantidade` * `e`.`CustoUni`)
            )
          ) / sum(`m`.`Quantidade`)
        ) * max(`e`.`VELVDUN`)
      ) * 30
    ),
    2
  ) AS `VelGanho`,
  round((max(`e`.`VELVDUN`) * 30), 2) AS `VelVenLiq`,
  max(`e`.`DCEADJ`) AS `DCEAju`,
  max(`e`.`DIASATIVO`) AS `DiasAtivo`,
  max(
    if(
      (
        (`m`.`Total` / `m`.`Quantidade`) < (`e`.`PrecoOriginal` * 0.80)
      ),
      1,
      0
    )
  ) AS `Descontado`,
  max(
    round(
      (
        round(
          (
            1 - (
              (`m`.`Total` / `m`.`Quantidade`) / `e`.`PrecoOriginal`
            )
          ),
          1
        ) * 100
      ),
      0
    )
  ) AS `Desconto`
from
  (
    `movimentoslocalc` `m`
    left join `new_eval` `e` on(
      (
        (`m`.`SKU` = convert(`e`.`SKU` using utf8))
        and (`m`.`LocalC` = `e`.`LOCALC`)
      )
    )
  )
where
  (
    (`m`.`Tipo` = 'V Adq Terc p Consumo')
    and (`m`.`Dia` >= (now() - interval 1 month))
  )
group by
  `m`.`SKU`,
  `m`.`LocalC`;
ALTER ALGORITHM = UNDEFINED DEFINER = `TI` @`%` SQL SECURITY DEFINER VIEW `acompanhamentodiario` AS
select
  `vendas`.`Local` AS `local`,
  `vendas`.`Data` AS `data`,
  min(`vendas`.`Mês`) AS `mes`,
  week(`vendas`.`Data`, 3) AS `Semana`,
  min(`vendas`.`Hora`) AS `MinHoraVd`,
  max(`vendas`.`Hora`) AS `MaxHoraVd`,
  count(distinct `vendas`.`Pedido`) AS `NumTickets`,
  sum(`vendas`.`Quantidade`) AS `qtdLiq`,
  sum(
    if(
      (`vendas`.`Quantidade` > 0),
      `vendas`.`Quantidade`,
      0
    )
  ) AS `qtdBruta`,
  round(
    (
      (
        1 - (
          sum(`vendas`.`Quantidade`) / sum(
            if(
              (`vendas`.`Quantidade` > 0),
              `vendas`.`Quantidade`,
              0
            )
          )
        )
      ) * 100
    ),
    0
  ) AS `PercTrDev`,
  round(
    if(
      (count(distinct `vendas`.`Pedido`) > 0),(
        sum(`vendas`.`Quantidade`) / count(distinct `vendas`.`Pedido`)
      ),
      0
    ),
    1
  ) AS `ParesPorTicket`,
  sum(`vendas`.`Valor`) AS `valorLiq`,
  round(
    if(
      (count(distinct `vendas`.`Pedido`) > 0),(
        sum(`vendas`.`Valor`) / count(distinct `vendas`.`Pedido`)
      ),
      0
    ),
    2
  ) AS `TicketMedio`,
  round(sum(`vendas`.`Margem`), 2) AS `margem`,
  count(distinct `vendas`.`Recurso`) AS `NumSKUs`,
  count(
    distinct substring_index(`vendas`.`Recurso`, '-', 1)
  ) AS `NumMCs`,
  min(`ent`.`entrantes`) AS `entrantes`,
  min(`pass`.`passantes`) AS `passantes`,(
    count(distinct `pass`.`passantes`) / min(`ent`.`entrantes`)
  ) AS `Atracao`,(
    count(distinct `vendas`.`Pedido`) / min(`ent`.`entrantes`)
  ) AS `Conversao`
from
  (
    (
      `youhist`.`vendas`
      left join (
        select
          `youhist`.`entrantes_passantes`.`local` AS `local`,
          date_format(
            `youhist`.`entrantes_passantes`.`interval_start`,
            '%Y-%m-%d'
          ) AS `data`,
          sum(`youhist`.`entrantes_passantes`.`in`) AS `entrantes`
        from
          `youhist`.`entrantes_passantes`
        where
          (
            `youhist`.`entrantes_passantes`.`camera` = 'entrantes'
          )
        group by
          `youhist`.`entrantes_passantes`.`local`,
          date_format(
            `youhist`.`entrantes_passantes`.`interval_start`,
            '%Y-%m-%d'
          )
      ) `ent` on(
        (
          (`ent`.`local` = `vendas`.`Local`)
          and (
            convert(`ent`.`data` using utf8) = `vendas`.`Data`
          )
        )
      )
    )
    left join (
      select
        `youhist`.`entrantes_passantes`.`local` AS `local`,
        date_format(
          `youhist`.`entrantes_passantes`.`interval_start`,
          '%Y-%m-%d'
        ) AS `data`,
        sum(`youhist`.`entrantes_passantes`.`in`) AS `passantes`
      from
        `youhist`.`entrantes_passantes`
      where
        (
          `youhist`.`entrantes_passantes`.`camera` = 'passantes'
        )
      group by
        `youhist`.`entrantes_passantes`.`local`,
        date_format(
          `youhist`.`entrantes_passantes`.`interval_start`,
          '%Y-%m-%d'
        )
    ) `pass` on(
      (
        (`pass`.`local` = `vendas`.`Local`)
        and (
          convert(`pass`.`data` using utf8) = `vendas`.`Data`
        )
      )
    )
  )
where
  (
    (`vendas`.`Local` <> 'ES 01 CD')
    and (not((`vendas`.`Pedido` like '%W0005OUT%03%')))
  )
group by
  `vendas`.`Local`,
  `vendas`.`Data`;
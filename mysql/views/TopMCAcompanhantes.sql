ALTER ALGORITHM = UNDEFINED DEFINER = `TI` @`%` SQL SECURITY DEFINER VIEW `topmcacompanhantes` AS
select
  `m`.`MC` AS `MC`,
  count(distinct `m`.`SKU`) AS `NumSKUs`,
  sum(`m`.`Valor`) AS `Faturam`,
  count(distinct `m`.`Local`) AS `NumLocais`,
  count(`m`.`Ticket`) AS `NumTickets`,
  count(distinct `m`.`Dia`) AS `NumDias`,(count(`m`.`Ticket`) / count(distinct `m`.`Dia`)) AS `TicketsDia`,
  sum((`m`.`Local` = 'ES 03 SP Market')) AS `Tickets_SPM`,
  sum((`m`.`Local` = 'ES 05 Ibirapuera')) AS `Tickets_IBI`,
  sum((`m`.`Local` = 'ES 06 ABC')) AS `Tickets_ABC`,
  sum((`m`.`Local` = 'ES 04 Tatuape')) AS `Tickets_TTP`,
  sum((`m`.`Local` = 'ES 08 Center Norte')) AS `Tickets_CNT`
from
  `movimentos` `m`
where
  (
    (`m`.`DataHora` > (now() - interval 6 month))
    and `m`.`Ticket` in (
      select
        `m2`.`Ticket`
      from
        `movimentos` `m2`
      where
        (`m2`.`Tipo` = 'V Adq Terc p Consumo')
      group by
        `m2`.`Ticket`
      having
        (count(`m2`.`SKU`) > 1)
    )
  )
group by
  `m`.`MC`
having
  (`Faturam` > 5000)
order by
  count(`m`.`Ticket`) desc;
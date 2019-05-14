ALTER ALGORITHM = UNDEFINED DEFINER = `TI` @`%` SQL SECURITY DEFINER VIEW `resumovendas` AS
select
  `movimentos`.`Local` AS `Local`,
  sum(`movimentos`.`Total`) AS `Tot`,
  sum(`movimentos`.`Quantidade`) AS `Pares`,
  count(0) AS `Linhas`,
  min(`movimentos`.`DataHora`) AS `MinDataHora`,
  max(`movimentos`.`DataHora`) AS `MaxDataHora`,
  min(`movimentos`.`Dia`) AS `MinDia`,
  max(`movimentos`.`Dia`) AS `MaxDia`,(
    to_days(max(`movimentos`.`Dia`)) - to_days(min(`movimentos`.`Dia`))
  ) AS `dias_ativo`,
  count(distinct `movimentos`.`CPFouCNPJ`) AS `CPF_un`,
  count(distinct `movimentos`.`Ticket`) AS `Tickets_un`,
  count(distinct `movimentos`.`MC`) AS `MC_un`,
  count(distinct `movimentos`.`SKU`) AS `SKU_un`
from
  `movimentos`
where
  (`movimentos`.`Tipo` = 'V Adq Terc p Consumo')
group by
  `movimentos`.`Local`;
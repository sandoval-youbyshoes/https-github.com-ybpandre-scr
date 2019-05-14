ALTER ALGORITHM = UNDEFINED DEFINER = `TI` @`%` SQL SECURITY DEFINER VIEW `resumosemana` AS
select
  `m`.`Local` AS `Local`,
  date_format(min(`m`.`Dia`), '%x-%v') AS `AnoSemana`,
  date_format(min(`m`.`Dia`), '%x') AS `Ano`,
  date_format(min(`m`.`Dia`), '%v') AS `Semana`,
  min(`m`.`Dia`) AS `PrimeiroDia`,
  max(`m`.`Dia`) AS `UltimoDia`,
  count(distinct `m`.`MC`) AS `NumMCs`,
  count(distinct `m`.`SKU`) AS `NumSKUs`,
  sum(`m`.`Total`) AS `FaturamLiq`,
  sum(`m`.`Quantidade`) AS `VendasUnLiq`,
  count(distinct `m`.`Local`) AS `NumLocais`,
  count(distinct `m`.`Ticket`) AS `NumTickets`,
  count(distinct `m`.`Dia`) AS `NumDias`,(count(`m`.`Ticket`) / count(distinct `m`.`Dia`)) AS `TicketsDia`,(
    min(`m`.`Dia`) - interval weekday(min(`m`.`Dia`)) day
  ) AS `PrimDiaSem`,(
    max(`m`.`Dia`) - interval (weekday(max(`m`.`Dia`)) - 6) day
  ) AS `UltDiaSem`
from
  (
    select
      `mv`.`Tipo` AS `Tipo`,
      `mv`.`Local` AS `Local`,
      `mv`.`SKU` AS `SKU`,
      `mv`.`Data` AS `Data`,
      `mv`.`Hora` AS `Hora`,
      `mv`.`Quantidade` AS `Quantidade`,
      `mv`.`Valor` AS `Valor`,
      `mv`.`TotalE` AS `TotalE`,
      `mv`.`Ticket` AS `Ticket`,
      `mv`.`CPFouCNPJ` AS `CPFouCNPJ`,
      `mv`.`DataHora` AS `DataHora`,
      `mv`.`Dia` AS `Dia`,
      `mv`.`MC` AS `MC`,
      `mv`.`Tam` AS `Tam`,
      `mv`.`isCPF` AS `isCPF`,
      `mv`.`CPFok` AS `CPFok`,
      `mv`.`Total` AS `Total`
    from
      (
        select
          `youhist`.`movimentos`.`Tipo` AS `Tipo`,
          `youhist`.`movimentos`.`Local` AS `Local`,
          `youhist`.`movimentos`.`SKU` AS `SKU`,
          `youhist`.`movimentos`.`Data` AS `Data`,
          `youhist`.`movimentos`.`Hora` AS `Hora`,
          `youhist`.`movimentos`.`Quantidade` AS `Quantidade`,
          `youhist`.`movimentos`.`Valor` AS `Valor`,
          `youhist`.`movimentos`.`TotalE` AS `TotalE`,
          `youhist`.`movimentos`.`Ticket` AS `Ticket`,
          `youhist`.`movimentos`.`CPFouCNPJ` AS `CPFouCNPJ`,
          `youhist`.`movimentos`.`DataHora` AS `DataHora`,
          `youhist`.`movimentos`.`Dia` AS `Dia`,
          `youhist`.`movimentos`.`MC` AS `MC`,
          `youhist`.`movimentos`.`Tam` AS `Tam`,
          `youhist`.`movimentos`.`isCPF` AS `isCPF`,
          `youhist`.`movimentos`.`CPFok` AS `CPFok`,
          `youhist`.`movimentos`.`Total` AS `Total`
        from
          `youhist`.`movimentos` USE INDEX (`IDX_MOVIMENTOS_TIPO`)
        where
          (
            `youhist`.`movimentos`.`Tipo` = 'V Adq Terc p Consumo'
          )
      ) `mv`
    union
    select
      `youhist`.`movimentosunion`.`Tipo` AS `Tipo`,
      `youhist`.`movimentosunion`.`Local` AS `Local`,
      `youhist`.`movimentosunion`.`SKU` AS `SKU`,
      `youhist`.`movimentosunion`.`Data` AS `Data`,
      `youhist`.`movimentosunion`.`Hora` AS `Hora`,
      `youhist`.`movimentosunion`.`Quantidade` AS `Quantidade`,
      `youhist`.`movimentosunion`.`Valor` AS `Valor`,
      `youhist`.`movimentosunion`.`TotalE` AS `TotalE`,
      `youhist`.`movimentosunion`.`Ticket` AS `Ticket`,
      `youhist`.`movimentosunion`.`CPFouCNPJ` AS `CPFouCNPJ`,
      `youhist`.`movimentosunion`.`DataHora` AS `DataHora`,
      `youhist`.`movimentosunion`.`Dia` AS `Dia`,
      `youhist`.`movimentosunion`.`MC` AS `MC`,
      `youhist`.`movimentosunion`.`Tam` AS `Tam`,
      `youhist`.`movimentosunion`.`isCPF` AS `isCPF`,
      `youhist`.`movimentosunion`.`CPFok` AS `CPFok`,
      `youhist`.`movimentosunion`.`Total` AS `Total`
    from
      `youhist`.`movimentosunion`
  ) `m`
where
  (`m`.`Tipo` = 'V Adq Terc p Consumo')
group by
  date_format(
    (`m`.`Dia` - interval weekday(`m`.`Dia`) day),
    '%x-%v'
  ),
  `m`.`Local`;
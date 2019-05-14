ALTER ALGORITHM = UNDEFINED DEFINER = `TI` @`%` SQL SECURITY DEFINER VIEW `resumosemanaemp` AS
select
  date_format(min(`m`.`Dia`), '%x-%v') AS `AnoSemana`,
  date_format(min(`m`.`Dia`), '%x') AS `Ano`,
  date_format(min(`m`.`Dia`), '%v') AS `Semana`,
  min(`m`.`Dia`) AS `PrimeiroDia`,
  max(`m`.`Dia`) AS `UltimoDia`,
  count(distinct `m`.`MC`) AS `NumMCs`,
  count(distinct `m`.`SKU`) AS `NumSKUs`,
  sum(`m`.`Valor`) AS `FaturamLiq`,
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
      `m1`.`Tipo` AS `Tipo`,
      `m1`.`Local` AS `Local`,
      `m1`.`SKU` AS `SKU`,
      `m1`.`Data` AS `Data`,
      `m1`.`Hora` AS `Hora`,
      `m1`.`Quantidade` AS `Quantidade`,
      `m1`.`Valor` AS `Valor`,
      `m1`.`TotalE` AS `TotalE`,
      `m1`.`Ticket` AS `Ticket`,
      `m1`.`CPFouCNPJ` AS `CPFouCNPJ`,
      `m1`.`DataHora` AS `DataHora`,
      `m1`.`Dia` AS `Dia`,
      `m1`.`MC` AS `MC`,
      `m1`.`Tam` AS `Tam`,
      `m1`.`isCPF` AS `isCPF`,
      `m1`.`CPFok` AS `CPFok`,
      `m1`.`Total` AS `Total`
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
          `youhist`.`movimentos`
        where
          (
            (
              `youhist`.`movimentos`.`Tipo` = 'V Adq Terc p Consumo'
            )
            and (`youhist`.`movimentos`.`Local` <> 'ES 01 CD')
          )
      ) `m1`
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
group by
  date_format(
    (`m`.`Dia` - interval weekday(`m`.`Dia`) day),
    '%x-%v'
  );
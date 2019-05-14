ALTER ALGORITHM = UNDEFINED DEFINER = `TI` @`%` SQL SECURITY DEFINER VIEW `movimentoslocalc` AS
select
  `m`.`Tipo` AS `Tipo`,
  `m`.`Local` AS `Local`,
  substring_index(`m`.`SKU`, '-', 1) AS `ModeloCor`,
  left(
    substring_index(`m`.`SKU`, '-', 1),
    if(
      (
        left(`m`.`SKU`, 1) between 'A'
        and 'Z'
      ),
      7,
      6
    )
  ) AS `Modelo`,
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
  `l`.`LocalC` AS `LocalC`
from
  (
    `movimentos` `m`
    join `locais` `l` on((`m`.`Local` = convert(`l`.`LocalM` using utf8)))
  );
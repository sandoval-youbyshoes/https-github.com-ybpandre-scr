ALTER ALGORITHM = UNDEFINED DEFINER = `TI` @`%` SQL SECURITY DEFINER VIEW `topmcs` AS
select
  `evalcomcdn`.`ModeloCor` AS `ModeloCor`,
  left(
    `evalcomcdn`.`ModeloCor`,
    if(
      (
        locate(left(`evalcomcdn`.`ModeloCor`, 1), 'CF') > 0
      ),
      4,
      3
    )
  ) AS `Familia`,
  left(
    `evalcomcdn`.`ModeloCor`,
    if(
      (
        locate(left(`evalcomcdn`.`ModeloCor`, 1), 'CF') > 0
      ),
      7,
      6
    )
  ) AS `Modelo`,
  any_value(`evalcomcdn`.`COL`) AS `COL`,
  any_value(`evalcomcdn`.`Tipo`) AS `Tipo`,
  any_value(`evalcomcdn`.`COL`) AS `Colecao`,
  max(`evalcomcdn`.`CampeaoGlobal`) AS `Campeao`,
  if((max(`evalcomcdn`.`NumVezesCampGlobal`) > 0), 1, 0) AS `FoiCampeao`,
  count(distinct `evalcomcdn`.`SKU`) AS `NumSKUs`,
  sum(if((`evalcomcdn`.`EstCDEM` > 0), 1, 0)) AS `DispsCD`,
  sum(`evalcomcdn`.`EstoqueEmMaos`) AS `EstEMEmp`,
  sum(`evalcomcdn`.`EstCDEM`) AS `EstCDEM`,
  sum(`evalcomcdn`.`VELVDUN360`) AS `VelVenda`,
  sum(`evalcomcdn`.`VELGANHOPER360`) AS `VelGanho`,
  sum(`evalcomcdn`.`UnidadesVendidasLiquido360`) AS `VendUn`,
  sum(`evalcomcdn`.`ValorVendasLiquido360`) AS `VendasFat`,
  max(`evalcomcdn`.`DIASATIVO`) AS `DiasAtivo`,
  greatest(
    0,
    floor(
      least(
        (
          sum(
            (
              if((`evalcomcdn`.`Tamanho` = '34'), 1, 0) * `evalcomcdn`.`EstCDEM`
            )
          ) / 1
        ),(
          sum(
            (
              if((`evalcomcdn`.`Tamanho` = '35'), 1, 0) * `evalcomcdn`.`EstCDEM`
            )
          ) / 2
        ),(
          sum(
            (
              if((`evalcomcdn`.`Tamanho` = '36'), 1, 0) * `evalcomcdn`.`EstCDEM`
            )
          ) / 2
        ),(
          sum(
            (
              if((`evalcomcdn`.`Tamanho` = '37'), 1, 0) * `evalcomcdn`.`EstCDEM`
            )
          ) / 2
        ),(
          sum(
            (
              if((`evalcomcdn`.`Tamanho` = '38'), 1, 0) * `evalcomcdn`.`EstCDEM`
            )
          ) / 1
        ),(
          sum(
            (
              if((`evalcomcdn`.`Tamanho` = '39'), 1, 0) * `evalcomcdn`.`EstCDEM`
            )
          ) / 1
        )
      )
    )
  ) AS `NumLojasGCentralCD`,
  greatest(
    0,
    floor(
      least(
        (
          sum(
            (
              if((`evalcomcdn`.`Tamanho` = '34'), 1, 0) * `evalcomcdn`.`EstoqueEmMaos`
            )
          ) / 1
        ),(
          sum(
            (
              if((`evalcomcdn`.`Tamanho` = '35'), 1, 0) * `evalcomcdn`.`EstoqueEmMaos`
            )
          ) / 2
        ),(
          sum(
            (
              if((`evalcomcdn`.`Tamanho` = '36'), 1, 0) * `evalcomcdn`.`EstoqueEmMaos`
            )
          ) / 2
        ),(
          sum(
            (
              if((`evalcomcdn`.`Tamanho` = '37'), 1, 0) * `evalcomcdn`.`EstoqueEmMaos`
            )
          ) / 2
        ),(
          sum(
            (
              if((`evalcomcdn`.`Tamanho` = '38'), 1, 0) * `evalcomcdn`.`EstoqueEmMaos`
            )
          ) / 1
        ),(
          sum(
            (
              if((`evalcomcdn`.`Tamanho` = '39'), 1, 0) * `evalcomcdn`.`EstoqueEmMaos`
            )
          ) / 1
        )
      )
    )
  ) AS `NumLojasGCentralEmp`,
  any_value(`m`.`TipoNovo`) AS `TipoNovo`
from
  (
    `youhist`.`evalcomcdn`
    join `youhist`.`modelostipos` `m` on(
      (
        `m`.`Modelo` = left(
          `evalcomcdn`.`ModeloCor`,
          if((left(`evalcomcdn`.`ModeloCor`, 1) = 'F'), 7, 6)
        )
      )
    )
  )
where
  (`evalcomcdn`.`ModeloCor` is not null)
group by
  `evalcomcdn`.`ModeloCor`
having
  ((`EstEMEmp` + `VendUn`) > 0);
ALTER ALGORITHM = UNDEFINED DEFINER = `TI` @`%` SQL SECURITY DEFINER VIEW `ultimospares` AS
select
  `evalcomcdn`.`ModeloCor` AS `MC`,
  `evalcomcdn`.`Local` AS `Local`,
  min(`evalcomcdn`.`COL`) AS `Colec`,
  min(`evalcomcdn`.`PrimeiraMovimentacao`) AS `DCriacao`,
  min(
    str_to_date(`evalcomcdn`.`PrimeiraMovimentacao`, '%Y-%m-%d')
  ) AS `DDCriacao`,
  count(distinct `evalcomcdn`.`SKU`) AS `NumSKUs`,
  sum(`evalcomcdn`.`AlvoAtual`) AS `Alvo`,
  if(
    (max(`maxcol`.`UltCol`) = max(`evalcomcdn`.`COL`)),
    ifnull(max(`fm`.`Campeao`), 0),
    max(`evalcomcdn`.`CampeaoGlobal`)
  ) AS `Campeao`,
  ifnull(max(`fm`.`Campeao`), 0) AS `FastMover`,
  min(`evalcomcdn`.`PrimeiraDataCampGlobal`) AS `PDCamp`,
  min(`evalcomcdn`.`UltimaDataCampGlobal`) AS `UDCamp`,
  max(`evalcomcdn`.`NumVezesCampGlobal`) AS `NumVezesCampGlobal`,
  avg(`evalcomcdn`.`DCEADJ`) AS `AvgDCEAjust`,
  max(`evalcomcdn`.`DIASATIVO`) AS `DiasAtivo`,
  min(`evalcomcdn`.`DiasUltModAlvo`) AS `DiasUltModAlvo`,
  sum(`evalcomcdn`.`VELVDUN`) AS `VelVdUn`,
  sum(`evalcomcdn`.`VELGANHOPER`) AS `VelGanhoPer`,
  sum(`evalcomcdn`.`UnidadesVendidasLiquido`) AS `VdUnLq`,
  sum(`evalcomcdn`.`GANHOPER`) AS `GanhoPer`,
  sum(`evalcomcdn`.`ValorVendasLiquido`) AS `VdFnLq`,
  min(`evalcomcdn`.`Tipo`) AS `Tipo`,
  sum(`evalcomcdn`.`EstoqueEmMaos`) AS `EstEM`,
  sum(`evalcomcdn`.`EstoqueEmTransito`) AS `EstET`,
  sum(`evalcomcdn`.`EstTotal`) AS `EstTot`,
  sum(`evalcomcdn`.`EstEMCD`) AS `EstEMCD`,
  sum(`evalcomcdn`.`EstETCD`) AS `EstETCD`,
  max(
    (
      if((`evalcomcdn`.`Tamanho` = 33), 1, 0) * `evalcomcdn`.`EstEMCD`
    )
  ) AS `Tam33CD`,
  max(
    (
      if((`evalcomcdn`.`Tamanho` = 34), 1, 0) * `evalcomcdn`.`EstEMCD`
    )
  ) AS `Tam34CD`,
  max(
    (
      if((`evalcomcdn`.`Tamanho` = 35), 1, 0) * `evalcomcdn`.`EstEMCD`
    )
  ) AS `Tam35CD`,
  max(
    (
      if((`evalcomcdn`.`Tamanho` = 36), 1, 0) * `evalcomcdn`.`EstEMCD`
    )
  ) AS `Tam36CD`,
  max(
    (
      if((`evalcomcdn`.`Tamanho` = 37), 1, 0) * `evalcomcdn`.`EstEMCD`
    )
  ) AS `Tam37CD`,
  max(
    (
      if((`evalcomcdn`.`Tamanho` = 38), 1, 0) * `evalcomcdn`.`EstEMCD`
    )
  ) AS `Tam38CD`,
  max(
    (
      if((`evalcomcdn`.`Tamanho` = 39), 1, 0) * `evalcomcdn`.`EstEMCD`
    )
  ) AS `Tam39CD`,
  max(
    (
      if((`evalcomcdn`.`Tamanho` = 40), 1, 0) * `evalcomcdn`.`EstEMCD`
    )
  ) AS `Tam40CD`,
  max(
    (
      if((`evalcomcdn`.`Tamanho` = 33), 1, 0) * `evalcomcdn`.`EstoqueEmMaos`
    )
  ) AS `Tam33`,
  max(
    (
      if((`evalcomcdn`.`Tamanho` = 34), 1, 0) * `evalcomcdn`.`EstoqueEmMaos`
    )
  ) AS `Tam34`,
  max(
    (
      if((`evalcomcdn`.`Tamanho` = 35), 1, 0) * `evalcomcdn`.`EstoqueEmMaos`
    )
  ) AS `Tam35`,
  max(
    (
      if((`evalcomcdn`.`Tamanho` = 36), 1, 0) * `evalcomcdn`.`EstoqueEmMaos`
    )
  ) AS `Tam36`,
  max(
    (
      if((`evalcomcdn`.`Tamanho` = 37), 1, 0) * `evalcomcdn`.`EstoqueEmMaos`
    )
  ) AS `Tam37`,
  max(
    (
      if((`evalcomcdn`.`Tamanho` = 38), 1, 0) * `evalcomcdn`.`EstoqueEmMaos`
    )
  ) AS `Tam38`,
  max(
    (
      if((`evalcomcdn`.`Tamanho` = 39), 1, 0) * `evalcomcdn`.`EstoqueEmMaos`
    )
  ) AS `Tam39`,
  max(
    (
      if((`evalcomcdn`.`Tamanho` = 40), 1, 0) * `evalcomcdn`.`EstoqueEmMaos`
    )
  ) AS `Tam40`,
  sum(`evalcomcdn`.`RuptEM`) AS `RuptEM`,
  sum(
    if(
      (
        (
          `evalcomcdn`.`Tamanho` between '34'
          and '38'
        )
        and (`evalcomcdn`.`EstoqueEmMaos` > 0)
      ),
      1,
      0
    )
  ) AS `MCNumSKUsDispCent`,
  sum(
    if(
      (
        (
          `evalcomcdn`.`Tamanho` between '34'
          and '38'
        )
        and (`evalcomcdn`.`EstoqueEmMaos` is not null)
      ),
      1,
      0
    )
  ) AS `MCNumSKUsCent`,
  if(
    (
      ifnull(
        min(`evalcomcdn`.`PrecoPadrao`),
        min(`evalcomcdn`.`PrecoCorrente`)
      ) < (0.9 * min(`evalcomcdn`.`PrecoOriginal`))
    ),
    1,
    0
  ) AS `Descontado`,
  greatest(
    0,
    ifnull(
      round(
        (
          100 - (
            100 * round(
              (
                ifnull(
                  min(`evalcomcdn`.`PrecoPadrao`),
                  min(`evalcomcdn`.`PrecoCorrente`)
                ) / min(`evalcomcdn`.`PrecoOriginal`)
              ),
              1
            )
          )
        ),
        0
      ),
      0
    )
  ) AS `Desconto`,
  round(min(`evalcomcdn`.`PrecoPadrao`), 2) AS `PrecoAtual`,
  round(min(`evalcomcdn`.`PrecoOriginal`), 2) AS `PrecoOriginal`,
  max(`maxcol`.`UltCol`) AS `UltCol`,
  if(
    (max(`maxcol`.`UltCol`) = max(`evalcomcdn`.`COL`)),
    1,
    0
  ) AS `UltimaColecao`,
  max(`contaskus`.`TotNumSKUs`) AS `TotNumSKUs`,(
    sum(if((`evalcomcdn`.`EstoqueEmMaos` > 0), 1, 0)) / max(`contaskus`.`TotNumSKUs`)
  ) AS `PartTotNumSKUs`,
  any_value(`cad`.`NumLojasGCentralCD`) AS `NumLojasGCentralCD`,
  any_value(`cad`.`NumLojasGCentralEmp`) AS `NumLojasGCentralEmp`,
  any_value(`cad`.`NumLojas`) AS `NumLojas`,
  any_value(`cad`.`EstETCD33`) AS `EstETCD33`,
  any_value(`cad`.`EstETCD34`) AS `EstETCD34`,
  any_value(`cad`.`EstETCD35`) AS `EstETCD35`,
  any_value(`cad`.`EstETCD36`) AS `EstETCD36`,
  any_value(`cad`.`EstETCD37`) AS `EstETCD37`,
  any_value(`cad`.`EstETCD38`) AS `EstETCD38`,
  any_value(`cad`.`EstETCD39`) AS `EstETCD39`,
  any_value(`cad`.`EstETCD40`) AS `EstETCD40`
from
  (
    (
      (
        (
          `youhist`.`evalcomcdn`
          left join (
            select
              max(`evalcomcdn`.`COL`) AS `UltCol`
            from
              `youhist`.`evalcomcdn`
            where
              (`evalcomcdn`.`COL` <> 'GERAL')
          ) `maxcol` on((1 = 1))
        )
        left join `youhist`.`fastmovers` `fm` on((`evalcomcdn`.`ModeloCor` = `fm`.`ModeloCor`))
      )
      left join (
        select
          sum(`xx`.`NumSKUs`) AS `TotNumSKUs`
        from
          (
            select
              `evalcomcdn`.`LOCALC` AS `LocalC`,
              `evalcomcdn`.`ModeloCor` AS `ModeloCor`,
              count(`evalcomcdn`.`SKU`) AS `NumSKUs`,(
                sum(`evalcomcdn`.`EstoqueEmMaos`) + sum(`evalcomcdn`.`EstoqueEmTransito`)
              ) AS `EstTot`
            from
              `youhist`.`evalcomcdn`
            where
              (
                (`evalcomcdn`.`LOCALC` <> 'NA')
                and (`evalcomcdn`.`ModeloCor` is not null)
                and (
                  `evalcomcdn`.`PrimeiraMovimentacao` <> 'Sem movimenta��o'
                )
                and (`evalcomcdn`.`Colecao` <> 'GERAL')
              )
            group by
              `evalcomcdn`.`LOCALC`,
              `evalcomcdn`.`ModeloCor`
            having
              (
                (`EstTot` > 0)
                and (`evalcomcdn`.`LOCALC` <> '')
              )
          ) `xx`
      ) `contaskus` on((1 = 1))
    )
    left join (
      select
        `evalcomcdn`.`ModeloCor` AS `ModeloCor`,
        count(
          distinct if(
            (
              (`evalcomcdn`.`EstoqueEmMaos` > 0)
              and (`evalcomcdn`.`LOCALC` <> 'NA')
              and (`evalcomcdn`.`LOCALC` <> '0-CD')
            ),
            `evalcomcdn`.`LOCALC`,
            NULL
          )
        ) AS `NumLojas`,(
          sum(`evalcomcdn`.`EstoqueEmMaos`) + sum(`evalcomcdn`.`EstoqueEmTransito`)
        ) AS `EstoqueTotalEmp`,
        sum(
          if(
            (
              (`evalcomcdn`.`Tamanho` = '33')
              and (`evalcomcdn`.`LOCALC` = '0-CD')
            ),
            `evalcomcdn`.`EstoqueEmTransito`,
            0
          )
        ) AS `EstETCD33`,
        sum(
          if(
            (
              (`evalcomcdn`.`Tamanho` = '34')
              and (`evalcomcdn`.`LOCALC` = '0-CD')
            ),
            `evalcomcdn`.`EstoqueEmTransito`,
            0
          )
        ) AS `EstETCD34`,
        sum(
          if(
            (
              (`evalcomcdn`.`Tamanho` = '35')
              and (`evalcomcdn`.`LOCALC` = '0-CD')
            ),
            `evalcomcdn`.`EstoqueEmTransito`,
            0
          )
        ) AS `EstETCD35`,
        sum(
          if(
            (
              (`evalcomcdn`.`Tamanho` = '36')
              and (`evalcomcdn`.`LOCALC` = '0-CD')
            ),
            `evalcomcdn`.`EstoqueEmTransito`,
            0
          )
        ) AS `EstETCD36`,
        sum(
          if(
            (
              (`evalcomcdn`.`Tamanho` = '37')
              and (`evalcomcdn`.`LOCALC` = '0-CD')
            ),
            `evalcomcdn`.`EstoqueEmTransito`,
            0
          )
        ) AS `EstETCD37`,
        sum(
          if(
            (
              (`evalcomcdn`.`Tamanho` = '38')
              and (`evalcomcdn`.`LOCALC` = '0-CD')
            ),
            `evalcomcdn`.`EstoqueEmTransito`,
            0
          )
        ) AS `EstETCD38`,
        sum(
          if(
            (
              (`evalcomcdn`.`Tamanho` = '39')
              and (`evalcomcdn`.`LOCALC` = '0-CD')
            ),
            `evalcomcdn`.`EstoqueEmTransito`,
            0
          )
        ) AS `EstETCD39`,
        sum(
          if(
            (
              (`evalcomcdn`.`Tamanho` = '40')
              and (`evalcomcdn`.`LOCALC` = '0-CD')
            ),
            `evalcomcdn`.`EstoqueEmTransito`,
            0
          )
        ) AS `EstETCD40`,
        if(
          (count(distinct `evalcomcdn`.`Tamanho`) <= 1),
          max(`evalcomcdn`.`EstEMCD`),
          greatest(
            0,
            floor(
              least(
                (
                  max(
                    (
                      if((`evalcomcdn`.`Tamanho` = '34'), 1, 0) * `evalcomcdn`.`EstEMCD`
                    )
                  ) / 1
                ),(
                  max(
                    (
                      if((`evalcomcdn`.`Tamanho` = '35'), 1, 0) * `evalcomcdn`.`EstEMCD`
                    )
                  ) / 2
                ),(
                  max(
                    (
                      if((`evalcomcdn`.`Tamanho` = '36'), 1, 0) * `evalcomcdn`.`EstEMCD`
                    )
                  ) / 2
                ),(
                  max(
                    (
                      if((`evalcomcdn`.`Tamanho` = '37'), 1, 0) * `evalcomcdn`.`EstEMCD`
                    )
                  ) / 2
                ),(
                  max(
                    (
                      if((`evalcomcdn`.`Tamanho` = '38'), 1, 0) * `evalcomcdn`.`EstEMCD`
                    )
                  ) / 1
                )
              )
            )
          )
        ) AS `NumLojasGCentralCD`,
        if(
          (count(distinct `evalcomcdn`.`Tamanho`) <= 1),
          sum(`evalcomcdn`.`EstoqueEmMaos`),
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
                )
              )
            )
          )
        ) AS `NumLojasGCentralEmp`
      from
        `youhist`.`evalcomcdn`
      where
        (
          (`evalcomcdn`.`ModeloCor` is not null)
          and (
            `evalcomcdn`.`PrimeiraMovimentacao` <> 'Sem movimenta��o'
          )
        )
      group by
        `evalcomcdn`.`ModeloCor`
    ) `cad` on((`evalcomcdn`.`ModeloCor` = `cad`.`ModeloCor`))
  )
where
  (
    (`evalcomcdn`.`LOCALC` <> '')
    and (`evalcomcdn`.`ModeloCor` is not null)
    and (
      `evalcomcdn`.`PrimeiraMovimentacao` <> 'Sem movimenta��o'
    )
  )
group by
  `evalcomcdn`.`Local`,
  `evalcomcdn`.`ModeloCor`
having
  (
    (`EstEM` > 0)
    and (`Colec` <> 'GERAL')
    and (3 >= `MCNumSKUsDispCent`)
    and (`DiasAtivo` > 0)
  );
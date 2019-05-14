ALTER ALGORITHM = UNDEFINED DEFINER = `TI` @`%` SQL SECURITY DEFINER VIEW `cadastromc` AS
select
  `cadastro`.`ModeloCor` AS `ModeloCor`,
  left(
    `cadastro`.`ModeloCor`,
    if(
      (
        left(`cadastro`.`ModeloCor`, 1) between 'a'
        and 'z'
      ),
      4,
      3
    )
  ) AS `Familia`,
  left(
    `cadastro`.`ModeloCor`,
    if(
      (
        left(`cadastro`.`ModeloCor`, 1) between 'a'
        and 'z'
      ),
      7,
      6
    )
  ) AS `Modelo`,
  count(distinct `cadastro`.`tamanho`) AS `NumSKUs`,
  any_value(`cadastro`.`colecao`) AS `Colecao`,
  any_value(`cadastro`.`tipo`) AS `Tipo`,
  min(`cadastro`.`DataCriacao`) AS `DCriacao`,
  min(`cadastro`.`PrimeiraMovimentacao`) AS `PrimeiraMovimentacao`,
  sum(`cadastro`.`EstoqueEmMaos`) AS `EstoqueEmMaos`,
  sum(`cadastro`.`EstoqueEmTransito`) AS `EstoqueEmTransito`,
  sum(`cadastro`.`UnidadesVendidasBruto`) AS `unidadesVendidasBruto`,
  sum(`cadastro`.`ValorVendasBruto`) AS `ValorVendasBruto`,
  sum(`cadastro`.`UnidadesVendidasLiquido`) AS `unidadesVendidasLiquido`,
  sum(`cadastro`.`valorvendasliquido`) AS `ValorVendasLiquido`,
  avg(`cadastro`.`AvgDCEAjust`) AS `AvgDCEAjust`,
  round(avg(`cadastro`.`CustoUnitario`), 2) AS `CustoUnitario`,
  round(avg(`cadastro`.`PrecoOriginal`), 2) AS `PrecoOriginal`,
  round(avg(`cadastro`.`PrecoCorrente`), 2) AS `PrecoCorrenteEval`,
  round(min(`cadastro`.`PrecoCorrente`), 2) AS `PrecoCorrenteMinEval`,
  round(max(`cadastro`.`PrecoCorrente`), 2) AS `PrecoCorrenteMaxEval`,
  max(`cadastro`.`CampeaoGlobal`) AS `CampeaoGlobal`,
  if(
    (
      (max(`cadastro`.`numvezescampglobal`) > 0)
      and (max(`cadastro`.`CampeaoGlobal`) = 0)
    ),
    1,
    0
  ) AS `FoiCampeao`,
  min(`cadastro`.`primeiradatacampglobal`) AS `PrimeiraDataCampGlobal`,
  min(`cadastro`.`ultimadatacampglobal`) AS `UltimaDataCampGlobal`,
  min(`cadastro`.`numvezescampglobal`) AS `NumVezesCampGlobal`,
  max(`cadastro`.`diasativo`) AS `DiasAtivo`,
  sum(`cadastro`.`EstoqueEmMaosCD`) AS `EstoqueEmMaosCD`,
  sum(`cadastro`.`EstoqueEmMaosLojas`) AS `EstoqueEmMaosLojas`,
  sum(`cadastro`.`EstoqueEmTransitoCD`) AS `EstoqueEmTransitoCD`,
  sum(`cadastro`.`EstoqueEmTransitoLojas`) AS `EstoqueEmTransitoLojas`,
  sum(if((`cadastro`.`EstoqueEmMaosCD` > 0), 1, 0)) AS `DispsCD`,
  sum(`cadastro`.`GANHOPER`) AS `GANHOPER`,
  sum(`cadastro`.`GANHOPER360`) AS `GANHOPER360`,
  sum(`cadastro`.`ValorVendasBruto360`) AS `ValorVendasBruto360`,
  sum(`cadastro`.`valorvendasLiquido360`) AS `ValorVendasLiquido360`,
  sum(`cadastro`.`UnidadesVendidasBruto360`) AS `unidadesVendidasBruto360`,
  sum(`cadastro`.`UnidadesVendidasLiquido360`) AS `unidadesVendidasLiquido360`,
  sum(`cadastro`.`velvdun360`) AS `velvdun360`,
  sum(`cadastro`.`velganhoper360`) AS `velganhoper360`,
  sum(`cadastro`.`velvdun`) AS `velvdun`,
  sum(`cadastro`.`velganhoper`) AS `velganhoper`,
  max(`cadastro`.`DiasAtivoSPM`) AS `DiasAtivoSPM`,
  max(`cadastro`.`DiasAtivoTTP`) AS `DiasAtivoTTP`,
  max(`cadastro`.`DiasAtivoIBR`) AS `DiasAtivoIBR`,
  max(`cadastro`.`DiasAtivoABC`) AS `DiasAtivoABC`,
  max(`cadastro`.`DiasAtivoCNT`) AS `DiasAtivoCNT`,
  if((sum(`cadastro`.`DescontadoSPM`) > 0), 1, 0) AS `DescontadoSPM`,
  if((sum(`cadastro`.`DescontadoTTP`) > 0), 1, 0) AS `DescontadoTTP`,
  if((sum(`cadastro`.`DescontadoIBR`) > 0), 1, 0) AS `DescontadoIBR`,
  if((sum(`cadastro`.`DescontadoABC`) > 0), 1, 0) AS `DescontadoABC`,
  if((sum(`cadastro`.`DescontadoCNT`) > 0), 1, 0) AS `DescontadoCNT`,
  greatest(0, ifnull(max(`cadastro`.`DescontoSPM`), 0)) AS `DescontoSPM`,
  greatest(0, ifnull(max(`cadastro`.`DescontoTTP`), 0)) AS `DescontoTTP`,
  greatest(0, ifnull(max(`cadastro`.`DescontoIBR`), 0)) AS `DescontoIBR`,
  greatest(0, ifnull(max(`cadastro`.`DescontoABC`), 0)) AS `DescontoABC`,
  greatest(0, ifnull(max(`cadastro`.`DescontoCNT`), 0)) AS `DescontoCNT`,
  sum(`cadastro`.`VelVd360SPM`) AS `VelVd360SPM`,
  sum(`cadastro`.`VelVd360TTP`) AS `VelVd360TTP`,
  sum(`cadastro`.`VelVd360IBR`) AS `VelVd360IBR`,
  sum(`cadastro`.`VelVd360ABC`) AS `VelVd360ABC`,
  sum(`cadastro`.`VelVd360CNT`) AS `VelVd360CNT`,
  sum(`cadastro`.`AlvoCD`) AS `AlvoCD`,
  sum(`cadastro`.`AlvoSPM`) AS `AlvoSPM`,
  sum(`cadastro`.`AlvoTTP`) AS `AlvoTTP`,
  sum(`cadastro`.`AlvoIBR`) AS `AlvoIBR`,
  sum(`cadastro`.`AlvoABC`) AS `AlvoABC`,
  sum(`cadastro`.`AlvoCNT`) AS `AlvoCNT`,
  min(`cadastro`.`DiasModAlvoCD`) AS `DiasModAlvoCD`,
  min(`cadastro`.`DiasModAlvoSPM`) AS `DiasModAlvoSPM`,
  min(`cadastro`.`DiasModAlvoTTP`) AS `DiasModAlvoTTP`,
  min(`cadastro`.`DiasModAlvoIBR`) AS `DiasModAlvoIBR`,
  min(`cadastro`.`DiasModAlvoABC`) AS `DiasModAlvoABC`,
  min(`cadastro`.`DiasModAlvoCNT`) AS `DiasModAlvoCNT`,
  sum(
    (
      if((`cadastro`.`tamanho` = '33'), 1, 0) * `cadastro`.`EstoqueEmMaos`
    )
  ) AS `EstEM33`,
  sum(
    (
      if((`cadastro`.`tamanho` = '34'), 1, 0) * `cadastro`.`EstoqueEmMaos`
    )
  ) AS `EstEM34`,
  sum(
    (
      if((`cadastro`.`tamanho` = '35'), 1, 0) * `cadastro`.`EstoqueEmMaos`
    )
  ) AS `EstEM35`,
  sum(
    (
      if((`cadastro`.`tamanho` = '36'), 1, 0) * `cadastro`.`EstoqueEmMaos`
    )
  ) AS `EstEM36`,
  sum(
    (
      if((`cadastro`.`tamanho` = '37'), 1, 0) * `cadastro`.`EstoqueEmMaos`
    )
  ) AS `EstEM37`,
  sum(
    (
      if((`cadastro`.`tamanho` = '38'), 1, 0) * `cadastro`.`EstoqueEmMaos`
    )
  ) AS `EstEM38`,
  sum(
    (
      if((`cadastro`.`tamanho` = '39'), 1, 0) * `cadastro`.`EstoqueEmMaos`
    )
  ) AS `EstEM39`,
  sum(
    (
      if((`cadastro`.`tamanho` = '40'), 1, 0) * `cadastro`.`EstoqueEmMaos`
    )
  ) AS `EstEM40`,
  sum(
    (
      if((`cadastro`.`tamanho` = '33'), 1, 0) * (
        `cadastro`.`EstoqueEmMaos` + `cadastro`.`EstoqueEmTransito`
      )
    )
  ) AS `EstTot33`,
  sum(
    (
      if((`cadastro`.`tamanho` = '34'), 1, 0) * (
        `cadastro`.`EstoqueEmMaos` + `cadastro`.`EstoqueEmTransito`
      )
    )
  ) AS `EstTot34`,
  sum(
    (
      if((`cadastro`.`tamanho` = '35'), 1, 0) * (
        `cadastro`.`EstoqueEmMaos` + `cadastro`.`EstoqueEmTransito`
      )
    )
  ) AS `EstTot35`,
  sum(
    (
      if((`cadastro`.`tamanho` = '36'), 1, 0) * (
        `cadastro`.`EstoqueEmMaos` + `cadastro`.`EstoqueEmTransito`
      )
    )
  ) AS `EstTot36`,
  sum(
    (
      if((`cadastro`.`tamanho` = '37'), 1, 0) * (
        `cadastro`.`EstoqueEmMaos` + `cadastro`.`EstoqueEmTransito`
      )
    )
  ) AS `EstTot37`,
  sum(
    (
      if((`cadastro`.`tamanho` = '38'), 1, 0) * (
        `cadastro`.`EstoqueEmMaos` + `cadastro`.`EstoqueEmTransito`
      )
    )
  ) AS `EstTot38`,
  sum(
    (
      if((`cadastro`.`tamanho` = '39'), 1, 0) * (
        `cadastro`.`EstoqueEmMaos` + `cadastro`.`EstoqueEmTransito`
      )
    )
  ) AS `EstTot39`,
  sum(
    (
      if((`cadastro`.`tamanho` = '40'), 1, 0) * (
        `cadastro`.`EstoqueEmMaos` + `cadastro`.`EstoqueEmTransito`
      )
    )
  ) AS `EstTot40`,
  sum(
    (
      if((`cadastro`.`tamanho` = '33'), 1, 0) * `cadastro`.`EstoqueEmMaosCD`
    )
  ) AS `Tam33CD`,
  sum(
    (
      if((`cadastro`.`tamanho` = '34'), 1, 0) * `cadastro`.`EstoqueEmMaosCD`
    )
  ) AS `Tam34CD`,
  sum(
    (
      if((`cadastro`.`tamanho` = '35'), 1, 0) * `cadastro`.`EstoqueEmMaosCD`
    )
  ) AS `Tam35CD`,
  sum(
    (
      if((`cadastro`.`tamanho` = '36'), 1, 0) * `cadastro`.`EstoqueEmMaosCD`
    )
  ) AS `Tam36CD`,
  sum(
    (
      if((`cadastro`.`tamanho` = '37'), 1, 0) * `cadastro`.`EstoqueEmMaosCD`
    )
  ) AS `Tam37CD`,
  sum(
    (
      if((`cadastro`.`tamanho` = '38'), 1, 0) * `cadastro`.`EstoqueEmMaosCD`
    )
  ) AS `Tam38CD`,
  sum(
    (
      if((`cadastro`.`tamanho` = '39'), 1, 0) * `cadastro`.`EstoqueEmMaosCD`
    )
  ) AS `Tam39CD`,
  sum(
    (
      if((`cadastro`.`tamanho` = '40'), 1, 0) * `cadastro`.`EstoqueEmMaosCD`
    )
  ) AS `Tam40CD`,(
    (
      (
        (
          if((sum(`cadastro`.`AlvoSPM`) > 0), 1, 0) + if((sum(`cadastro`.`AlvoTTP`) > 0), 1, 0)
        ) + if((sum(`cadastro`.`AlvoIBR`) > 0), 1, 0)
      ) + if((sum(`cadastro`.`AlvoABC`) > 0), 1, 0)
    ) + if((sum(`cadastro`.`AlvoCNT`) > 0), 1, 0)
  ) AS `NumLojasAtivo`,
  if(
    (count(distinct `cadastro`.`tamanho`) <= 1),
    sum(`cadastro`.`EstoqueEmMaosCD`),
    greatest(
      0,
      floor(
        least(
          (
            sum(
              (
                if((`cadastro`.`tamanho` = '34'), 1, 0) * `cadastro`.`EstoqueEmMaosCD`
              )
            ) / 1
          ),(
            sum(
              (
                if((`cadastro`.`tamanho` = '35'), 1, 0) * `cadastro`.`EstoqueEmMaosCD`
              )
            ) / 2
          ),(
            sum(
              (
                if((`cadastro`.`tamanho` = '36'), 1, 0) * `cadastro`.`EstoqueEmMaosCD`
              )
            ) / 2
          ),(
            sum(
              (
                if((`cadastro`.`tamanho` = '37'), 1, 0) * `cadastro`.`EstoqueEmMaosCD`
              )
            ) / 2
          ),(
            sum(
              (
                if((`cadastro`.`tamanho` = '38'), 1, 0) * `cadastro`.`EstoqueEmMaosCD`
              )
            ) / 1
          )
        )
      )
    )
  ) AS `NumLojasGCentralCD`,
  if(
    (count(distinct `cadastro`.`tamanho`) <= 1),
    sum(`cadastro`.`EstoqueEmMaos`),
    greatest(
      0,
      floor(
        least(
          (
            sum(
              (
                if((`cadastro`.`tamanho` = '34'), 1, 0) * `cadastro`.`EstoqueEmMaos`
              )
            ) / 1
          ),(
            sum(
              (
                if((`cadastro`.`tamanho` = '35'), 1, 0) * `cadastro`.`EstoqueEmMaos`
              )
            ) / 2
          ),(
            sum(
              (
                if((`cadastro`.`tamanho` = '36'), 1, 0) * `cadastro`.`EstoqueEmMaos`
              )
            ) / 2
          ),(
            sum(
              (
                if((`cadastro`.`tamanho` = '37'), 1, 0) * `cadastro`.`EstoqueEmMaos`
              )
            ) / 2
          ),(
            sum(
              (
                if((`cadastro`.`tamanho` = '38'), 1, 0) * `cadastro`.`EstoqueEmMaos`
              )
            ) / 1
          )
        )
      )
    )
  ) AS `NumLojasGCentralEmp`,
  round(avg(`cadastro`.`PrecoCorrente`), 2) AS `PrecoCorrente`,
  round(min(`cadastro`.`PrecoCorrenteMin`), 2) AS `PrecoCorrenteMin`,
  round(max(`cadastro`.`PrecoCorrenteMax`), 2) AS `PrecoCorrenteMax`,
  any_value(`cadastro`.`TipoNovo`) AS `TipoNovo`,
  max(`cadastro`.`ColAtual`) AS `UltimaColecao`
from
  `youhist`.`cadastro`
group by
  `cadastro`.`ModeloCor`;
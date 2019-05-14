ALTER ALGORITHM = UNDEFINED DEFINER = `TI` @`%` SQL SECURITY DEFINER VIEW `cadastro` AS
select
  `evalcomcdn`.`SKU` AS `SKU`,
  `evalcomcdn`.`ModeloCor` AS `ModeloCor`,
  any_value(
    if(
      (`evalcomcdn`.`Tamanho` = ''),
      'U',
      `evalcomcdn`.`Tamanho`
    )
  ) AS `tamanho`,
  any_value(`evalcomcdn`.`COL`) AS `colecao`,
  any_value(`evalcomcdn`.`Tipo`) AS `tipo`,
  sum(`evalcomcdn`.`EstoqueEmMaos`) AS `EstoqueEmMaos`,
  sum(`evalcomcdn`.`EstoqueEmTransito`) AS `EstoqueEmTransito`,
  sum(`evalcomcdn`.`UnidadesVendidasBruto`) AS `UnidadesVendidasBruto`,
  sum(`evalcomcdn`.`ValorVendasBruto`) AS `ValorVendasBruto`,
  sum(`evalcomcdn`.`UnidadesVendidasLiquido`) AS `UnidadesVendidasLiquido`,
  sum(`evalcomcdn`.`ValorVendasLiquido`) AS `valorvendasliquido`,
  avg(`evalcomcdn`.`DCEADJ`) AS `AvgDCEAjust`,
  str_to_date(any_value(`evalcomcdn`.`DataCriacao`), '%Y-%m-%d') AS `DataCriacao`,
  min(
    if(
      (
        `evalcomcdn`.`PrimeiraMovimentacao` = 'Sem movimentacao'
      ),
      NULL,
      str_to_date(`evalcomcdn`.`PrimeiraMovimentacao`, '%Y-%m-%d')
    )
  ) AS `PrimeiraMovimentacao`,
  round(max(`evalcomcdn`.`CustoUnitario`), 2) AS `CustoUnitario`,
  round(max(`evalcomcdn`.`PrecoOriginal`), 2) AS `PrecoOriginal`,
  round(max(`evalcomcdn`.`PrecoCorrente`), 2) AS `precocorrentemaxOld`,
  round(min(`evalcomcdn`.`PrecoCorrente`), 2) AS `precocorrenteminOld`,
  round(avg(`evalcomcdn`.`PrecoCorrente`), 2) AS `precocorrenteOld`,
  max(`evalcomcdn`.`CampeaoGlobal`) AS `CampeaoGlobal`,
  str_to_date(
    any_value(`evalcomcdn`.`PrimeiraDataCampGlobal`),
    '%Y-%m-%d'
  ) AS `primeiradatacampglobal`,
  str_to_date(
    any_value(`evalcomcdn`.`UltimaDataCampGlobal`),
    '%Y-%m-%d'
  ) AS `ultimadatacampglobal`,
  max(`evalcomcdn`.`NumVezesCampGlobal`) AS `numvezescampglobal`,
  max(`evalcomcdn`.`DIASATIVO`) AS `diasativo`,(
    max(`evalcomcdn`.`PrecoCorrente`) - max(`evalcomcdn`.`CustoUnitario`)
  ) AS `ganhoun`,
  sum(`evalcomcdn`.`GANHOPER`) AS `GANHOPER`,
  sum(`evalcomcdn`.`VELVDUN`) AS `velvdun`,
  sum(`evalcomcdn`.`VELGANHOPER`) AS `velganhoper`,
  sum(`evalcomcdn`.`ValorVendasBruto360`) AS `ValorVendasBruto360`,
  sum(`evalcomcdn`.`ValorVendasLiquido360`) AS `valorvendasLiquido360`,
  sum(`evalcomcdn`.`UnidadesVendidasBruto360`) AS `UnidadesVendidasBruto360`,
  sum(`evalcomcdn`.`UnidadesVendidasLiquido360`) AS `UnidadesVendidasLiquido360`,
  sum(`evalcomcdn`.`GANHOPER360`) AS `GANHOPER360`,
  sum(`evalcomcdn`.`VELVDUN360`) AS `velvdun360`,
  sum(`evalcomcdn`.`VELGANHOPER360`) AS `velganhoper360`,
  sum(
    (
      `evalcomcdn`.`EstoqueEmMaos` * `evalcomcdn`.`noCD`
    )
  ) AS `EstoqueEmMaosCD`,
  sum(
    (
      `evalcomcdn`.`EstoqueEmTransito` * `evalcomcdn`.`noCD`
    )
  ) AS `EstoqueEmTransitoCD`,
  sum(
    (
      `evalcomcdn`.`EstoqueEmMaos` * (1 - `evalcomcdn`.`noCD`)
    )
  ) AS `EstoqueEmMaosLojas`,
  sum(
    (
      `evalcomcdn`.`EstoqueEmTransito` * (1 - `evalcomcdn`.`noCD`)
    )
  ) AS `EstoqueEmTransitoLojas`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '0-CD'),
      `evalcomcdn`.`DIASATIVO`,
      0
    )
  ) AS `DiasAtivoCD`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '3-SPM'),
      `evalcomcdn`.`DIASATIVO`,
      0
    )
  ) AS `DiasAtivoSPM`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '4-TTP'),
      `evalcomcdn`.`DIASATIVO`,
      0
    )
  ) AS `DiasAtivoTTP`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '5-IBR'),
      `evalcomcdn`.`DIASATIVO`,
      0
    )
  ) AS `DiasAtivoIBR`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '6-ABC'),
      `evalcomcdn`.`DIASATIVO`,
      0
    )
  ) AS `DiasAtivoABC`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '7-CNT'),
      `evalcomcdn`.`DIASATIVO`,
      0
    )
  ) AS `DiasAtivoCNT`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '3-SPM'),
      if(
        (
          `evalcomcdn`.`PrecoCorrente` <= (0.8 * `evalcomcdn`.`PrecoOriginal`)
        ),
        1,
        0
      ),
      0
    )
  ) AS `DescontadoSPM`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '4-TTP'),
      if(
        (
          `evalcomcdn`.`PrecoCorrente` <= (0.8 * `evalcomcdn`.`PrecoOriginal`)
        ),
        1,
        0
      ),
      0
    )
  ) AS `DescontadoTTP`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '5-IBR'),
      if(
        (
          `evalcomcdn`.`PrecoCorrente` <= (0.8 * `evalcomcdn`.`PrecoOriginal`)
        ),
        1,
        0
      ),
      0
    )
  ) AS `DescontadoIBR`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '6-ABC'),
      if(
        (
          `evalcomcdn`.`PrecoCorrente` <= (0.8 * `evalcomcdn`.`PrecoOriginal`)
        ),
        1,
        0
      ),
      0
    )
  ) AS `DescontadoABC`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '7-CNT'),
      if(
        (
          `evalcomcdn`.`PrecoCorrente` <= (0.8 * `evalcomcdn`.`PrecoOriginal`)
        ),
        1,
        0
      ),
      0
    )
  ) AS `DescontadoCNT`,
  round(
    (
      100 * (
        1 - (
          max(
            if(
              (`evalcomcdn`.`LOCALC` = '3-SPM'),
              `evalcomcdn`.`PrecoCorrente`,
              0
            )
          ) / max(
            if(
              (`evalcomcdn`.`LOCALC` = '3-SPM'),
              `evalcomcdn`.`PrecoOriginal`,
              0
            )
          )
        )
      )
    ),
    0
  ) AS `DescontoSPM`,
  round(
    (
      100 * (
        1 - (
          max(
            if(
              (`evalcomcdn`.`LOCALC` = '4-TTP'),
              `evalcomcdn`.`PrecoCorrente`,
              0
            )
          ) / max(
            if(
              (`evalcomcdn`.`LOCALC` = '4-TTP'),
              `evalcomcdn`.`PrecoOriginal`,
              0
            )
          )
        )
      )
    ),
    0
  ) AS `DescontoTTP`,
  round(
    (
      100 * (
        1 - (
          max(
            if(
              (`evalcomcdn`.`LOCALC` = '5-IBR'),
              `evalcomcdn`.`PrecoCorrente`,
              0
            )
          ) / max(
            if(
              (`evalcomcdn`.`LOCALC` = '5-IBR'),
              `evalcomcdn`.`PrecoOriginal`,
              0
            )
          )
        )
      )
    ),
    0
  ) AS `DescontoIBR`,
  round(
    (
      100 * (
        1 - (
          max(
            if(
              (`evalcomcdn`.`LOCALC` = '6-ABC'),
              `evalcomcdn`.`PrecoCorrente`,
              0
            )
          ) / max(
            if(
              (`evalcomcdn`.`LOCALC` = '6-ABC'),
              `evalcomcdn`.`PrecoOriginal`,
              0
            )
          )
        )
      )
    ),
    0
  ) AS `DescontoABC`,
  round(
    (
      100 * (
        1 - (
          max(
            if(
              (`evalcomcdn`.`LOCALC` = '7-CNT'),
              `evalcomcdn`.`PrecoCorrente`,
              0
            )
          ) / max(
            if(
              (`evalcomcdn`.`LOCALC` = '7-CNT'),
              `evalcomcdn`.`PrecoOriginal`,
              0
            )
          )
        )
      )
    ),
    0
  ) AS `DescontoCNT`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '3-SPM'),
      `evalcomcdn`.`VELVDUN360`,
      0
    )
  ) AS `VelVd360SPM`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '4-TTP'),
      `evalcomcdn`.`VELVDUN360`,
      0
    )
  ) AS `VelVd360TTP`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '5-IBR'),
      `evalcomcdn`.`VELVDUN360`,
      0
    )
  ) AS `VelVd360IBR`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '6-ABC'),
      `evalcomcdn`.`VELVDUN360`,
      0
    )
  ) AS `VelVd360ABC`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '7-CNT'),
      `evalcomcdn`.`VELVDUN360`,
      0
    )
  ) AS `VelVd360CNT`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '0-CD'),
      `evalcomcdn`.`AlvoAtual`,
      NULL
    )
  ) AS `AlvoCD`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '3-SPM'),
      `evalcomcdn`.`AlvoAtual`,
      NULL
    )
  ) AS `AlvoSPM`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '4-TTP'),
      `evalcomcdn`.`AlvoAtual`,
      NULL
    )
  ) AS `AlvoTTP`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '5-IBR'),
      `evalcomcdn`.`AlvoAtual`,
      NULL
    )
  ) AS `AlvoIBR`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '6-ABC'),
      `evalcomcdn`.`AlvoAtual`,
      NULL
    )
  ) AS `AlvoABC`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '7-CNT'),
      `evalcomcdn`.`AlvoAtual`,
      NULL
    )
  ) AS `AlvoCNT`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '0-CD'),(
        to_days(now()) - to_days(
          str_to_date(`evalcomcdn`.`DataModificacaoAlvo`, '%Y-%m-%d')
        )
      ),
      NULL
    )
  ) AS `DiasModAlvoCD`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '3-SPM'),(
        to_days(now()) - to_days(
          str_to_date(`evalcomcdn`.`DataModificacaoAlvo`, '%Y-%m-%d')
        )
      ),
      NULL
    )
  ) AS `DiasModAlvoSPM`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '4-TTP'),(
        to_days(now()) - to_days(
          str_to_date(`evalcomcdn`.`DataModificacaoAlvo`, '%Y-%m-%d')
        )
      ),
      NULL
    )
  ) AS `DiasModAlvoTTP`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '5-IBR'),(
        to_days(now()) - to_days(
          str_to_date(`evalcomcdn`.`DataModificacaoAlvo`, '%Y-%m-%d')
        )
      ),
      NULL
    )
  ) AS `DiasModAlvoIBR`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '6-ABC'),(
        to_days(now()) - to_days(
          str_to_date(`evalcomcdn`.`DataModificacaoAlvo`, '%Y-%m-%d')
        )
      ),
      NULL
    )
  ) AS `DiasModAlvoABC`,
  sum(
    if(
      (`evalcomcdn`.`LOCALC` = '7-CNT'),(
        to_days(now()) - to_days(
          str_to_date(`evalcomcdn`.`DataModificacaoAlvo`, '%Y-%m-%d')
        )
      ),
      NULL
    )
  ) AS `DiasModAlvoCNT`,
  round(avg(`evalcomcdn`.`PrecoCorrente`), 2) AS `PrecoCorrente`,
  round(min(`evalcomcdn`.`PrecoCorrente`), 2) AS `PrecoCorrenteMin`,
  round(max(`evalcomcdn`.`PrecoCorrente`), 2) AS `PrecoCorrenteMax`,
  any_value(`m`.`TipoNovo`) AS `TipoNovo`,
  max(`evalcomcdn`.`ColAtual`) AS `ColAtual`
from
  (
    `youhist`.`evalcomcdn`
    left join `youhist`.`modelostipos` `m` on(
      (
        `m`.`Modelo` = left(
          `evalcomcdn`.`ModeloCor`,
          if(
            (
              left(`evalcomcdn`.`ModeloCor`, 1) between 'a'
              and 'z'
            ),
            7,
            6
          )
        )
      )
    )
  )
group by
  `evalcomcdn`.`SKU`,
  `evalcomcdn`.`ModeloCor`;
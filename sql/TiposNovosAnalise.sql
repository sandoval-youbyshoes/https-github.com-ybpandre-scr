/*
Avalicao das categorias novas (TipoNovo)
Desempenho e estoques
*/
SELECT
    Any_Value (Tipos.Tipo) as Tipo,
    Tipos.Tiponovo As TipoNovo,
    SUM(C.EstoqueEmMaos) AS EstoqueEmMaos,
    SUM(C.EstoqueEmTransito) AS EstoqueEmTransito,
    SUM(C.EstoqueEmMaos) + SUM(C.EstoqueEmTransito) AS EstoqueTotal,
    SUM(C.EstoqueEmMaosCD) AS EstoqueEmMaosCD,
    SUM(C.EstoqueEmTransitoCD) AS EstoqueEmTransitoCD,
    round(SUM(C.velganhoper), 0) AS VelGanho30,
    round(SUM(C.velvdun), 2) AS VelVdUn30,
    COUNT(DISTINCT C.Modelo) AS NumModelo,
    COUNT(DISTINCT C.ModeloCor) AS NumModeloCor,
    round(avg(C.velganhoper), 0) as VelGanho30porMC,
    round(avg(C.velvdun), 2) AS VelVdUn30porMC,
    round((SUM(C.EstoqueEmMaos) + SUM(C.EstoqueEmTransito)) / SUM(C.velvdun),
        0) As DiasDeEstoque,
    round(SUM(C.EstoqueEmMaos) / SUM(C.velvdun), 0) As DiasDeEstoqueEM,
    sum( if ((C.velvdun) > 0,
                1,
                0)) As NumMCcomVendas,
    sum( if ((C.velvdun) > 0,
                C.EstoqueEmMaos,
                0)) As EstEMMCcomVendas,
    sum( if ((C.EstoqueEmMaos + C.EstoqueEmTransito) > 0,
                C.CampeaoGlobal,
                0)) As NumCampeao,
    sum( if ((C.EstoqueEmMaos + C.EstoqueEmTransito) > 0,
                if (C.NumVezesCampGlobal > 0,
                        1,
                        0),
                    0)) as NumExCampeao,
    SUM(C.EstoqueEmMaos) * max(C.CustoUnitario) AS ValorEstoqueEmMaos,
    SUM(C.EstoqueEmTransito) * max(C.CustoUnitario) AS ValorEstoqueEmTransito, 
    (SUM(C.EstoqueEmMaos) + SUM(C.EstoqueEmTransito)) * max(C.CustoUnitario) AS ValorEstoqueTotal,
    round(sum(C.GANHOPER) / ((SUM(C.EstoqueEmMaos) + SUM(C.EstoqueEmTransito)) * max(C.CustoUnitario)),
        4) as GiroFinPer,
    sum(C.unidadesVendidasLiquido) / (SUM(C.EstoqueEmMaos) + SUM(C.EstoqueEmTransito)) as GiroOperPer,
    sum(C.unidadesVendidasLiquido) as VendasPer,
    sum(C.GANHOPER) as GanhoPer
FROM
    YouHist.modelostipos Tipos
LEFT JOIN ( -- C
    SELECT
        IF (ISNULL (`evaltable`.`ModeloCor`),
                SUBSTRING_INDEX (ANY_VALUE (`evaltable`.`SKU`),
                    '-',
                    1),
                `evaltable`.`ModeloCor`) AS `ModeloCor`,
            if (
                left (ModeloCor,
                    1) = 'F',
            Left (ModeloCor,
                7),
        Left (MOdeloCor,
            6)) as Modelo,
    ANY_VALUE (`evaltable`.`COL`) AS `colecao`,
    ANY_VALUE (`evaltable`.`Tipo`) AS `tipo`,
    SUM(`evaltable`.`EstoqueEmMaos`) AS `EstoqueEmMaos`,
    SUM(`evaltable`.`EstoqueEmTransito`) AS `EstoqueEmTransito`,
    SUM(`evaltable`.`UnidadesVendidasBruto`) AS `UnidadesVendidasBruto`,
    SUM(`evaltable`.`ValorVendasBruto`) AS `ValorVendasBruto`,
    SUM(`evaltable`.`UnidadesVendidasLiquido`) AS `UnidadesVendidasLiquido`,
    SUM(`evaltable`.`ValorVendasLiquido`) AS `valorvendasliquido`,
    AVG(`evaltable`.`DCEADJ`) AS `AvgDCEAjust`,
    STR_TO_DATE (ANY_VALUE (`evaltable`.`DataCriacao`),
        '%d/%m/%Y') AS `DataCriacao`,
    STR_TO_DATE (ANY_VALUE (`evaltable`.`PrimeiraMovimentacao`),
        '%d/%m/%Y') AS `PrimeiraMovimentacao`,
    ROUND(MAX(`evaltable`.`CustoUnitario`), 2) AS `CustoUnitario`,
    ROUND(MAX(`evaltable`.`PrecoOriginal`), 2) AS `PrecoOriginal`,
    ROUND(MAX(`evaltable`.`PrecoCorrente`), 2) AS `precocorrentemax`,
    ROUND(MIN(`evaltable`.`PrecoCorrente`), 2) AS `precocorrentemin`,
    ROUND(AVG(`evaltable`.`PrecoCorrente`), 2) AS `precocorrente`,
    MAX(`evaltable`.`CampeaoGlobal`) AS `CampeaoGlobal`,
    STR_TO_DATE (ANY_VALUE (`evaltable`.`PrimeiraDataCampGlobal`),
        '%d/%m/%Y') AS `primeiradatacampglobal`,
    STR_TO_DATE (ANY_VALUE (`evaltable`.`UltimaDataCampGlobal`),
        '%d/%m/%Y') AS `ultimadatacampglobal`,
    ANY_VALUE (`evaltable`.`NumVezesCampGlobal`) AS `numvezescampglobal`,
    MAX(`evaltable`.`DIASATIVO`) AS `diasativo`, (MAX(`evaltable`.`PrecoCorrente`) - MAX(`evaltable`.`CustoUnitario`)) AS `ganhoun`,
    SUM(`evaltable`.`GANHOPER`) AS `GANHOPER`,
    SUM(`evaltable`.`VELVDUN`) AS `velvdun`,
    SUM(`evaltable`.`VELGANHOPER`) AS `velganhoper`,
    SUM(`evaltable`.`UnidadesVendidasBruto360`) AS `UnidadesVendidasBruto360`,
    SUM(`evaltable`.`UnidadesVendidasLiquido360`) AS `UnidadesVendidasLiquido360`,
    SUM(`evaltable`.`GANHOPER360`) AS `GANHOPER360`,
    SUM(`evaltable`.`VELVDUN360`) AS `velvdun360`,
    SUM(`evaltable`.`VELGANHOPER360`) AS `velganhoper360`,
    SUM((`evaltable`.`EstoqueEmMaos` * `evaltable`.`noCD`)) AS `EstoqueEmMaosCD`,
    SUM((`evaltable`.`EstoqueEmTransito` * `evaltable`.`noCD`)) AS `EstoqueEmTransitoCD`,
    SUM((`evaltable`.`EstoqueEmMaos` * (1 - `evaltable`.`noCD`))) AS `EstoqueEmMaosLojas`,
    SUM((`evaltable`.`EstoqueEmTransito` * (1 - `evaltable`.`noCD`))) AS `EstoqueEmTransitoLojas`
FROM
    eval30x360 evaltable
WHERE (evaltable.EstoqueEmMaos + evaltable.EstoqueEmTransito) > 0 AND LocalC <> 'NA' AND LocalC = '3-SPM'
GROUP BY
     ModeloCor
     ) C Using (Modelo)
GROUP BY
   Tipos.TipoNovo
Order by
   VelVdUn30 Desc, Tipo, NumModeloCor Desc

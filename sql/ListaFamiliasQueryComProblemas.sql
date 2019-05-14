Select * FROM ( -- Wrapper
SELECT
    @mcrank := if((TipoNovo IS NULL) OR (@TipoNovo = TipoNovo),@mcrank+1,1) as MCRank,
    @Tiponovo := TipoNovo as XTipoNovo,
    Ranked.*,
--    'Path',
    concat($P(ImgPath),Ranked.ModeloCorOK,'.jpg') as ImageFile
from ( -- Ranked
    SELECT 
        MCsLocal.*,
    --    MTip.TipoNovo,
        Familias.*
    FROM ( -- MCsLocal
        SELECT
            ModeloCor                                               AS ModeloCor,
            IF (ISNULL (`ModeloCor`),
                        SUBSTRING_INDEX (ANY_VALUE (`SKU`),'-',1),
                        `ModeloCor`)                                AS ModeloCorOK,
            if (left (`ModeloCor`,1) = 'F',
                        Left (`ModeloCor`,7),
        				Left (`ModeloCor`,6))                               AS Modelo,
            count(distinct LocalC)                                  AS NumLocais,
            max(Col)                                                AS Colecao,
            sum(EstoqueEmMaos)                                      AS MCEstoqueEmMaos,
            sum(EstoqueEmTransito)                                  AS MCEstoqueEmTransito,
            round(sum(VELVDUN),2)                                   AS VelVendasUn,
            round(sum(VelGanhoPer),2)                               AS VelGanhoPer,
            MAX(`DIASATIVO`)                                        AS DiasAtivo,
            ANY_VALUE(NumVezesCampGlobal)                           AS NumVezesCampGlobal,
            MAX(CampeaoGlobal)                                      AS CampeaoGlobal
        FROM
            evaltable E
        WHERE 
            LocalC<>'NA' AND modelocor IS NOT NULL
            AND (EstoqueEmMaos + EstoqueEmTransito)>0
        --    AND LocalC='3-SPM'
            AND if($P(Local)='TODOS', 1=1,LocalC=$P(Local) ) 
        GROUP BY ModeloCor
    ) MCsLocal
    LEFT JOIN modelostipos MTip USING (Modelo)
    LEFT JOIN ( -- Familias
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
                          SUBSTRING_INDEX (ANY_VALUE (`evaltable`.`SKU`),'-',1),
                          `evaltable`.`ModeloCor`)                        AS `ModeloCor`,
                  IF (left (`evaltable`.`ModeloCor`,1) = 'F',
                      Left (`evaltable`.`ModeloCor`,7),
                      Left (`evaltable`.`ModeloCor`,6))                   as `Modelo`,
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
              WHERE (evaltable.EstoqueEmMaos + evaltable.EstoqueEmTransito) > 0 AND `evaltable`.LocalC <> 'NA' 
              --       AND `evaltable`.LocalC = '3-SPM'
                    AND if($P(Local)='TODOS', 1=1,`evaltable`.LocalC=$P(Local) ) 
              GROUP BY
                   ModeloCor
             ) C Using (Modelo)
        GROUP BY
           Tipos.TipoNovo
        ORDER BY
           VelVdUn30 DESC, Tipo, NumModeloCor DESC
    ) Familias using (TipoNovo)
    ORDER BY Familias.GiroFinPer DESC, Familias.TipoNovo ASC, MCsLocal.VelVendasUn DESC
) Ranked
ORDER BY GiroFinPer DESC, VelGanhoPer DESC
) Wrapper
WHERE
   MCRank <= $P(RankMax)
--   MCRank <= 4
ALTER ALGORITHM = UNDEFINED DEFINER = `TI` @`%` SQL SECURITY DEFINER VIEW `evalcomcdn` AS
select
  `new_eval`.`Local` AS `Local`,
  `new_eval`.`SKU` AS `SKU`,
  if(
    isnull(`new_eval`.`ModeloCor`),
    substring_index(`new_eval`.`SKU`, '-', 1),
    `new_eval`.`ModeloCor`
  ) AS `ModeloCor`,
  left(
    if(
      isnull(`new_eval`.`ModeloCor`),
      substring_index(`new_eval`.`SKU`, '-', 1),
      `new_eval`.`ModeloCor`
    ),
    if(
      (
        left(`new_eval`.`SKU`, 1) between 'a'
        and 'z'
      ),
      7,
      6
    )
  ) AS `Modelo`,
  `new_eval`.`Tamanho` AS `Tamanho`,
  `new_eval`.`Colecao` AS `Colecao`,
  `new_eval`.`Tipo` AS `Tipo`,
  `new_eval`.`DataCriacao` AS `DataCriacao`,
  `new_eval`.`PrimeiraMovimentacao` AS `PrimeiraMovimentacao`,
  `new_eval`.`Alvo` AS `AlvoAtual`,
  `new_eval`.`DataCadastroAlvo` AS `DataCadastroAlvo`,
  `new_eval`.`DataModificacaoAlvo` AS `DataModificacaoAlvo`,
  `new_eval`.`EEM` AS `EstoqueEmMaos`,
  `new_eval`.`EET` AS `EstoqueEmTransito`,
  `new_eval`.`DCE` AS `DiasComEstoque`,
  `new_eval`.`UnidVendBr` AS `UnidadesVendidasBruto`,
  `new_eval`.`ValorVendBr` AS `ValorVendasBruto`,
  `new_eval`.`UnidVendLiq` AS `UnidadesVendidasLiquido`,
  `new_eval`.`ValorVendLiq` AS `ValorVendasLiquido`,
  `new_eval`.`Saidas` AS `Saidas`,
  `new_eval`.`CustoUni` AS `CustoUnitario`,
  `new_eval`.`PrecoOriginal` AS `PrecoOriginal`,
  `new_eval`.`PrecoCorrente` AS `PrecoCorrente`,
  `new_eval`.`CampLocal` AS `CampeaoLocal`,
  `new_eval`.`PrimeiraDataCampLocal` AS `PrimeiraDataCampLocal`,
  `new_eval`.`UltimaDataCampLocal` AS `UltimaDataCampLocal`,
  `new_eval`.`VezesCampLocal` AS `NumVezesCampLocal`,
  `new_eval`.`CampGlobal` AS `CampeaoGlobal`,
  `new_eval`.`PrimeiraDataCampGlobal` AS `PrimeiraDataCampGlobal`,
  `new_eval`.`UltimaDataCampGlobal` AS `UltimaDataCampGlobal`,
  `new_eval`.`VezesCampGlobal` AS `NumVezesCampGlobal`,
  `new_eval`.`LOCALC` AS `LOCALC`,
  `new_eval`.`COL` AS `COL`,
  `new_eval`.`DCEADJ` AS `DCEADJ`,
  `new_eval`.`DIASATIVO` AS `DIASATIVO`,
  `new_eval`.`DiasUltModAlvo` AS `DiasUltModAlvo`,
  `new_eval`.`GANHOUN` AS `GANHOUN`,
  `new_eval`.`GANHOPER` AS `GANHOPER`,
  `new_eval`.`VELVDUN` AS `VELVDUN`,
  `new_eval`.`VELGANHOPER` AS `VELGANHOPER`,
  `new_eval`.`Descontado` AS `Descontado`,
  `new_eval`.`EET` AS `EstTrans2`,
  `new_eval`.`AlvoPosit` AS `AlvoPosit`,
  `new_eval`.`AlvoDef` AS `AlvoDef`,
  `new_eval`.`AlvoVazio` AS `AlvoVazio`,
  `new_eval`.`EstTotal` AS `EstTotal`,
  `new_eval`.`CustoEEM` AS `CustoEstEM`,
  `new_eval`.`CustoEET` AS `CustoEstTR`,
  `new_eval`.`CustoEstTot` AS `CustoEstTot`,
  `new_eval`.`FaltaEM` AS `FaltaEM`,
  `new_eval`.`FaltaPipe` AS `FaltaPipe`,
  `new_eval`.`ExcessoEM` AS `ExcessoEM`,
  `new_eval`.`ExcessoET` AS `ExcessoET`,
  `new_eval`.`ExcessoPipe` AS `ExcessoPipe`,
  `new_eval`.`CampSemAlvo` AS `CampSemAlvo`,
  `new_eval`.`NoAlvoModa` AS `NoAlvoModa`,
  `new_eval`.`ColAtual` AS `ColAtual`,
  `new_eval`.`CampColAtual` AS `CampColAtual`,
  `new_eval`.`CampColAtuSemAlvo` AS `CampColAtuSemAlvo`,
  `new_eval`.`RupEMCentro` AS `RupEMCentro`,
  `new_eval`.`RupPipeCentro` AS `RupPipeCentro`,
  `new_eval`.`RuptEM` AS `RuptEM`,
  `new_eval`.`RuptPipe` AS `RuptPipe`,
  `new_eval`.`EstoqueNeg` AS `EstoqueNeg`,
  `new_eval`.`noCD` AS `noCD`,
  `new_eval`.`nasLojas` AS `nasLojas`,
  `new_eval`.`FaltaPipeLojas` AS `FaltaPipeLojas`,
  `new_eval`.`ExcessoPipeLojas` AS `ExcessoPipeLojas`,
  `new_eval`.`FaltaPipeCD` AS `FaltaPipeCD`,
  `new_eval`.`ExcessoPipeCD` AS `ExcessoPipeCD`,
  `new_eval`.`EstCDEM` AS `EstCDEM`,
  `new_eval`.`EstLojasEM` AS `EstLojasEM`,
  `new_eval`.`PrecoOriginal` AS `PrecoPadrao`,
  `t`.`EEM` AS `EstEMCD`,
  `t`.`EET` AS `EstETCD`,
  `t`.`DCE` AS `DCECD`,
  `t`.`Alvo` AS `AlvoCD`,
  `new_eval_360`.`DCE` AS `DiasComEstoque360`,
  `new_eval_360`.`UnidVendBr` AS `UnidadesVendidasBruto360`,
  `new_eval_360`.`ValorVendBr` AS `ValorVendasBruto360`,
  `new_eval_360`.`UnidVendLiq` AS `UnidadesVendidasLiquido360`,
  `new_eval_360`.`ValorVendLiq` AS `ValorVendasLiquido360`,
  `new_eval_360`.`DCEADJ` AS `DCEADJ360`,
  `new_eval_360`.`DIASATIVO` AS `DIASATIVO360`,
  `new_eval_360`.`GANHOUN` AS `GANHOUN360`,
  `new_eval_360`.`GANHOPER` AS `GANHOPER360`,
  `new_eval_360`.`VELVDUN` AS `VELVDUN360`,
  `new_eval_360`.`VELGANHOPER` AS `VELGANHOPER360`
from
  (
    (
      `new_eval`
      join `new_eval` `t` on((`new_eval`.`SKU` = `t`.`SKU`))
    )
    join `new_eval_360`
  )
where
  (
    (`t`.`LOCALC` = '0-CD')
    and (`new_eval_360`.`Local` = `new_eval`.`Local`)
    and (`new_eval_360`.`SKU` = `new_eval`.`SKU`)
  );
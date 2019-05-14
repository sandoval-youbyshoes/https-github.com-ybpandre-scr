-- ----------------------------------------------------------------
--  VIEW eval30x360
-- ----------------------------------------------------------------

CREATE OR REPLACE DEFINER = `TI` @`%` SQL SECURITY DEFINER VIEW youhist.eval30x360
(
   `Local`,
   `SKU`,
   `ModeloCor`,
   `Tamanho`,
   `Colecao`,
   `Tipo`,
   `DataCriacao`,
   `PrimeiraMovimentacao`,
   `AlvoAtual`,
   `DataCadastroAlvo`,
   `DataModificacaoAlvo`,
   `EstoqueEmMaos`,
   `EstoqueEmTransito`,
   `DiasComEstoque`,
   `UnidadesVendidasBruto`,
   `ValorVendasBruto`,
   `UnidadesVendidasLiquido`,
   `ValorVendasLiquido`,
   `Saidas`,
   `CustoUnitario`,
   `PrecoOriginal`,
   `PrecoCorrente`,
   `CampeaoLocal`,
   `PrimeiraDataCampLocal`,
   `UltimaDataCampLocal`,
   `NumVezesCampLocal`,
   `CampeaoGlobal`,
   `PrimeiraDataCampGlobal`,
   `UltimaDataCampGlobal`,
   `NumVezesCampGlobal`,
   `LOCALC`,
   `COL`,
   `DCEADJ`,
   `DIASATIVO`,
   `DiasUltModAlvo`,
   `GANHOUN`,
   `GANHOPER`,
   `VELVDUN`,
   `VELGANHOPER`,
   `Descontado`,
   `EstTrans2`,
   `AlvoPosit`,
   `AlvoDef`,
   `AlvoVazio`,
   `EstTotal`,
   `CustoEstEM`,
   `CustoEstTR`,
   `CustoEstTot`,
   `FaltaEM`,
   `FaltaPipe`,
   `ExcessoEM`,
   `ExcessoET`,
   `ExcessoPipe`,
   `CampSemAlvo`,
   `NoAlvoModa`,
   `ColAtual`,
   `CampColAtual`,
   `CampColAtuSemAlvo`,
   `RupEMCentro`,
   `RupPipeCentro`,
   `RuptEM`,
   `RuptPipe`,
   `EstoqueNeg`,
   `noCD`,
   `nasLojas`,
   `FaltaPipeLojas`,
   `ExcessoPipeLojas`,
   `FaltaPipeCD`,
   `ExcessoPipeCD`,
   `EstCDEM`,
   `EstLojasEM`,
   `EstEMCD`,
   `EstETCD`,
   `DCECD`,
   `AlvoCD`,
   `PrecoPadrao`,
   `DiasComEstoque360`,
   `UnidadesVendidasBruto360`,
   `ValorVendasBruto360`,
   `UnidadesVendidasLiquido360`,
   `ValorVendasLiquido360`,
   `DCEADJ360`,
   `DIASATIVO360`,
   `GANHOUN360`,
   `GANHOPER360`,
   `VELVDUN360`,
   `VELGANHOPER360`
)
AS
   SELECT `evalcomcdn`.`Local`
             AS `Local`,
          `evalcomcdn`.`SKU`
             AS `SKU`,
          `evalcomcdn`.`ModeloCor`
             AS `ModeloCor`,
          `evalcomcdn`.`Tamanho`
             AS `Tamanho`,
          `evalcomcdn`.`Colecao`
             AS `Colecao`,
          `evalcomcdn`.`Tipo`
             AS `Tipo`,
          `evalcomcdn`.`DataCriacao`
             AS `DataCriacao`,
          `evalcomcdn`.`PrimeiraMovimentacao`
             AS `PrimeiraMovimentacao`,
          `evalcomcdn`.`AlvoAtual`
             AS `AlvoAtual`,
          `evalcomcdn`.`DataCadastroAlvo`
             AS `DataCadastroAlvo`,
          `evalcomcdn`.`DataModificacaoAlvo`
             AS `DataModificacaoAlvo`,
          `evalcomcdn`.`EstoqueEmMaos`
             AS `EstoqueEmMaos`,
          `evalcomcdn`.`EstoqueEmTransito`
             AS `EstoqueEmTransito`,
          `evalcomcdn`.`DiasComEstoque`
             AS `DiasComEstoque`,
          `evalcomcdn`.`UnidadesVendidasBruto`
             AS `UnidadesVendidasBruto`,
          `evalcomcdn`.`ValorVendasBruto`
             AS `ValorVendasBruto`,
          `evalcomcdn`.`UnidadesVendidasLiquido`
             AS `UnidadesVendidasLiquido`,
          `evalcomcdn`.`ValorVendasLiquido`
             AS `ValorVendasLiquido`,
          `evalcomcdn`.`Saidas`
             AS `Saidas`,
          `evalcomcdn`.`CustoUnitario`
             AS `CustoUnitario`,
          `evalcomcdn`.`PrecoOriginal`
             AS `PrecoOriginal`,
          `evalcomcdn`.`PrecoCorrente`
             AS `PrecoCorrente`,
          `evalcomcdn`.`CampeaoLocal`
             AS `CampeaoLocal`,
          `evalcomcdn`.`PrimeiraDataCampLocal`
             AS `PrimeiraDataCampLocal`,
          `evalcomcdn`.`UltimaDataCampLocal`
             AS `UltimaDataCampLocal`,
          `evalcomcdn`.`NumVezesCampLocal`
             AS `NumVezesCampLocal`,
          `evalcomcdn`.`CampeaoGlobal`
             AS `CampeaoGlobal`,
          `evalcomcdn`.`PrimeiraDataCampGlobal`
             AS `PrimeiraDataCampGlobal`,
          `evalcomcdn`.`UltimaDataCampGlobal`
             AS `UltimaDataCampGlobal`,
          `evalcomcdn`.`NumVezesCampGlobal`
             AS `NumVezesCampGlobal`,
          `evalcomcdn`.`LOCALC`
             AS `LOCALC`,
          `evalcomcdn`.`COL`
             AS `COL`,
          `evalcomcdn`.`DCEADJ`
             AS `DCEADJ`,
          `evalcomcdn`.`DIASATIVO`
             AS `DIASATIVO`,
          `evalcomcdn`.`DiasUltModAlvo`
             AS `DiasUltModAlvo`,
          `evalcomcdn`.`GANHOUN`
             AS `GANHOUN`,
          `evalcomcdn`.`GANHOPER`
             AS `GANHOPER`,
          `evalcomcdn`.`VELVDUN`
             AS `VELVDUN`,
          `evalcomcdn`.`VELGANHOPER`
             AS `VELGANHOPER`,
          `evalcomcdn`.`Descontado`
             AS `Descontado`,
          `evalcomcdn`.`EstTrans2`
             AS `EstTrans2`,
          `evalcomcdn`.`AlvoPosit`
             AS `AlvoPosit`,
          `evalcomcdn`.`AlvoDef`
             AS `AlvoDef`,
          `evalcomcdn`.`AlvoVazio`
             AS `AlvoVazio`,
          `evalcomcdn`.`EstTotal`
             AS `EstTotal`,
          `evalcomcdn`.`CustoEstEM`
             AS `CustoEstEM`,
          `evalcomcdn`.`CustoEstTR`
             AS `CustoEstTR`,
          `evalcomcdn`.`CustoEstTot`
             AS `CustoEstTot`,
          `evalcomcdn`.`FaltaEM`
             AS `FaltaEM`,
          `evalcomcdn`.`FaltaPipe`
             AS `FaltaPipe`,
          `evalcomcdn`.`ExcessoEM`
             AS `ExcessoEM`,
          `evalcomcdn`.`ExcessoET`
             AS `ExcessoET`,
          `evalcomcdn`.`ExcessoPipe`
             AS `ExcessoPipe`,
          `evalcomcdn`.`CampSemAlvo`
             AS `CampSemAlvo`,
          `evalcomcdn`.`NoAlvoModa`
             AS `NoAlvoModa`,
          `evalcomcdn`.`ColAtual`
             AS `ColAtual`,
          `evalcomcdn`.`CampColAtual`
             AS `CampColAtual`,
          `evalcomcdn`.`CampColAtuSemAlvo`
             AS `CampColAtuSemAlvo`,
          `evalcomcdn`.`RupEMCentro`
             AS `RupEMCentro`,
          `evalcomcdn`.`RupPipeCentro`
             AS `RupPipeCentro`,
          `evalcomcdn`.`RuptEM`
             AS `RuptEM`,
          `evalcomcdn`.`RuptPipe`
             AS `RuptPipe`,
          `evalcomcdn`.`EstoqueNeg`
             AS `EstoqueNeg`,
          `evalcomcdn`.`noCD`
             AS `noCD`,
          `evalcomcdn`.`nasLojas`
             AS `nasLojas`,
          `evalcomcdn`.`FaltaPipeLojas`
             AS `FaltaPipeLojas`,
          `evalcomcdn`.`ExcessoPipeLojas`
             AS `ExcessoPipeLojas`,
          `evalcomcdn`.`FaltaPipeCD`
             AS `FaltaPipeCD`,
          `evalcomcdn`.`ExcessoPipeCD`
             AS `ExcessoPipeCD`,
          `evalcomcdn`.`EstCDEM`
             AS `EstCDEM`,
          `evalcomcdn`.`EstLojasEM`
             AS `EstLojasEM`,
          `evalcomcdn`.`EstEMCD`
             AS `EstEMCD`,
          `evalcomcdn`.`EstETCD`
             AS `EstETCD`,
          `evalcomcdn`.`DCECD`
             AS `DCECD`,
          `evalcomcdn`.`AlvoCD`
             AS `AlvoCD`,
          `evalcomcdn`.`PrecoPadrao`
             AS `PrecoPadrao`,
          `youhist`.`new_eval_360`.`DCE`
             AS `DiasComEstoque360`,
          `youhist`.`new_eval_360`.`UnidVendBr`
             AS `UnidadesVendidasBruto360`,
          `youhist`.`new_eval_360`.`ValorVendBr`
             AS `ValorVendasBruto360`,
          `youhist`.`new_eval_360`.`UnidVendLiq`
             AS `UnidadesVendidasLiquido360`,
          `youhist`.`new_eval_360`.`ValorVendLiq`
             AS `ValorVendasLiquido360`,
          `youhist`.`new_eval_360`.`DCEADJ`
             AS `DCEADJ360`,
          `youhist`.`new_eval_360`.`DIASATIVO`
             AS `DIASATIVO360`,
          `youhist`.`new_eval_360`.`GANHOUN`
             AS `GANHOUN360`,
          `youhist`.`new_eval_360`.`GANHOPER`
             AS `GANHOPER360`,
          `youhist`.`new_eval_360`.`VELVDUN`
             AS `VELVDUN360`,
          `youhist`.`new_eval_360`.`VELGANHOPER`
             AS `VELGANHOPER360`
     FROM (
        `youhist`.`evalcomcdn`
        LEFT JOIN `youhist`.`new_eval_360`
           ON ((    (`evalcomcdn`.`SKU` = `youhist`.`new_eval_360`.`SKU`)
                AND (`evalcomcdn`.`Local` = `youhist`.`new_eval_360`.`Local`))));



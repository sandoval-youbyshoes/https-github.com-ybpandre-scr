/*
Consulta de gerar uma lista de Mix para Remocao de MCs (tipicamente remocao de Ultimos pares)
*/

SELECT   
        `EvalComCd`.`LocalC` AS `LocalC`,
		`EvalComCd`.`ModeloCor` AS `MC`,
         MIN( `EvalComCd`.`COL` )  AS `Colec`,
         MIN( `EvalComCd`.PrimeiraMovimentacao )  AS `DCriacao`,
         min( str_to_date(`EvalComCd`.PrimeiraMovimentacao,'%d/%m/%Y') ) as DDCriacao,
         COUNT( DISTINCT `EvalComCd`.`SKU` ) AS `NumSKUs`,
         sum(AlvoAtual) As Alvo,
         if(max(MaxCol.UltCol)=max(`EvalComCd`.`COL` ),ifnull(max(FM.Campeao),0),MAX( `EvalcomCD`.`CampeaoGlobal` ))  AS `Campeao`,
         ifnull(max(FM.Campeao),0) as FastMover,
         MIN( `EvalComCd`.`PrimeiraDataCampGlobal` )  AS `PDCamp`,
         MIN( `EvalComCd`.`UltimaDataCampGlobal` )  AS `UDCamp`,
         Max( `EvalComCd`.`NumVezesCampGlobal` )  AS `NumVezesCampGlobal`,
         AVG( `EvalComCd`.`DCEADJ` )  AS `AvgDCEAjust`,
         Max(DiasAtivo) AS DiasAtivo,
         Min(DiasUltModAlvo) as DiasUltModAlvo,
         SUM( `EvalComCd`.`VELVDUN` )  AS `VelVdUn`,
         SUM( `EvalComCd`.`VELGANHOPER` )  AS `VelGanhoPer`,
         sum( `EvalComCd`.UnidadesVendidasLiquido) as VdUnLq,
         sum( `EvalComCd`.GANHOPER) as GanhoPer,
         sum( `EvalComCd`.ValorVendasLiquido) as VdFnLq,
         MIN( `EvalComCd`.`Tipo` )  AS `Tipo`,
         SUM( `EvalComCd`.`EstoqueEmMaos` )  AS `EstEM`,
         SUM( `EvalComCd`.`EstoqueEmTransito` )  AS `EstET`,
         SUM( `EvalComCd`.`EstTotal` )  AS `EstTot`,
         -- if(sum(`EvalComCd`.`Descontado`)>0,1,0) As Descontado,
         Sum(EstEMCD) as EstEMCD,
         SUm(EstETCD) as EstETCD,
         max(if(Tamanho=33,1,0)*EstEMCD) as Tam33CD,
         max(if(Tamanho=34,1,0)*EstEMCD) as Tam34CD,
         max(if(Tamanho=35,1,0)*EstEMCD) as Tam35CD,
         max(if(Tamanho=36,1,0)*EstEMCD) as Tam36CD,
         max(if(Tamanho=37,1,0)*EstEMCD) as Tam37CD,
         max(if(Tamanho=38,1,0)*EstEMCD) as Tam38CD,
         max(if(Tamanho=39,1,0)*EstEMCD) as Tam39CD,
         max(if(Tamanho=40,1,0)*EstEMCD) as Tam40CD,
         max(if(Tamanho=33,1,0)*EstoqueEmMaos) as Tam33,
         max(if(Tamanho=34,1,0)*EstoqueEmMaos) as Tam34,
         max(if(Tamanho=35,1,0)*EstoqueEmMaos) as Tam35,
         max(if(Tamanho=36,1,0)*EstoqueEmMaos) as Tam36,
         max(if(Tamanho=37,1,0)*EstoqueEmMaos) as Tam37,
         max(if(Tamanho=38,1,0)*EstoqueEmMaos) as Tam38,
         max(if(Tamanho=39,1,0)*EstoqueEmMaos) as Tam39,
         max(if(Tamanho=40,1,0)*EstoqueEmMaos) as Tam40,
         sum(RuptEM) as RuptEM,
         sum(if((Tamanho between '34' and '38') AND EstoqueEmMaos>0,1,0)) as MCNumSKUsDispCent,
         sum(if((Tamanho between '34' and '38') AND EstoqueEmMaos is not null,1,0)) as MCNumSKUsCent,
         if(ifnull(min(ifnull(P.PrecoAtual,PrecoPadrao)),min(`EvalComCd`.PrecoCorrente))<0.9*min(`EvalComCd`.PrecoOriginal),1,0) As Descontado,
         greatest(0,ifnull(round(100-100*round(ifnull(min(ifnull(P.PrecoAtual,PrecoPadrao)),min(`EvalComCd`.PrecoCorrente))/min(`EvalComCd`.PrecoOriginal),1),0),0)) AS Desconto,
         round(min(ifnull(P.PrecoAtual,PrecoPadrao)),2) as PrecoAtual,
         round(min(`EvalComCd`.PrecoOriginal),2) as PrecoOriginal,
         max(UltCol) As UltCol,
         if(max(MaxCol.UltCol)=max(`EvalComCd`.`COL` ),1,0) As UltimaColecao
FROM     `EvalComCd`
LEFT JOIN PrecosLojasAtuais P USING (ModeloCor,LocalC)
Left Join (Select max(Col) As UltCol from EvalComCd where Col<>'GERAL') MaxCol on (1=1)
LEFT Join YouHist.FastMovers FM USING (ModeloCor)
WHERE    ModeloCor is not null and (PrimeiraMovimentacao <>"Sem movimentação")
GROUP BY EvalComCD.LocalC asc, EvalComCd.ModeloCor asc
HAVING   ( EstTot > 0 ) AND Colec <>'GERAL' and LocalC<>'NA'




SELECT   `EvalComCdn`.`ModeloCor` AS `MC`,
		EvalComCdn.Local,
         MIN( `EvalComCdn`.`COL` )  AS `Colec`,
         MIN( `EvalComCdn`.PrimeiraMovimentacao )  AS `DCriacao`,
         min( str_to_date(`EvalComCdn`.PrimeiraMovimentacao,'%d/%m/%Y') ) as DDCriacao,
         COUNT( DISTINCT `EvalComCdn`.`SKU` ) AS `NumSKUs`,
         sum(EvalComCdn.AlvoAtual) As Alvo,
         if(max(MaxCol.UltCol)=max(`EvalComCdn`.`COL` ),ifnull(max(FM.Campeao),0),MAX( `EvalComCdn`.`CampeaoGlobal` ))  AS `Campeao`,
         ifnull(max(FM.Campeao),0) as FastMover,
         MIN( `EvalComCdn`.`PrimeiraDataCampGlobal` )  AS `PDCamp`,
         MIN( `EvalComCdn`.`UltimaDataCampGlobal` )  AS `UDCamp`,
         Max( `EvalComCdn`.`NumVezesCampGlobal` )  AS `NumVezesCampGlobal`,
         AVG( `EvalComCdn`.`DCEADJ` )  AS `AvgDCEAjust`,
         Max(EvalComCdn.DiasAtivo) AS DiasAtivo,
         Min(EvalComCdn.DiasUltModAlvo) as DiasUltModAlvo,
         SUM( `EvalComCdn`.`VELVDUN` )  AS `VelVdUn`,
         SUM( `EvalComCdn`.`VELGANHOPER` )  AS `VelGanhoPer`,
         sum( `EvalComCdn`.UnidadesVendidasLiquido) as VdUnLq,
         sum( `EvalComCdn`.GANHOPER) as GanhoPer,
         sum( `EvalComCdn`.ValorVendasLiquido) as VdFnLq,
         MIN( `EvalComCdn`.`Tipo` )  AS `Tipo`,
         SUM( `EvalComCdn`.`EstoqueEmMaos` )  AS `EstEM`,
         SUM( `EvalComCdn`.`EstoqueEmTransito` )  AS `EstET`,
         SUM( `EvalComCdn`.`EstTotal` )  AS `EstTot`,
         -- if(sum(`EvalComCdn`.`Descontado`)>0,1,0) As Descontado,
         Sum(EvalComCdn.EstEMCD) as EstEMCD,
         SUm(EvalComCdn.EstETCD) as EstETCD,
         max(if(Tamanho=33,1,0)*EvalComCdn.EstEMCD) as Tam33CD,
         max(if(Tamanho=34,1,0)*EvalComCdn.EstEMCD) as Tam34CD,
         max(if(Tamanho=35,1,0)*EvalComCdn.EstEMCD) as Tam35CD,
         max(if(Tamanho=36,1,0)*EvalComCdn.EstEMCD) as Tam36CD,
         max(if(Tamanho=37,1,0)*EvalComCdn.EstEMCD) as Tam37CD,
         max(if(Tamanho=38,1,0)*EvalComCdn.EstEMCD) as Tam38CD,
         max(if(Tamanho=39,1,0)*EvalComCdn.EstEMCD) as Tam39CD,
         max(if(Tamanho=40,1,0)*EvalComCdn.EstEMCD) as Tam40CD,
         max(if(Tamanho=33,1,0)*EvalComCdn.EstoqueEmMaos) as Tam33,
         max(if(Tamanho=34,1,0)*EvalComCdn.EstoqueEmMaos) as Tam34,
         max(if(Tamanho=35,1,0)*EvalComCdn.EstoqueEmMaos) as Tam35,
         max(if(Tamanho=36,1,0)*EvalComCdn.EstoqueEmMaos) as Tam36,
         max(if(Tamanho=37,1,0)*EvalComCdn.EstoqueEmMaos) as Tam37,
         max(if(Tamanho=38,1,0)*EvalComCdn.EstoqueEmMaos) as Tam38,
         max(if(Tamanho=39,1,0)*EvalComCdn.EstoqueEmMaos) as Tam39,
         max(if(Tamanho=40,1,0)*EvalComCdn.EstoqueEmMaos) as Tam40,
         sum(EvalComCdn.RuptEM) as RuptEM,
         sum(if((EvalComCdn.Tamanho between '34' and '38') AND EvalComCdn.EstoqueEmMaos>0,1,0)) as MCNumSKUsDispCent,
         sum(if((EvalComCdn.Tamanho between '34' and '38') AND EvalComCdn.EstoqueEmMaos is not null,1,0)) as MCNumSKUsCent,
         if(ifnull(min(ifnull(P.PrecoAtual,PrecoPadrao)),min(`EvalComCdn`.PrecoCorrente))<0.9*min(`EvalComCdn`.PrecoOriginal),1,0) As Descontado,
         greatest(0,ifnull(round(100-100*round(ifnull(min(ifnull(P.PrecoAtual,PrecoPadrao)),min(`EvalComCdn`.PrecoCorrente))/min(`EvalComCdn`.PrecoOriginal),1),0),0)) AS Desconto,
         round(min(ifnull(P.PrecoAtual,PrecoPadrao)),2) as PrecoAtual,
         round(min(`EvalComCdn`.PrecoOriginal),2) as PrecoOriginal,
         max(UltCol) As UltCol,
         if(max(MaxCol.UltCol)=max(`EvalComCdn`.`COL` ),1,0) As UltimaColecao,
         max(TotNumSKUs) as TotNumSKUs,
         Sum(if(EvalComCdn.EstoqueEmMaos>0,1,0))/max(TotNumSKUs) as PartTotNumSKUs,
         any_value(CAD.NumLojasGCentralCD) As NumLojasGCentralCD,
         any_value(CAD.NumLojasGCentralEmp) AS NumLojasGCentralEmp,
         any_Value(CAD.NumLojas) As NumLojas,
         any_value(CAD.EstETCD33) as EstETCD33,
         any_value(CAD.EstETCD34) as EstETCD34,
         any_value(CAD.EstETCD35) as EstETCD35,
         any_value(CAD.EstETCD36) as EstETCD36,
         any_value(CAD.EstETCD37) as EstETCD37,
         any_value(CAD.EstETCD38) as EstETCD38,
         any_value(CAD.EstETCD39) as EstETCD39,
         any_value(CAD.EstETCD40) as EstETCD40
FROM     `EvalComCdn`
LEFT JOIN PrecosLojasAtuais P USING (ModeloCor,LocalC)
Left Join (Select max(Col) As UltCol from EvalComCdn where Col<>'GERAL') MaxCol on (1=1)
LEFT Join YouHist.FastMovers FM USING (ModeloCor)
LEFT Join (
select (sum(NumSKUs)) as TotNumSKUs from (
select LocalC, ModeloCor, count(SKU) as NumSKUs, sum(estoqueemmaos)+sum(estoqueemtransito) as EstTot from EvalComCdn
Where LocalC<>'NA' and ModeloCor is not Null and (PrimeiraMovimentacao <>"Sem movimentação") and Colecao<>'GERAL'
Group By  LocalC, ModeloCor
Having EstTot>0 
   AND LocalC != ''
   ) XX ) ContaSKUs on (1=1)
LEFT JOIN ( -- CAD
select
    ModeloCor as ModeloCor,
    count(distinct if(EstoqueEmMaos>0 and LocalC<>'NA' and LocalC<>'0-CD', LocalC,Null)) as NumLojas,
    sum(estoqueemmaos)+sum(estoqueemtransito) as EstoqueTotalEmp,
    sum(if(tamanho = '33' and LocalC='0-CD',EstoqueEmTransito,0)) as EstETCD33,
    sum(if(tamanho = '34' and LocalC='0-CD',EstoqueEmTransito,0)) as EstETCD34,
	sum(if(tamanho = '35' and LocalC='0-CD',EstoqueEmTransito,0)) as EstETCD35,
    sum(if(tamanho = '36' and LocalC='0-CD',EstoqueEmTransito,0)) as EstETCD36,
    sum(if(tamanho = '37' and LocalC='0-CD',EstoqueEmTransito,0)) as EstETCD37,
	sum(if(tamanho = '38' and LocalC='0-CD',EstoqueEmTransito,0)) as EstETCD38,
    sum(if(tamanho = '39' and LocalC='0-CD',EstoqueEmTransito,0)) as EstETCD39,
    sum(if(tamanho = '40' and LocalC='0-CD',EstoqueEmTransito,0)) as EstETCD40,    
     IF((COUNT(DISTINCT tamanho) <= 1),
            MAX(EstEMCD),
            GREATEST(0,
                    FLOOR(LEAST((MAX((IF((tamanho = '34'), 1, 0) * EstEMCD)) / 1),
                                    (MAX((IF((tamanho = '35'), 1, 0) * EstEMCD)) / 2),
                                    (MAX((IF((tamanho = '36'), 1, 0) * EstEMCD)) / 2),
                                    (MAX((IF((tamanho = '37'), 1, 0) * EstEMCD)) / 2),
                                    (MAX((IF((tamanho = '38'), 1, 0) * EstEMCD)) / 1))))) AS NumLojasGCentralCD,
        IF((COUNT(DISTINCT tamanho) <= 1),
            SUM(EstoqueEmMaos),
            GREATEST(0,
                    FLOOR(LEAST((SUM((IF((tamanho = '34'), 1, 0) * EstoqueEmMaos)) / 1),
                                    (SUM((IF((tamanho = '35'), 1, 0) * EstoqueEmMaos)) / 2),
                                    (SUM((IF((tamanho = '36'), 1, 0) * EstoqueEmMaos)) / 2),
                                    (SUM((IF((tamanho = '37'), 1, 0) * EstoqueEmMaos)) / 2),
                                    (SUM((IF((tamanho = '38'), 1, 0) * EstoqueEmMaos)) / 1))))) AS NumLojasGCentralEmp
From EvalComCdn
where ModeloCor is not null and (EvalComCdn.PrimeiraMovimentacao <>"Sem movimentação")
Group by ModeloCor
) CAD USING (ModeloCor)
WHERE    LOCALC!= '' and ModeloCor is not null and (EvalComCdn.PrimeiraMovimentacao <>"Sem movimentação")
GROUP BY EvalComCdn.Local,EvalComCdn.ModeloCor
HAVING   ( EstEM > 0 ) 
   AND Colec <>'GERAL'
   AND  (3>=MCNumSKUsDispCent) AND DiasAtivo>0
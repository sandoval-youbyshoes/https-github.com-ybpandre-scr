ALTER ALGORITHM = UNDEFINED DEFINER = `TI` @`%` SQL SECURITY DEFINER VIEW `ultimospares` AS
SELECT   `evalcomcdn`.`ModeloCor` AS `MC`,
         MIN( `evalcomcdn`.`COL` )  AS `Colec`,
         MIN( `evalcomcdn`.PrimeiraMovimentacao )  AS `DCriacao`,
         min( str_to_date(`evalcomcdn`.PrimeiraMovimentacao,'%d/%m/%Y') ) as DDCriacao,
         COUNT( DISTINCT `evalcomcdn`.`SKU` ) AS `NumSKUs`,
         sum(evalcomcdn.AlvoAtual) As Alvo,
         MAX( `evalcomcdn`.`CampeaoGlobal` )  AS `Campeao`,
         if(MAX(Velvdun360) > 0.55,1,0) as FastMover,
         MIN( `evalcomcdn`.`PrimeiraDataCampGlobal` )  AS `PDCamp`,
         MIN( `evalcomcdn`.`UltimaDataCampGlobal` )  AS `UDCamp`,
         Max( `evalcomcdn`.`NumVezesCampGlobal` )  AS `NumVezesCampGlobal`,
         AVG( `evalcomcdn`.`DCEADJ` )  AS `AvgDCEAjust`,
         Max(evalcomcdn.DiasAtivo) AS DiasAtivo,
         Min(evalcomcdn.DiasUltModAlvo) as DiasUltModAlvo,
         round(SUM( `evalcomcdn`.`VELVDUN` ),2)  AS `VelVdUn`,
         SUM( `evalcomcdn`.`VELGANHOPER` )  AS `VelGanhoPer`,
         sum( `evalcomcdn`.UnidadesVendidasLiquido) as VdUnLq,
         sum( `evalcomcdn`.GANHOPER) as GanhoPer,
         sum( `evalcomcdn`.ValorVendasLiquido) as VdFnLq,
         MIN( `evalcomcdn`.`Tipo` )  AS `Tipo`,
         SUM( `evalcomcdn`.`EstoqueEmMaos` )  AS `EstEM`,
         SUM( `evalcomcdn`.`EstoqueEmTransito` )  AS `EstET`,
         SUM( `evalcomcdn`.`EstTotal` )  AS `EstTot`,
         -- if(sum(`evalcomcdn`.`Descontado`)>0,1,0) As Descontado,
         Sum(evalcomcdn.EstEMCD) as EstEMCD,
         SUm(evalcomcdn.EstETCD) as EstETCD,
         max(if(Tamanho=33,1,0)*evalcomcdn.EstEMCD) as Tam33CD,
         max(if(Tamanho=34,1,0)*evalcomcdn.EstEMCD) as Tam34CD,
         max(if(Tamanho=35,1,0)*evalcomcdn.EstEMCD) as Tam35CD,
         max(if(Tamanho=36,1,0)*evalcomcdn.EstEMCD) as Tam36CD,
         max(if(Tamanho=37,1,0)*evalcomcdn.EstEMCD) as Tam37CD,
         max(if(Tamanho=38,1,0)*evalcomcdn.EstEMCD) as Tam38CD,
         max(if(Tamanho=39,1,0)*evalcomcdn.EstEMCD) as Tam39CD,
         max(if(Tamanho=40,1,0)*evalcomcdn.EstEMCD) as Tam40CD,
         max(if(Tamanho=33,1,0)*evalcomcdn.EstoqueEmMaos) as Tam33,
         max(if(Tamanho=34,1,0)*evalcomcdn.EstoqueEmMaos) as Tam34,
         max(if(Tamanho=35,1,0)*evalcomcdn.EstoqueEmMaos) as Tam35,
         max(if(Tamanho=36,1,0)*evalcomcdn.EstoqueEmMaos) as Tam36,
         max(if(Tamanho=37,1,0)*evalcomcdn.EstoqueEmMaos) as Tam37,
         max(if(Tamanho=38,1,0)*evalcomcdn.EstoqueEmMaos) as Tam38,
         max(if(Tamanho=39,1,0)*evalcomcdn.EstoqueEmMaos) as Tam39,
         max(if(Tamanho=40,1,0)*evalcomcdn.EstoqueEmMaos) as Tam40,
         sum(evalcomcdn.RuptEM) as RuptEM,
         sum(if((evalcomcdn.Tamanho between '34' and '38') AND evalcomcdn.EstoqueEmMaos>0,1,0)) as MCNumSKUsDispCent,
         sum(if((evalcomcdn.Tamanho between '34' and '38') AND evalcomcdn.EstoqueEmMaos is not null,1,0)) as MCNumSKUsCent,
         if(min(`evalcomcdn`.PrecoCorrente)<0.9*min(`evalcomcdn`.PrecoOriginal),1,0) As Descontado,
         greatest(0,ifnull(round(100-100*round(min(`evalcomcdn`.PrecoCorrente)/min(`evalcomcdn`.PrecoOriginal),1),0),0)) AS Desconto,
         round(min(PrecoCorrente),2) as PrecoAtual,
         round(min(`evalcomcdn`.PrecoOriginal),2) as PrecoOriginal,
         max(ColAtual) As UltCol,
         max(ColAtual) As UltimaColecao,
         max(TotNumSKUs) as TotNumSKUs,
         Sum(if(evalcomcdn.EstoqueEmMaos>0,1,0))/max(TotNumSKUs) as PartTotNumSKUs,
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
         any_value(CAD.EstETCD40) as EstETCD40,
            concat('z:/FotosMC/',evalcomcdn.ModeloCor,'.jpg') as ImageFile
FROM     `evalcomcdn`
LEFT Join (
select (sum(NumSKUs)) as TotNumSKUs from (
select LocalC, ModeloCor, count(SKU) as NumSKUs, sum(estoqueemmaos)+sum(estoqueemtransito) as EstTot from evalcomcdn
Where LocalC<>'NA' and ModeloCor is not Null and (PrimeiraMovimentacao <>"Sem movimentacao") and Colecao<>'GERAL'
Group By  LocalC, ModeloCor
Having EstTot>0 
   AND LocalC=(select Valor from paramsrelats where Param = 'LocalC')
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
From evalcomcdn
where ModeloCor is not null and (evalcomcdn.PrimeiraMovimentacao <>"Sem movimentacao")
Group by ModeloCor
) CAD USING (ModeloCor)
WHERE    LOCALC=(select Valor from paramsrelats where Param = 'LocalC') and ModeloCor is not null and (evalcomcdn.PrimeiraMovimentacao <>"Sem movimentacao")
GROUP BY evalcomcdn.ModeloCor
HAVING   ( EstEM > 0 ) 
   AND Colec <>'GERAL'
   AND  (3>=MCNumSKUsDispCent) AND DiasAtivo>0
/* 
   selecao de MCs a desovar
*/
Select
--    Colecao,
--    tipo,
    Count(*) as NumMCs,
    sum(EstoqueEmMaos+EstoqueEMTransito) As Estoque
	,sum(EstoqueEmMaos) As EstoqueMaos
	,sum(EstoqueEMTransito) As EstoqueTransito
    ,sum((EstoqueEmMaos+EstoqueEMTransito)*custounitario) as ValEstoque
	,sum(if(NumLojasGCentralEmp>0,1,0)) as NUmMCsGradeOK
    ,round(avg(GANHOPER360/unidadesVendidasLiquido360),2) as GanhoMedioMC
    ,round(avg(ValorVendasLiquido360-CustoUnitario*unidadesVendidasLiquido360)/count(*),2) as MargemPorMC
	,round(avg(ValorVendasLiquido360-CustoUnitario*unidadesVendidasLiquido360)/sum(if(unidadesVendidasLiquido360>0,1,0)),2) as MargemPorMCsemNoMovers
    ,sum(unidadesVendidasLiquido360) as VdUnLq360
	,sum(if(unidadesVendidasLiquido360<=0,1,0)) as NumMCsNoMover
	,sum(if(EstoqueEmMaos>0,1,0)) as NumMCsComEstEM
    ,sum(EstTot33) as EstTot33
	,sum(EstTot34) as EstTot34
	,sum(EstTot35) as EstTot35
    ,sum(EstTot36) as EstTot36
    ,sum(EstTot37) as EstTot37
    ,sum(EstTot38) as EstTot38
    ,sum(EstTot39) as EstTot39
    ,sum(EstTot40) as EstTot40
from (
SELECT 
    *
FROM
    YouHist.cadastromc
Where
(EstoqueEmMaos+EstoqueEmTransito) >0 AND DiasAtivo>365
AND Colecao <> 'GERAL'
AND ganhoper360 <= 200
AND ifnull(ganhoper,0) <=200
AND NOT (EstoqueEmMaos=0 AND EstoqueEmTransito>0) AND Modelo <> '961016'
) Source
-- Group By Colecao, Tipo
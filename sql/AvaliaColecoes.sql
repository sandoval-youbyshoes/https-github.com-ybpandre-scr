/*
Avaliacao de colecoes divididas entre FastMovers/Campeoes e Outros
*/

Select 
	Colecao
    ,Cat
    ,count(ModeloCor) As NumMCs
    ,sum(if(NumLojasGCentralCD>0,1,0)) as MCsDispCD
    ,sum(if(NumLojasGCentralEMP>0,1,0)) as MCsDispEMP

	,sum(EstoqTot) As EstTOT	
    ,sum(EstoqueEmMaos) As EstEM
	,sum(EstoqueEmTransito) As EstET
	,sum(EstoqueEmMaosCD) As EstEMCD
	,sum(EstoqueEmTransitoCD) As EstETCD

    ,round(sum(EstoqTot)/count(ModeloCor),1) as ParesporMC
    ,round(avg(NumLojasAtivo),1) as MedNumLojas
    ,sum(VdUnLq) as VdUnLq30
    ,round(sum(VelVdUnLq),2) as VelVdUnLq30
    ,round(avg(VelVdUnLq),2) as VelVdUnLq30PorMC
    
    ,round(avg(NumLojasGCentralCD),1) as NumLojasGCentralCD
    ,round(avg(NumLojasGCentralEmp),1) as NumLojasGCentralEmp
	,sum(NumLojasGCentralCD) as MCxNumLojasGCentralCD
    ,sum(NumLojasGCentralEmp) as MCxNumLojasGCentralEmp
From ( -- Lista

SELECT 
	*
FROM ( -- GRP
SELECT 
    C.ModeloCor,
    c.Colecao,
    NumLojasAtivo,
    EstoqueEmMaos,
    EstoqueEmTransito,
    EstoqueEmMaosCD,
    EstoqueEmTransitoCD,
    EstoqueEmMaos+EstoqueEmTransito as EstoqTot,
    unidadesVendidasLiquido as VdUnLq,
    velvdun as VelVdUnLq,
    NumLojasGCentralCD,
    NumLojasGCentralEmp,
    if(Colecao='2018-1-OUTINV', 
		ifnull(F.Campeao,0),
        C.CampeaoGlobal) 
        as FastMover
FROM
    cadastromc C
LEFT Join FastMovers F Using (ModeloCor)
   where (EstoqueEmMaos+EstoqueEmTransito > 0) or (unidadesVendidasLiquido>0) -- Remover esta linha se quiser ver todo o cadastro.
) GRP
JOIN ( -- Possibilidades
	SELECT 'FastMovers' AS Cat
	UNION ALL 
	SELECT 'Outros' 	AS Cat
	UNION ALL 
	SELECT 'TOTAL' 		AS Cat
) CT on (CT.Cat='TOTAL' OR (CT.Cat='FastMovers' AND GRP.FastMover=1) OR (CT.Cat='Outros' AND GRP.FastMover=0))
) Lista
Group by Colecao DESC, Cat Asc
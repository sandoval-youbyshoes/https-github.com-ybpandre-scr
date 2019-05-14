Select
	Colecao
    ,count(ModeloCor) As NumMCs
	,sum(EstoqueEmMaos) As EstEM
	,sum(EstoqueEmTransito) As EstET
	,sum(EstoqueEmTransitoCD) As EstETCD
	,sum(EstoqTot) As EstTOT
    ,sum(EstoqTot)/count(ModeloCor) as ParesporMC
    ,avg(NumLojasAtivo) as MedNumLojas
    ,sum(VdUnLq) as VdUnLq
    ,avg(NumLojasGCentralCD) as NumLojasGCentralCD
    ,avg(NumLojasGCentralEmp) as NumLojasGCentralEmp
    ,sum(if(NumLojasGCentralCD>0,1,0)) as MCsDispCD
    ,sum(if(NumLojasGCentralEMP>0,1,0)) as MCsDispEMP

	,sum(if(FastMover=1,EstoqueEmMaos,0)) as EstEMFM
	,sum(if(FastMover=1,EstoqueEmTransito,0)) as EstETFM
	,sum(if(FastMover=1,EstoqueEmTransitoCD,0)) as EstETCDFM
	,sum(if(FastMover=1,EstoqTot,0)) as EstTOTFM
    ,sum(if(FastMover=1,1,0))AS NumMCsFM
    ,sum(if(FastMover=1,EstoqTot,0))/sum(if(FastMover=1,1,0)) as ParesporMCFM
	,avg(if(FastMover=1,NumLojasAtivo,null)) as MedNumLojasFM
    ,sum(if(FastMover=1,VdUnLq,null)) as VdUnLqFM
    ,avg(if(FastMover=1,NumLojasGCentralCD,null)) as NumLojasGCentralCDFM
    ,avg(if(FastMover=1,NumLojasGCentralEmp,null)) as NumLojasGCentralEmpFM
	,sum(if(FastMover=1 AND NumLojasGCentralCD>0,1,0)) as MCsDispCDFM
    ,sum(if(FastMover=1 AND NumLojasGCentralEMP>0,1,0)) as MCsDispEMPFM
    
	,sum(if(FastMover=0,EstoqueEmMaos,0)) as EstEMnaoFM
	,sum(if(FastMover=0,EstoqueEmTransito,0)) as EstETnaoFM
	,sum(if(FastMover=0,EstoqueEmTransitoCD,0)) as EstETCDNAOFM
	,sum(if(FastMover=0,EstoqTot,0)) as EstTOTnaoFM
    ,sum(if(FastMover=0,1,0))AS NumMCsnaoFM
    ,sum(if(FastMover=0,EstoqTot,0))/sum(if(FastMover=0,1,0)) as ParesporMCnaoFM
	,avg(if(FastMover=0,NumLojasAtivo,null)) as MedNumLojasnaoFM
    ,sum(if(FastMover=0,VdUnLq,null)) as VdUnLqnaoFM
    ,avg(if(FastMover=0,NumLojasGCentralCD,null)) as NumLojasGCentralCDnaoFM
    ,avg(if(FastMover=0,NumLojasGCentralEmp,null)) as NumLojasGCentralEmpnaoFM
	,sum(if(FastMover=0 AND NumLojasGCentralCD>0,1,0)) as MCsDispCDnaoFM
    ,sum(if(FastMover=0 AND NumLojasGCentralEMP>0,1,0)) as MCsDispEMPnaoFM
From ( -- X
SELECT 
    C.ModeloCor,
    c.Colecao,
    NumLojasAtivo,
    EstoqueEmMaos,
    EstoqueEmTransito,
    EstoqueEmTransitoCD,
    EstoqueEmMaos+EstoqueEmTransito as EstoqTot,
    unidadesVendidasLiquido as VdUnLq,
    NumLojasGCentralCD,
    NumLojasGCentralEmp,
    if(Colecao='2018-1-OUTINV', 
		ifnull(F.Campeao,0),
        C.CampeaoGlobal) 
        as FastMover
FROM
    cadastromc C
LEFT Join FastMovers F Using (ModeloCor)
where EstoqueEmMaos+EstoqueEmTransito > 0
) X
Group by Colecao DESC

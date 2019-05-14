/*
 Resumo de Estoque, cobertura, mix e vendas por Colecao, campeoes e excampeoes.
*/

SELECT 
Col, ifnull(CampGlobal,"Total") As Camp, if(VezesCampGlobal>0,1,0) as FoiCamp,
 sum(EEM) as EEM, sum(EET) as EET
 , sum(EEM+EET) as EstTot
 , count(distinct Modelocor) as NumMcs 
 , count(distinct if(EEM>0,Modelocor,null)) as NumMcsEM
 , round(sum(EEM+EET)/count(distinct Modelocor),1) as ParesPorMC
 , sum(UnidVendLiq) VdUnLq
 , round(sum(EEM+EET)/sum(UnidVendLiq)*30,1) as DiasDeEstoque
 , count(distinct if(CampGlobal=1,modelocor,null)) as NumCamp, count(distinct if(VezesCampGlobal>0,modelocor,NULL)) as NumFoiCamp
 , count(distinct if(Disp.NumLojasGCentralEmp>=5,ModeloCor,Null)) as MCSCdispTodasLJEM
 , count(distinct if(Disp.NumLojasGCentralEmp>=1,ModeloCor,Null)) as MCSCdispUmaLJEM
 , count(distinct if(Disp.NumLojasGCentralEmpTot>=5,ModeloCor,Null)) as MCSCdispTodasLJETot
 , count(distinct if(Disp.NumLojasGCentralEmpTot>=1,ModeloCor,Null)) as MCSCdispUmaLJETot

FROM youhist.new_eval
Left Join 
(SELECT 
   ModeloCor,
   IF((COUNT(DISTINCT tamanho) <= 1),
            SUM(EEM),
            GREATEST(0,
                    FLOOR(LEAST(    (SUM((IF((tamanho = '34'), 1, 0) * EEM)) / 1),
                                    (SUM((IF((tamanho = '35'), 1, 0) * EEM)) / 1),
                                    (SUM((IF((tamanho = '36'), 1, 0) * EEM)) / 1),
                                    (SUM((IF((tamanho = '37'), 1, 0) * EEM)) / 1),
                                    (SUM((IF((tamanho = '38'), 1, 0) * EEM)) / 1))))) AS NumLojasGCentralEmp
	,IF((COUNT(DISTINCT tamanho) <= 1),
            SUM(EEM),
            GREATEST(0,
                    FLOOR(LEAST(    (SUM((IF((tamanho = '34'), 1, 0) * EstTotal)) / 1),
                                    (SUM((IF((tamanho = '35'), 1, 0) * EstTotal)) / 1),
                                    (SUM((IF((tamanho = '36'), 1, 0) * EstTotal)) / 1),
                                    (SUM((IF((tamanho = '37'), 1, 0) * EstTotal)) / 1),
                                    (SUM((IF((tamanho = '38'), 1, 0) * EstTotal)) / 1))))) AS NumLojasGCentralEmpTot
FROM youhist.new_eval
Group By ModeloCor
) Disp USING (ModeloCor)
Where EEM+EET >0
group by COL,CampGlobal,if(VezesCampGlobal>0,1,0)  with rollup
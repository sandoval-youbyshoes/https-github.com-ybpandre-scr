/*
Avaliacao de precos
*/
SELECT 
    TipoNovo,
    COUNT(DISTINCT modelocor) 								as NumMCs,
    ROUND(PrecoCorrente / 25, 0) * 25 						as RPrecoCorrente,
    sum( if(PrecoCorrente < (1-0.2)*PrecoOriginal,1,0) ) 	as NumDesc,
    sum(unidadesVendidasLiquido) 							as VdUnLq,
    round(sum(velVdUn),2) 									as VelVdUnLq,
    sum(EstoqueEmMaos + EstoqueEmTransito) 					as EstTot
FROm
    cadastromc
WHERE
    TipoNovo IS NOT NULL
        AND (EstoqueEmMaos + EstoqueEmTransito) > 0
GROUP BY TipoNovo , ROUND(PrecoCorrente / 25, 0) * 25


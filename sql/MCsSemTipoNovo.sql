/* 
Consulta de MCs sem TipoNovo
*/
SELECT 
   ModeloCor, if(left(ModeloCor,1) between '1' and '9', left(Modelocor,6),left(Modelocor,7)) as Modelo
   , any_value(L.TipoNome) as TipoNovo
   , any_Value(Col) as Col
   , sum(EEM+EET) as EstTot
   , sum(EEM) as EstEM
   , sum(EET) as EstET
   , sum(UnidVendLiq) as VdUnLq
FROM youhist.new_eval
left join listamcsubtipos L on (if(left(ModeloCor,1) between '1' and '9', left(Modelocor,6),left(Modelocor,7)) = L.Modelo)
where Col<>'Geral' 
group by  ModeloCor
Having EstTot > 0 AND TipoNovo is null
Order By EstTot Desc

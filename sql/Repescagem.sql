/* 
 
 Repescagem:
 
 Agrupa vendas nos ultimos 7 dias por local, MC e dia para ver se alguem teve um pico de velocidade e n~ao foi classificado como Campeao
 
*/
Select Local, Data, MC, sum(VdaUn) as VdUnDia, max(VdUn7dias) As SumVdUn7Dias, max(MinVelVdUn7dias) as SumMinVelVdUn7dias, any_value(Camp) as Camp
from (
SELECT 
    MV.Local, MV.datahora, any_value(MV.Data) as Data, MV.MC as MC, MV.Tipo, any_value(MV.Quantidade) as VdaUn, sum(MVSum.Quantidade) as VdUn7dias,
    sum(MVSum.Quantidade)/7 as MinVelVdUn7dias,
    count(distinct MVSum.Data) as NumDias, group_concat(distinct MVSUM.data SEPARATOR ',') as dias
    , any_value(NE.COl) as COl
    , any_value(NE.Camp) as Camp
FROM
    Movimentos MV
LEFT Join 
    Movimentos MVSum on (MVSum.tipo = 'V Adq Terc p Consumo' AND MV.local=MVSum.local AND MV.MC=MVSum.MC AND MV.tipo = MVSum.tipo and DateDiff(MV.data, MVSum.data) between 0 and 6)
LEFT JOIN
    (select ModeloCor, Any_Value(col) as col, any_value(CampGlobal) as Camp from new_eval group by ModeloCor) NE ON (MV.MC = NE.ModeloCor) 
WHERE
    MV.tipo = 'V Adq Terc p Consumo'
    AND MV.Local <> 'ES 01 CD'
    AND NE.COL = 'PV1819'
Group by MV.Local, MV.DataHora, MV.MC, MV.tipo
) GMV
Group by Local, Data, MC
Having SumMinVelVdUn7dias > 0.4
AND Camp <>1


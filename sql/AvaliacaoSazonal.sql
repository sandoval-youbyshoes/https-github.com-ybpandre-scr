/* 
Avaliacao Sazonal
Para a planilha: AvaliacaoSazonal.xlsx
*/
Select
   LocalC,
   Dia,
   TipoNovo,
   Sum(Quantidade) As VdasUn,
   Sum(Total) AS VendasFin,
   Count(Distinct MC) as NumMCs
From ( -- Tb
SELECT 
    Mv.*,
    ifnull(Mt.TipoNovo,'NA') As TipoNovo
FROM
    MovimentosLocalC Mv
	LEFT JOIN
    ModelosTipos Mt Using (Modelo)
WHERE Mv.Tipo = 'V Adq Terc p Consumo'
	AND LocalC<>'NA' AND LocalC <>'0-CD'
) Tb
Where MC <> '0000000'
Group By LocalC,Dia,TipoNovo
-- Having Dia >= '2016-01-01'
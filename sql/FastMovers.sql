/*
Consulta de FastMovers
Precisa ser refeita para:
- pegar os ultimos 45 dias
- calcular o preco efetivo baseado nos tickets (aparentemente nao precisa: validar)

*/
SELECT 
#ModeloCor
    C.*,
	M.TipoNovo As TipoNovo,
    round(round(1-PrecoCorrenteMin/PrecoOriginal,1)*100,0) as DescontoMax,
   round(round(1-PrecoCorrente/PrecoOriginal,1)*100,0) as DescontoAvg
FROM
    cadastromc C
LEFT JOIN modelostipos M ON M.Modelo = LEFT(C.ModeloCor, IF((LEFT(C.ModeloCor, 1) = 'F'), 7, 6))
WHERE
    velvdun > 0.555
    AND round(round(1-PrecoCorrenteMin/PrecoOriginal,1)*100,0)<=40 # DescontoMaximo = 40%
	AND ModeloCor <> ''
    AND Colecao='2018-1-OUTINV' 
ORDER BY velvdun DESC
LIMIT 30

/*
Query para gerar giros por categorias para compras da empresa

para planilha:
AUXCOMPRAS.XLSX

*/

SELECT 
    TipoNovo As Categoria,
    /* ifnull(Sum(GanhoPer),0) As GanhoEmp2, */
	ifnull(Sum(GR.Ganho),0) As GanhoEmp,
	/* ifnull(Sum(GR.VdUnLq),0) As VdUnLq, */
    sum((EstoqueEmMaos+EstoqueEmTransito)*CustoUnitario) As CustoEstqEmp,
    sum(EstoqueEmMaos+EstoqueEmTransito) as EstEmpPares,
    ifnull(Sum(GR.Ganho),0)/Sum((EstoqueEmMaos+EstoqueEmTransito)*CustoUnitario) as GiroEmp
    /* ,
    ifnull(Sum(GanhoPer),0)/Sum((EstoqueEmMaos+EstoqueEmTransito)*CustoUnitario) as GiroEmp2 */
FROM
    YouHist.cadastromc
Left Join ( /* GR : Calcula o ganho por ModeloCor na Empresa direto dos movimentos excluindo ganhos negativos */
SELECT 
    Mc AS ModeloCor,
    SUM(Quantidade) AS VdUnLq,
    SUM(Ganho) AS Ganho
FROM ( -- Movis  
    SELECT 
        ML.*,
		CU.CustoUnitario,
		Total - CU.CustoUnitario * Quantidade AS Ganho,
        greatest(0,ifnull(round(100*round(1-(Total/Quantidade)/CU.PrecoPadrao,1),0),0)) AS Desconto
    FROM
        movimentoslocalc ML
    LEFT JOIN (
		SELECT
			sku, 
			MAX(CustoUnitario) AS CustoUnitario,
			any_value(PrecoPadrao) As PrecoPadrao
		FROM
			Evaltable
		Where 
            LocalC <> 'NA' AND ModeloCor is not Null
		GROUP BY SKU
        ) CU USING (SKU)
    WHERE
        LocalC <> 'NA' AND Modelo <> '000000'
		AND Tipo = 'V Adq Terc p Consumo'
		AND Dia >= NOW() - INTERVAL 30 DAY
		AND greatest(0,ifnull(round(100*round(1-(Total/Quantidade)/CU.PrecoPadrao,1),0),0)) <= 30 /* isto 'e para filtrar os muito descontados...  mas uso o valor de venda ao inves do ganho para incluir devolucoes*/
	) Movis
GROUP BY MC
HAVING VdUnLq > 0
) GR using (ModeloCor)
GROUP BY tiponovo
Having TipoNovo is Not Null
Order by GiroEmp DESC
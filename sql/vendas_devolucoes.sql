SELECT
--    ,venda.origin_location_id
	venda.origin_company_id
    ,venda.sku
	,COALESCE(SUM(venda.product_qty),0) as unidades_vendidas_bruto
    ,COALESCE((SUM(venda.product_qty) - devolucao.product_qty), SUM(venda.product_qty)) as unidades_vendidas_liquido
    ,ROUND(SUM(venda.product_qty) * round(((ceiling((((2.2 * 1.06) * prod.cost_price) / 5)) * 5) - 0.1),2),2) as valor_total_vendas_bruto
    ,ROUND(COALESCE((SUM(venda.product_qty) - devolucao.product_qty) * round(((ceiling((((2.2 * 1.06) * prod.cost_price) / 5)) * 5) - 0.1),2), SUM(venda.product_qty) * round(((ceiling((((2.2 * 1.06) * prod.cost_price) / 5)) * 5) - 0.1),2)),2) as valor_total_vendas_liquido 
FROM
	o_moves venda
		LEFT JOIN o_moves devolucao ON (
			devolucao.sku = venda.sku
            AND devolucao.destination_location_id = venda.origin_location_id
            AND devolucao.origin_company_id != 3
			AND devolucao.fiscal_category = 'Devolução de Revenda'
		    -- AND devolucao.sku IN ('000000000000G25CH','14107800000001-37','36206000000036-35')
            -- AND devolucao.sku = '000000000000G25CH'
            -- AND devolucao.sku = '14107800000001-37'
			AND devolucao.sku = '36206000000036-35'
		)
	INNER JOIN o_products prod ON prod.sku = venda.sku
WHERE
	venda.origin_company_id != 3
	AND venda.destination_location_id = 9
	AND venda.fiscal_category = 'Revenda'
    -- AND venda.sku IN ('000000000000G25CH','14107800000001-37','36206000000036-35')
    -- AND venda.sku = '000000000000G25CH'
    -- AND venda.sku = '14107800000001-37'
    AND venda.sku = '36206000000036-35'
GROUP BY
-- 	origin_location_id
	origin_company_id
	, venda.sku
    , devolucao.product_qty
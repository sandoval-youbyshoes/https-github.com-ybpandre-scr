SELECT
	sku
    ,sum(product_qty) as dev
    , destination_location_id
FROM
	o_moves devolucao
WHERE
	devolucao.origin_company_id != 3
	AND devolucao.fiscal_category = 'Devolução de Revenda'
    AND devolucao.sku = '11702300000002-37'
--    AND devolucao.sku = '14107800000001-37'
GROUP BY
	sku
    ,destination_location_id
ORDER BY
	sku
;

SELECT
    sku
    ,SUM(product_qty)
    ,origin_location_id
FROM
	o_moves venda
WHERE
	venda.origin_company_id != 3
	AND venda.destination_location_id = 9
	AND venda.fiscal_category = 'Revenda'
    AND venda.sku = '11702300000002-37'
    -- AND venda.origin_location_id = 46
GROUP BY
 	sku
--     ,product_qty
    ,origin_location_id
ORDER BY
	sku
SELECT 
    CONCAT('ybp_product.', Modelocor) AS `items_id/product_tmpl_id/id`,
    concat(Modelocor,': Arredondamento') as `items_id/name`,
    5 as `items_id/sequence`,
    -1 as `items_id/price_discount`,
    '' as `items_id/base_pricelist_id/id`,
    2 as `items_id/base`,
    concat('Arredondados: ',curdate()) as name,
    Markup_Novo as `items_id/price_surcharge`
FROM
    markupnovo
WHERE
    selecionavel = 1
CALL `YouHist`.`o_add_moves_to_stock`((SELECT CURDATE()-INTERVAL 30 DAY), NULL);

# Limpa Tabela
TRUNCATE `YouHist`.`new_eval`;

INSERT INTO new_eval
(SELECT
	comp_name, SKU, mc, Tamanho, Colecao, Tipo, data_criacao, primeira_movimentacao, alvo_atual, IFNULL(data_cadastro_alvo, '-') AS data_cadastro_alvo,
    IFNULL(data_movimentacao_alvo, '-') AS data_movimentacao_alvo, estoque_em_maos, estoque_em_transito, estoque_em_transito_compra,
    0 as estoque_em_transito_compra_faturado, pedido_piccadilly, dias_com_estoque, unidades_vendidas_bruto, valor_total_vendas_bruto, unidades_vendidas_liquido,
    valor_total_vendas_liquido, saida, custo_unitario, preco_original, preco_corrente, 0 as campeao_local, 0 as primeira_data_campeao_local, 0 as ultima_data_campeao_local,
    0 as numero_vezes_campeao_local, IFNULL(campeao_global, 0) AS campeao_global, IFNULL(primeira_data_campeao_global, '') AS primeira_data_campeao_global,
    IFNULL(ultima_data_campeao_global, '') AS ultima_data_campeao_global, IFNULL(numero_vezes_campeao_global, 0) AS numero_vezes_campeao_global, LOCAL AS LOCAL_,
    COL as COL, DCEAJU, DIASATIVO, DiasUltModAlvo, IFNULL(ROUND((preco_corrente - custo_unitario), 2), 0.0) AS GANHOUN,
    ROUND((preco_corrente - custo_unitario) * unidades_vendidas_liquido, 2) as GANHOPER, IFNULL(ROUND(unidades_vendidas_liquido / DCEAJU, 2), 0) AS VELVDUN,
    IF(primeira_movimentacao = 'Sem movimentacao', 0, ROUND((preco_corrente - custo_unitario) * unidades_vendidas_liquido * LEAST(30, DATEDIFF(NOW(), COALESCE(primeira_movimentacao, NOW())))/ DCEAJU, 2)) AS VELGANHOPER,
    IF((preco_original * 0.71) > preco_corrente, 1, 0) AS Descontado, IF(alvo_atual > 0, 1, 0) as AlvoPosit, IF(alvo_atual = 0, 0, 1) as AlvoDef,
    IF(alvo_atual = 0, 1, 0) as AlvoVazio, (estoque_em_transito + estoque_em_maos) as EstTotal, ROUND((custo_unitario * estoque_em_maos),2) as CustoEEM,
    ROUND((custo_unitario * estoque_em_transito),2) as CustoEET, ROUND(custo_unitario * (estoque_em_transito + estoque_em_maos),2) as CustoEstTot,
    IF(estoque_em_maos < alvo_atual, alvo_atual - estoque_em_maos, 0) as FaltaEM,
    IF((estoque_em_transito + estoque_em_maos) < alvo_atual, alvo_atual - (estoque_em_transito + estoque_em_maos), 0) as FaltaPipe,
    IF(alvo_atual < estoque_em_maos, estoque_em_maos - alvo_atual, 0) as ExcessoEM,
    IF(alvo_atual <= estoque_em_maos, IF(estoque_em_transito > 0, estoque_em_transito, 0), 0) as ExcessoET,
    IF(alvo_atual < (estoque_em_transito + estoque_em_maos), (estoque_em_transito + estoque_em_maos) - alvo_atual, 0) as ExcessoPipe,
    IF(campeao_global = 1,  IF(alvo_atual > 0, 0, 1), 0) as CampSemAlvo,
    IF(campeao_global = 0, IF(colecao = (SELECT colecao FROM o_colecao ORDER BY id desc LIMIT 1), 1, 0), 0) as NoAlvoModa,
    IF(colecao = (SELECT colecao FROM o_colecao ORDER BY id desc LIMIT 1), 1, 0) as ColAtual,
    IF(campeao_global = 1, IF(colecao = (SELECT colecao FROM o_colecao ORDER BY id desc LIMIT 1), 1, 0), 0) as CampColAtual,
    IF(campeao_global = 1, IF(colecao = (SELECT colecao FROM o_colecao ORDER BY id desc LIMIT 1), IF(alvo_atual > 0, 0, 1), 0), 0) as CampColAtuSemAlvo,
    IF(estoque_em_maos <= 0, IF(primeira_movimentacao <> 'Sem movimentacao', IF(tamanho >= 34, IF(tamanho <= 39, 1, 0), 0), 0), 0) as RupEMCentro,
    IF(estoque_em_transito <= 0, IF(estoque_em_maos <= 0, IF(primeira_movimentacao <> 'Sem movimentacao', IF(tamanho >= 34, IF(tamanho <= 39, 1, 0), 0), 0), 0), 0) as RupPipeCentro,
    IF(estoque_em_maos <= 0, IF(primeira_movimentacao <> 'Sem movimentacao', 1, 0), 0) as RuptEM,
    IF(estoque_em_transito <= 0, IF(estoque_em_maos <= 0, IF(primeira_movimentacao <> 'Sem movimentacao', 1, 0), 0), 0) as RuptPipe,
    IF(estoque_em_maos < 0, 1, 0) as EstoqueNeg, IF(company_id = 3, 1, 0) as noCD,
    IF(company_id <> 3, 1, 0) as nasLojas,
    IF(company_id <> 3, IF((estoque_em_transito + estoque_em_maos) < alvo_atual, alvo_atual - (estoque_em_transito + estoque_em_maos), 0), 0) as FaltaPipeLojas,
    IF(company_id <> 3, IF(alvo_atual < (estoque_em_transito + estoque_em_maos), (estoque_em_transito + estoque_em_maos) - alvo_atual, 0), 0) as ExcessoPipeLojas,
    IF(company_id = 3, IF((estoque_em_transito + estoque_em_maos) < alvo_atual, alvo_atual - (estoque_em_transito + estoque_em_maos), 0), 0) as FaltaPipeCD,
    IF(company_id = 3, IF(alvo_atual < (estoque_em_transito + estoque_em_maos), (estoque_em_transito + estoque_em_maos) - alvo_atual, 0), 0) as ExcessoPipeCD,
    IF(company_id = 3, estoque_em_maos, 0) as EstCDEM,
    IF(company_id <> 3, estoque_em_maos, 0) as EstLojasEM
FROM
	(
	SELECT
		o_sku_loc.company_id, comp.name as comp_name, prod.sku, IF(footwear_kind NOT IN ('Meias'), SUBSTRING(prod.sku, 1, Locate('-', prod.sku) - 1), prod.sku) as mc,
        prod.size as tamanho, if(prod.collection = '', 'Geral', prod.collection) AS colecao, prod.footwear_kind as tipo, prod.create_date as data_criacao,
        COALESCE(CAST(MIN(stocks.first_move) as date), 'Sem movimentacao') as primeira_movimentacao, COALESCE(tar.qty, NULL) as alvo_atual, tar.create_date as data_cadastro_alvo,
        tar.write_date as data_movimentacao_alvo, COALESCE(on_hand.qty, 0) as estoque_em_maos,
        (COALESCE(in_transit.qty, 0) + COALESCE(in_transit_purchase.qty, 0) - COALESCE(et2.quantidade, 0)) as estoque_em_transito,
        COALESCE(in_transit_purchase.qty, 0) as estoque_em_transito_compra, CAST(COALESCE(et2.quantidade, 0) as SIGNED) as pedido_piccadilly,
        COALESCE(stock_days.days, 0) as dias_com_estoque, COALESCE(vendas.unidades_vendidas_bruto, 0) as unidades_vendidas_bruto,
        COALESCE(ROUND(vendas.valor_total_vendas_bruto, 2), 0) as valor_total_vendas_bruto, COALESCE(vendas.unidades_vendidas_liquido, 0)  as unidades_vendidas_liquido,
        COALESCE(ROUND(vendas.valor_total_vendas_liquido, 2), 0) as valor_total_vendas_liquido, IFNULL(saidas.qty, 0) as saida,
        ROUND(prod.cost_price, 2) as custo_unitario, ROUND(((ceiling(((2.2 * 1.06) * prod.cost_price) / 5) * 5) - 0.1),2) as preco_original,
        ROUND(COALESCE(MIN(IF((prices.price = '0'), NULL, prices.price)), ((ceiling(((2.2 * 1.06) * MIN(prod.cost_price)) / 5) * 5) - 0.1)),2) as preco_corrente,
        0 as campeao_local, '' as primeira_data_campeao_local, '' as ultima_data_campeao_local, 0 as numero_vezes_campeao_local,
        COALESCE(MAX(fm.Campeao), MAX(ca.campeao)) as campeao_global,
        COALESCE(MIN(fm.PrimeiraDataCampeao), MIN(ca.PrimeiraDataCampeao)) as primeira_data_campeao_global,
        COALESCE(MAX(fm.UltimaDataCampeao), MAX(ca.UltimaDataCampeao)) as ultima_data_campeao_global,
        COALESCE(MAX(fm.NumVezesCampeao), MAX(ca.NumVezesCampeao)) as numero_vezes_campeao_global,
        loc.LocalC AS LOCAL,
        if(prod.collection = '', 'Geral', prod.collection) as COL,
        IF(stock_days.days, GREATEST(MAX(COALESCE(stock_days.days, 0)), 7), 7) as DCEAJU,
        IF(MIN(stocks.first_move), DATEDIFF(NOW(), COALESCE(MIN(stocks.first_move), NOW())), 0) as DIASATIVO,
        IF(tar.write_date, DATEDIFF(NOW(), tar.write_date), 0) as DiasUltModAlvo
	FROM
		o_sku_location o_sku_loc
			INNER JOIN o_products prod ON prod.sku = o_sku_loc.sku
			INNER JOIN o_companies comp ON comp.company_id = o_sku_loc.company_id
			INNER JOIN Locais loc ON loc.company_id = comp.company_id
			LEFT JOIN o_targets tar ON tar.sku = o_sku_loc.sku AND tar.company_id = o_sku_loc.company_id
			LEFT JOIN o_prices prices ON (prices.mc = Substring(o_sku_loc.sku, 1, Locate('-', o_sku_loc.sku) - 1) AND prices.company_id = o_sku_loc.company_id)
			LEFT JOIN o_vendas vendas ON (vendas.company_id = o_sku_loc.company_id AND vendas.sku = o_sku_loc.sku)
			LEFT JOIN o_saidas saidas ON (saidas.origin_company_id = o_sku_loc.company_id AND saidas.sku = o_sku_loc.sku)
			LEFT JOIN o_stocks stocks ON stocks.company_id = o_sku_loc.company_id AND stocks.sku = o_sku_loc.sku
			LEFT JOIN o_stocks_on_hand on_hand ON on_hand.company_id = o_sku_loc.company_id AND on_hand.sku = o_sku_loc.sku
			LEFT JOIN o_stocks_in_transit in_transit ON in_transit.company_id = o_sku_loc.company_id AND in_transit.sku = o_sku_loc.sku
			LEFT JOIN o_stocks_in_transit_purchase in_transit_purchase ON in_transit_purchase.company_id = o_sku_loc.company_id AND in_transit_purchase.sku = o_sku_loc.sku
			LEFT JOIN o_stock_days stock_days ON stock_days.company_id = o_sku_loc.company_id AND stock_days.sku = o_sku_loc.sku
			LEFT JOIN o_transito_2 et2 ON et2.sku = prod.sku AND o_sku_loc.company_id = 3
			LEFT JOIN FastMovers fm ON fm.ModeloCor = Substring(prod.sku, 1, Locate('-', prod.sku) - 1)
            LEFT JOIN Campeoes_Antigos ca ON ca.ModeloCor = Substring(prod.sku, 1, Locate('-', prod.sku) - 1)
	GROUP BY
		o_sku_loc.company_id, sku
	) AS internal
);

# atualiza data e usuario que atualizou esta tabela
INSERT INTO TableUpdates
    (`NomeTabela`,`LUpdate`,`User`)
VALUES 
    ('new_eval', now(), concat(CURRENT_USER(),"-DadosOdoo")) ON DUPLICATE KEY UPDATE 
    LUpdate=now(), 
    User=CURRENT_USER();
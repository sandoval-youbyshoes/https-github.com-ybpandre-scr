DROP PROCEDURE IF EXISTS youhist.AtualizaNewEval30;
CREATE PROCEDURE youhist.`AtualizaNewEval30`()
BEGIN

CALL `YouHist`.`o_add_moves_to_stock`((SELECT CURDATE()-INTERVAL 30 DAY), NULL);

# Limpa Tabela
TRUNCATE `YouHist`.`new_eval`;

INSERT INTO new_eval
(SELECT
	comp_name, SKU, mc, Tamanho, Colecao, Tipo, data_criacao, primeira_movimentacao, alvo_atual, IFNULL(data_cadastro_alvo, '-') AS data_cadastro_alvo,
    IFNULL(data_movimentacao_alvo, '-') AS data_movimentacao_alvo, estoque_em_maos, estoque_em_transito,
    estoque_em_transito_compra,
    0 as estoque_em_transito_compra_faturado, pedido_piccadilly, dias_com_estoque, unidades_vendidas_bruto, valor_total_vendas_bruto, unidades_vendidas_liquido,
    valor_total_vendas_liquido, saida, custo_unitario, preco_original, preco_corrente, 0 as campeao_local, 0 as primeira_data_campeao_local, 0 as ultima_data_campeao_local,
    0 as numero_vezes_campeao_local, IFNULL(campeao_global, 0) AS campeao_global, IFNULL(primeira_data_campeao_global, '') AS primeira_data_campeao_global,
    IFNULL(ultima_data_campeao_global, '') AS ultima_data_campeao_global, IFNULL(numero_vezes_campeao_global, 0) AS numero_vezes_campeao_global, LOCAL AS LOCAL_,
    COL as COL, DCEAJU, DIASATIVO, DiasUltModAlvo, IFNULL(ROUND((preco_corrente - custo_unitario), 2), 0.0) AS GANHOUN,
    ROUND((preco_corrente - custo_unitario) * unidades_vendidas_liquido, 2) as GANHOPER, IFNULL((unidades_vendidas_liquido / DCEAJU), 0) AS VELVDUN,
    IF(primeira_movimentacao = 'Sem movimentacao', 0, ROUND((preco_corrente - custo_unitario) * unidades_vendidas_liquido * LEAST(30, DATEDIFF(NOW(), COALESCE(primeira_movimentacao, NOW())))/ DCEAJU, 2)) AS VELGANHOPER,
    IF((preco_original * 0.71) > preco_corrente, 1, 0) AS Descontado, IF(alvo_atual > 0, 1, 0) as AlvoPosit, IF(alvo_atual = 0, 0, 1) as AlvoDef,
    IF(alvo_atual = 0, 1, 0) as AlvoVazio, (GREATEST(estoque_em_transito,0) + GREATEST(estoque_em_maos,0)) as EstTotal, ROUND((custo_unitario * estoque_em_maos),2) as CustoEEM,
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
    o_sku_loc.company_id,
    comp.name AS comp_name,
    prod.sku,
    IF(footwear_kind NOT IN ('Meias'), substring_index(prod.sku, '-', 1), prod.sku) AS mc,
    prod.size AS tamanho,
    IF(prod.collection = '', 'Geral', prod.collection) AS colecao,
    prod.footwear_kind AS tipo,
    prod.create_date AS data_criacao,
    -- COALESCE(CAST(MIN(stocks.first_move) as date), 'Sem movimentacao') AS primeira_movimentacao,
    COALESCE(MIN(first_move.first_move), 'Sem movimentacao') AS primeira_movimentacao,
    COALESCE(tar.qty, NULL) AS alvo_atual,
    tar.create_date AS data_cadastro_alvo,
    tar.write_date AS data_movimentacao_alvo,
    COALESCE(min(osh_hand.qtde), 0) AS estoque_em_maos,
    IF(o_sku_loc.company_id = 3, COALESCE(min(osh_trans_cd.qtde), 0), (COALESCE(min(osh_trans.qtde), 0) - COALESCE(et2.quantidade, 0))) AS estoque_em_transito,
    COALESCE(MIN(in_transit_purchase.qtde), 0) AS estoque_em_transito_compra,
    CAST(COALESCE(et2.quantidade, 0) as SIGNED) AS pedido_piccadilly,
    COALESCE(stock_days.days, 0) AS dias_com_estoque,
    COALESCE(vendas.unidades_vendidas_bruto, 0) AS unidades_vendidas_bruto,
    COALESCE(ROUND(vendas.valor_total_vendas_bruto, 2), 0) AS valor_total_vendas_bruto,
    COALESCE(vendas.unidades_vendidas_liquido, 0) AS unidades_vendidas_liquido,
    COALESCE(ROUND(vendas.valor_total_vendas_liquido, 2), 0) AS valor_total_vendas_liquido,
    IFNULL(saidas.qty, 0) AS saida,
    ROUND(prod.cost_price, 2) AS custo_unitario, 
    ROUND(prod.PrOrig,2) AS preco_original,
    ROUND(COALESCE(MIN(IF((prices.price = '0'), NULL, prices.price)),prod.PrOrig),2) AS preco_corrente,
    0 AS campeao_local,
    '' AS primeira_data_campeao_local,
    '' AS ultima_data_campeao_local,
    0 AS numero_vezes_campeao_local,
    IFNULL(IF(col.id <= 9, MAX(ca.campeao), MAX(fm.Campeao)),0) AS campeao_global,
    IF(col.id <= 9, IF(MIN(ca.PrimeiraDataCampeao), MIN(ca.PrimeiraDataCampeao), null), IF( MIN(fm.PrimeiraDataCampeao), MIN(fm.PrimeiraDataCampeao), null)) AS primeira_data_campeao_global,
    IF(col.id <= 9, IF(MIN(ca.UltimaDataCampeao), MIN(ca.UltimaDataCampeao), null), IF( MIN(fm.UltimaDataCampeao), MIN(fm.UltimaDataCampeao), null)) AS ultima_data_campeao_global,
    IFNULL(IF(col.id <= 9, IF(MAX(ca.NumVezesCampeao), MAX(ca.NumVezesCampeao), null), IF(MAX(fm.NumVezesCampeao), MAX(fm.NumVezesCampeao), null)),0) AS numero_vezes_campeao_global,
    loc.LocalC AS LOCAL,
    IF(prod.collection = '', 'Geral', prod.collection) AS COL,
    IF(stock_days.days, GREATEST(MAX(COALESCE(stock_days.days, 0)), 7), 7) AS DCEAJU,
    -- IF(MIN(stocks.first_move), DATEDIFF(NOW(), COALESCE(MIN(stocks.first_move), NOW())), 0) AS DIASATIVO,
    IF(MIN(first_move.first_move), DATEDIFF(NOW(), COALESCE(MIN(first_move.first_move), NOW())), 0) AS DIASATIVO,
    IF(tar.write_date, DATEDIFF(NOW(), tar.write_date), 0) AS DiasUltModAlvo
  FROM
    o_sku_location o_sku_loc
      INNER JOIN o_products prod ON prod.sku = o_sku_loc.sku
      INNER JOIN o_companies comp ON comp.company_id = o_sku_loc.company_id
      INNER JOIN Locais loc ON loc.company_id = comp.company_id
      LEFT JOIN o_targets tar ON tar.sku = o_sku_loc.sku AND tar.company_id = o_sku_loc.company_id
      LEFT JOIN o_prices prices ON (prices.mc = substring_index(prod.sku, '-', 1) AND prices.company_id = o_sku_loc.company_id)
      LEFT JOIN o_vendas vendas ON (vendas.company_id = o_sku_loc.company_id AND vendas.sku = o_sku_loc.sku)
      LEFT JOIN o_saidas saidas ON (saidas.origin_company_id = o_sku_loc.company_id AND saidas.sku = o_sku_loc.sku)
      LEFT JOIN o_first_move first_move ON (first_move.company_id = o_sku_loc.company_id AND first_move.sku = o_sku_loc.sku)
      -- LEFT JOIN o_stocks stocks ON stocks.company_id = o_sku_loc.company_id AND stocks.sku = o_sku_loc.sku
      LEFT JOIN o_stock_history osh_hand ON (osh_hand.company_id = o_sku_loc.company_id AND osh_hand.sku = o_sku_loc.sku AND osh_hand.nome_estoque = 'Estoque')
      LEFT JOIN o_stock_history osh_trans ON (osh_trans.company_id = o_sku_loc.company_id AND osh_trans.sku = o_sku_loc.sku AND osh_trans.nome_estoque != 'Estoque')
      LEFT JOIN o_stock_history osh_trans_cd ON (osh_trans_cd.company_id = o_sku_loc.company_id AND osh_trans_cd.sku = o_sku_loc.sku AND osh_trans_cd.nome_estoque = 'Entrada' AND osh_trans_cd.company_id = 3)
      LEFT JOIN o_stock_history in_transit_purchase ON (in_transit_purchase.company_id = o_sku_loc.company_id AND in_transit_purchase.sku = o_sku_loc.sku AND in_transit_purchase.location_id = 8)
      LEFT JOIN o_stock_days stock_days ON stock_days.company_id = o_sku_loc.company_id AND stock_days.sku = o_sku_loc.sku
      LEFT JOIN o_transito_2 et2 ON et2.sku = prod.sku AND o_sku_loc.company_id = 3
      LEFT JOIN FastMovers fm ON fm.ModeloCor = substring_index(prod.sku, '-', 1)
      LEFT JOIN Campeoes_Antigos ca ON ca.ModeloCor = substring_index(prod.sku, '-', 1)
      LEFT JOIN o_colecao col ON col.colecao = prod.collection
  GROUP BY
    o_sku_loc.company_id, sku, col.id
	) AS internal
);

# atualiza data e usuario que atualizou esta tabela
INSERT INTO TableUpdates
    (`NomeTabela`,`LUpdate`,`User`)
VALUES 
    ('new_eval', now(), concat(CURRENT_USER(),"-DadosOdoo")) ON DUPLICATE KEY UPDATE 
    LUpdate=now(), 
    User=CURRENT_USER();

END;

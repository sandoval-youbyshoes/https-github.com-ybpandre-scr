DROP PROCEDURE IF EXISTS youhist.AtualizaNewEval360;
CREATE PROCEDURE youhist.`AtualizaNewEval360`()
BEGIN
   CALL `YouHist`.`o_add_moves_to_stock`(
           (SELECT CURDATE() - INTERVAL 365 DAY),
           NULL);

   # Limpa Tabela
   TRUNCATE `YouHist`.`new_eval_360`;

   INSERT INTO new_eval_360
     (SELECT comp_name,
              SKU,
              mc,
              Tamanho,
              Colecao,
              Tipo,
              data_criacao,
              primeira_movimentacao,
              alvo_atual,
              IFNULL(data_cadastro_alvo, '-')
                 AS data_cadastro_alvo,
              IFNULL(data_movimentacao_alvo, '-')
                 AS data_movimentacao_alvo,
              estoque_em_maos,
              estoque_em_transito,
              estoque_em_transito_compra,
              0
                 AS estoque_em_transito_compra_faturado,
              pedido_piccadilly,
              dias_com_estoque,
              unidades_vendidas_bruto,
              valor_total_vendas_bruto,
              unidades_vendidas_liquido,
              valor_total_vendas_liquido,
              saida,
              custo_unitario,
              preco_original,
              preco_corrente,
              0
                 AS campeao_local,
              0
                 AS primeira_data_campeao_local,
              0
                 AS ultima_data_campeao_local,
              0
                 AS numero_vezes_campeao_local,
              IFNULL(campeao_global, 0)
                 AS campeao_global,
              IFNULL(primeira_data_campeao_global, '')
                 AS primeira_data_campeao_global,
              IFNULL(ultima_data_campeao_global, '')
                 AS ultima_data_campeao_global,
              IFNULL(numero_vezes_campeao_global, 0)
                 AS numero_vezes_campeao_global,
              LOCAL
                 AS LOCAL_,
              COL
                 AS COL,
              DCEAJU,
              DIASATIVO,
              DiasUltModAlvo,
              IFNULL(ROUND((preco_corrente - custo_unitario), 2), 0.0)
                 AS GANHOUN,
              ROUND(
                   (preco_corrente - custo_unitario)
                 * unidades_vendidas_liquido,
                 2)
                 AS GANHOPER,
              IFNULL((unidades_vendidas_liquido / DCEAJU), 0)
                 AS VELVDUN,
              IF(
                 primeira_movimentacao = 'Sem movimentacao',
                 0,
                 ROUND(
                      (preco_corrente - custo_unitario)
                    * unidades_vendidas_liquido
                    * LEAST(
                         30,
                         DATEDIFF(NOW(),
                                  COALESCE(primeira_movimentacao, NOW())))
                    / DCEAJU,
                    2))
                 AS VELGANHOPER,
              IF((preco_original * 0.89) > preco_corrente, 1, 0)
                 AS Descontado,
              IF(alvo_atual > 0, 1, 0)
                 AS AlvoPosit,
              IF(alvo_atual = 0, 0, 1)
                 AS AlvoDef,
              IF(alvo_atual = 0, 1, 0)
                 AS AlvoVazio,
              (  GREATEST(estoque_em_transito, 0)
               + GREATEST(estoque_em_maos, 0))
                 AS EstTotal,
              ROUND((custo_unitario * estoque_em_maos), 2)
                 AS CustoEEM,
              ROUND((custo_unitario * estoque_em_transito), 2)
                 AS CustoEET,
              ROUND(custo_unitario * (estoque_em_transito + estoque_em_maos),
                    2)
                 AS CustoEstTot,
              IF(estoque_em_maos < alvo_atual,
                 alvo_atual - estoque_em_maos,
                 0)
                 AS FaltaEM,
              IF((estoque_em_transito + estoque_em_maos) < alvo_atual,
                 alvo_atual - (estoque_em_transito + estoque_em_maos),
                 0)
                 AS FaltaPipe,
              IF(alvo_atual < estoque_em_maos,
                 estoque_em_maos - alvo_atual,
                 0)
                 AS ExcessoEM,
              IF(alvo_atual <= estoque_em_maos,
                 IF(estoque_em_transito > 0, estoque_em_transito, 0),
                 0)
                 AS ExcessoET,
              IF(alvo_atual < (estoque_em_transito + estoque_em_maos),
                 (estoque_em_transito + estoque_em_maos) - alvo_atual,
                 0)
                 AS ExcessoPipe,
              IF(campeao_global = 1, IF(alvo_atual > 0, 0, 1), 0)
                 AS CampSemAlvo,
              IF(campeao_global = 0,
                 IF(colecao = (  SELECT colecao
                                   FROM o_colecao
                               ORDER BY id DESC
                                  LIMIT 1),
                    1,
                    0),
                 0)
                 AS NoAlvoModa,
              IF(colecao = (  SELECT colecao
                                FROM o_colecao
                            ORDER BY id DESC
                               LIMIT 1),
                 1,
                 0)
                 AS ColAtual,
              IF(campeao_global = 1,
                 IF(colecao = (  SELECT colecao
                                   FROM o_colecao
                               ORDER BY id DESC
                                  LIMIT 1),
                    1,
                    0),
                 0)
                 AS CampColAtual,
              IF(campeao_global = 1,
                 IF(colecao = (  SELECT colecao
                                   FROM o_colecao
                               ORDER BY id DESC
                                  LIMIT 1),
                    IF(alvo_atual > 0, 0, 1),
                    0),
                 0)
                 AS CampColAtuSemAlvo,
              IF(
                 estoque_em_maos <= 0,
                 IF(primeira_movimentacao <> 'Sem movimentacao',
                    IF(tamanho >= 34, IF(tamanho <= 39, 1, 0), 0),
                    0),
                 0)
                 AS RupEMCentro,
              IF(
                 estoque_em_transito <= 0,
                 IF(
                    estoque_em_maos <= 0,
                    IF(primeira_movimentacao <> 'Sem movimentacao',
                       IF(tamanho >= 34, IF(tamanho <= 39, 1, 0), 0),
                       0),
                    0),
                 0)
                 AS RupPipeCentro,
              IF(estoque_em_maos <= 0,
                 IF(primeira_movimentacao <> 'Sem movimentacao', 1, 0),
                 0)
                 AS RuptEM,
              IF(
                 estoque_em_transito <= 0,
                 IF(estoque_em_maos <= 0,
                    IF(primeira_movimentacao <> 'Sem movimentacao', 1, 0),
                    0),
                 0)
                 AS RuptPipe,
              IF(estoque_em_maos < 0, 1, 0)
                 AS EstoqueNeg,
              IF(company_id = 3, 1, 0)
                 AS noCD,
              IF(company_id <> 3, 1, 0)
                 AS nasLojas,
              IF(
                 company_id <> 3,
                 IF((estoque_em_transito + estoque_em_maos) < alvo_atual,
                    alvo_atual - (estoque_em_transito + estoque_em_maos),
                    0),
                 0)
                 AS FaltaPipeLojas,
              IF(
                 company_id <> 3,
                 IF(alvo_atual < (estoque_em_transito + estoque_em_maos),
                    (estoque_em_transito + estoque_em_maos) - alvo_atual,
                    0),
                 0)
                 AS ExcessoPipeLojas,
              IF(
                 company_id = 3,
                 IF((estoque_em_transito + estoque_em_maos) < alvo_atual,
                    alvo_atual - (estoque_em_transito + estoque_em_maos),
                    0),
                 0)
                 AS FaltaPipeCD,
              IF(
                 company_id = 3,
                 IF(alvo_atual < (estoque_em_transito + estoque_em_maos),
                    (estoque_em_transito + estoque_em_maos) - alvo_atual,
                    0),
                 0)
                 AS ExcessoPipeCD,
              IF(company_id = 3, estoque_em_maos, 0)
                 AS EstCDEM,
              IF(company_id <> 3, estoque_em_maos, 0)
                 AS EstLojasEM
         FROM (  SELECT o_sku_loc.company_id,
                        comp.name
                           AS comp_name,
                        prod.sku,
                        IF(footwear_kind NOT IN ('Meias'),
                           substring_index(prod.sku, '-', 1),
                           prod.sku)
                           AS mc,
                        prod.size
                           AS tamanho,
                        IF(prod.collection = '', 'Geral', prod.collection)
                           AS colecao,
                        prod.footwear_kind
                           AS tipo,
                        prod.create_date
                           AS data_criacao,
                        -- COALESCE(CAST(MIN(stocks.first_move) as date), 'Sem movimentacao') AS primeira_movimentacao,
                        COALESCE(MIN(first_move.first_move),
                                 'Sem movimentacao')
                           AS primeira_movimentacao,
                        COALESCE(tar.qty, NULL)
                           AS alvo_atual,
                        tar.create_date
                           AS data_cadastro_alvo,
                        tar.write_date
                           AS data_movimentacao_alvo,
                        COALESCE(min(osh_hand.qtde), 0)
                           AS estoque_em_maos,
                        IF(
                           o_sku_loc.company_id = 3,
                           COALESCE(min(osh_trans_cd.qtde), 0),
                           (  COALESCE(min(osh_trans.qtde), 0)
                            - COALESCE(et2.quantidade, 0)))
                           AS estoque_em_transito,
                        COALESCE(MIN(in_transit_purchase.qtde), 0)
                           AS estoque_em_transito_compra,
                        CAST(COALESCE(et2.quantidade, 0) AS SIGNED)
                           AS pedido_piccadilly,
                        COALESCE(stock_days.days, 0)
                           AS dias_com_estoque,
                        COALESCE(vendas.unidades_vendidas_bruto, 0)
                           AS unidades_vendidas_bruto,
                        COALESCE(ROUND(vendas.valor_total_vendas_bruto, 2), 0)
                           AS valor_total_vendas_bruto,
                        COALESCE(vendas.unidades_vendidas_liquido, 0)
                           AS unidades_vendidas_liquido,
                        COALESCE(ROUND(vendas.valor_total_vendas_liquido, 2),
                                 0)
                           AS valor_total_vendas_liquido,
                        IFNULL(saidas.qty, 0)
                           AS saida,
                        ROUND(prod.cost_price, 2)
                           AS custo_unitario,
                        ROUND(IFNULL(MAX(porig.price),prod.PrOrig), 2)
                           AS preco_original,
                        ROUND(
                           COALESCE(
                              MIN(
                                 IF((prices.price = '0'),
                                    pemp.price,
                                    prices.price)),
                              prod.PrOrig),
                           2)
                           AS preco_corrente,
                        0
                           AS campeao_local,
                        ''
                           AS primeira_data_campeao_local,
                        ''
                           AS ultima_data_campeao_local,
                        0
                           AS numero_vezes_campeao_local,
                        IFNULL(MAX(fm.champion), 0)
                           AS campeao_global,
                        MIN(fm.first_date_on)
                           AS primeira_data_campeao_global,
                        MAX(fm.last_date_off)
                           AS ultima_data_campeao_global,
                        MAX(fm.count)
                           AS numero_vezes_campeao_global,
                        loc.LocalC
                           AS LOCAL,
                        IF(prod.collection = '', 'Geral', prod.collection)
                           AS COL,
                        IF(stock_days.days,
                           GREATEST(MAX(COALESCE(stock_days.days, 0)), 7),
                           7)
                           AS DCEAJU,
                        -- IF(MIN(stocks.first_move), DATEDIFF(NOW(), COALESCE(MIN(stocks.first_move), NOW())), 0) AS DIASATIVO,
                        IF(
                           MIN(first_move.first_move),
                           DATEDIFF(
                              NOW(),
                              COALESCE(MIN(first_move.first_move), NOW())),
                           0)
                           AS DIASATIVO,
                        IF(tar.write_date, DATEDIFF(NOW(), tar.write_date), 0)
                           AS DiasUltModAlvo
                   FROM o_sku_location o_sku_loc
                        INNER JOIN o_products prod ON prod.sku = o_sku_loc.sku
                        INNER JOIN o_companies comp
                           ON comp.company_id = o_sku_loc.company_id
                        INNER JOIN Locais loc
                           ON loc.company_id = comp.company_id
                        LEFT JOIN o_targets tar
                           ON     tar.sku = o_sku_loc.sku
                              AND tar.company_id = o_sku_loc.company_id
                        LEFT JOIN o_prices prices
                           ON (    prices.mc =
                                   substring_index(prod.sku, '-', 1)
                               AND prices.company_id = o_sku_loc.company_id)
                        LEFT JOIN o_prices pemp
                           ON (    pemp.mc =
                                   substring_index(prod.sku, '-', 1)
                               AND pemp.company_id = 3)
                  LEFT JOIN o_prices porig
                           ON (    porig.mc =
                                   substring_index(prod.sku, '-', 1)
                               AND porig.company_id = 3 and (porig.name like '%Markup%' or porig.name like'%Arredondamento%'))                             
                        LEFT JOIN o_vendas vendas
                           ON (    vendas.company_id = o_sku_loc.company_id
                               AND vendas.sku = o_sku_loc.sku)
                        LEFT JOIN o_saidas saidas
                           ON (    saidas.origin_company_id =
                                   o_sku_loc.company_id
                               AND saidas.sku = o_sku_loc.sku)
                        LEFT JOIN o_first_move first_move
                           ON (    first_move.company_id = o_sku_loc.company_id
                               AND first_move.sku = o_sku_loc.sku)
                        -- LEFT JOIN o_stocks stocks ON stocks.company_id = o_sku_loc.company_id AND stocks.sku = o_sku_loc.sku
                        LEFT JOIN o_stock_history osh_hand
                           ON (    osh_hand.company_id = o_sku_loc.company_id
                               AND osh_hand.sku = o_sku_loc.sku
                               AND osh_hand.nome_estoque = 'Estoque')
                        LEFT JOIN o_stock_history osh_trans
                           ON (    osh_trans.company_id = o_sku_loc.company_id
                               AND osh_trans.sku = o_sku_loc.sku
                               AND osh_trans.nome_estoque != 'Estoque')
                        LEFT JOIN o_stock_history osh_trans_cd
                           ON (    osh_trans_cd.company_id =
                                   o_sku_loc.company_id
                               AND osh_trans_cd.sku = o_sku_loc.sku
                               AND osh_trans_cd.nome_estoque = 'Entrada'
                               AND osh_trans_cd.company_id = 3)
                        LEFT JOIN o_stock_history in_transit_purchase
                           ON (    in_transit_purchase.company_id =
                                   o_sku_loc.company_id
                               AND in_transit_purchase.sku = o_sku_loc.sku
                               AND in_transit_purchase.location_id = 8)
                        LEFT JOIN o_stock_days stock_days
                           ON     stock_days.company_id = o_sku_loc.company_id
                              AND stock_days.sku = o_sku_loc.sku
                        LEFT JOIN o_transito_2 et2
                           ON et2.sku = prod.sku AND o_sku_loc.company_id = 3
                        LEFT JOIN o_champions fm
                           ON fm.mc = substring_index(prod.sku, '-', 1)
                        LEFT JOIN o_colecao col
                           ON col.colecao = prod.collection
               GROUP BY o_sku_loc.company_id, sku, col.id) AS internal);

   # atualiza data e usuario que atualizou esta tabela
   INSERT INTO TableUpdates(`NomeTabela`, `LUpdate`, `User`)
        VALUES ('new_eval360', now(), concat(CURRENT_USER(), "-DadosOdoo"))
   ON DUPLICATE KEY UPDATE LUpdate = now(), User = CURRENT_USER();
END;

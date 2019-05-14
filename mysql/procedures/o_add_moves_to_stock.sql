DROP PROCEDURE IF EXISTS youhist.o_add_moves_to_stock;
CREATE PROCEDURE youhist.`o_add_moves_to_stock`(start_date DATE, end_date DATE)
BEGIN
  DECLARE n INT DEFAULT 0;
  DECLARE i INT DEFAULT 0;
  DECLARE dia_i DATE;
  DECLARE calc BOOL DEFAULT false;
  DECLARE min_date DATE;
  DECLARE max_date DATE; 
  SELECT date(min(date)) FROM o_moves INTO min_date;
  SELECT date(max(date)) FROM o_moves WHERE date(date) <= CURDATE() INTO max_date;
  CALL o_filldates(min_date, max_date);
  IF (start_date IS NULL) THEN SET start_date = min_date; ELSE SET start_date = STR_TO_DATE(start_date, '%Y-%m-%d'); END IF;
  IF (end_date IS NULL) THEN SET end_date = max_date; ELSE SET end_date = STR_TO_DATE(end_date, '%Y-%m-%d'); END IF;
  SELECT COUNT(*) FROM o_dias INTO n;
  START TRANSACTION;
  
  WHILE i < n DO
    SELECT dia, calculated FROM o_dias LIMIT i, 1 INTO dia_i, calc;
	IF (calc = false) THEN BEGIN
      INSERT INTO o_stocks (company_id, company_code, location_id, location_name, sku, qty, first_move, last_move) (
		SELECT company_id, company_code, location_id, location_name, sku, SUM(u.qty), date, date FROM (
          SELECT m.origin_company_id AS company_id, m.origin_company_code AS company_code, 
          m.origin_location_id AS location_id, m.origin_location_name AS location_name, 
          m.sku, -(product_qty) AS qty, m.date
          FROM o_moves AS m
          WHERE DATE(m.date) = dia_i
          AND m.origin_company_id != '' AND m.origin_location_id != '' AND m.sku != ''
          AND m.state = 'done' 
		  UNION ALL
		  SELECT m.destination_company_id AS company_id, m.destination_company_code AS company_code, 
          m.destination_location_id AS location_id, m.destination_location_name AS location_name, 
          m.sku, (product_qty) AS qty, m.date
          FROM o_moves AS m
          WHERE DATE(m.date) = dia_i
          AND m.destination_company_id != '' AND m.destination_location_id != '' AND m.sku != ''
          AND m.state = 'done'
		) AS u
	    GROUP BY company_id, company_code, location_id, location_name, sku, date)
        ON DUPLICATE KEY UPDATE qty = IF (last_move < VALUES(last_move), qty + VALUES(qty), qty), last_move = IF (last_move < VALUES(last_move), VALUES(last_move), last_move);

	  INSERT INTO o_stocks_history (company_id, company_code, location_id, location_name, sku, qty, day) (
        SELECT s.company_id, s.company_code, s.location_id, s.location_name, s.sku, s.qty as quantity, dia_i FROM o_stocks AS s where s.location_name = 'Estoque' 
      )
      ON DUPLICATE KEY UPDATE qty = VALUES(qty);

      UPDATE o_dias SET calculated = true WHERE dia = dia_i AND dia_i < CURDATE();
    END; END IF;
	SET i = i + 1;
  END WHILE;

  DELETE FROM o_sku_location WHERE true; -- Apagar essa linha, na melhor das hipoteses update
  INSERT INTO o_sku_location (
    SELECT company_id, sku, min(date) from (
      SELECT tar.company_id as company_id, tar.sku, tar.create_date AS date
      FROM o_targets tar
      UNION ALL
      SELECT moves.destination_company_id as company_id, moves.sku, moves.date
      FROM o_moves moves
    ) as tmp
    GROUP BY
    tmp.company_id,
    sku
  );

  DELETE FROM o_stocks_in_transit_purchase WHERE true;
  INSERT INTO o_stocks_in_transit_purchase (SELECT destination_company_id, sku, sum(product_qty) FROM o_moves WHERE state not in ('cancel', 'done') GROUP BY destination_company_id, sku);

  DELETE FROM o_stock_days WHERE true;
  INSERT INTO o_stock_days (SELECT company_id, sku, count(day) AS days FROM o_stocks_history WHERE qty > 0 AND day >= start_date AND day <= end_date AND location_name = 'Estoque' GROUP BY company_id, sku);

  DELETE FROM o_saidas WHERE true;
  INSERT INTO o_saidas (origin_company_id, sku, qty) (SELECT origin_company_id, sku, sum(product_qty) FROM o_moves WHERE date(date) >= start_date AND date(date) <= end_date AND origin_location_name = 'Estoque' AND sku != '' AND cancel != 't' GROUP BY origin_company_id, sku);

  DELETE FROM o_vendas WHERE true;
  INSERT INTO o_vendas
  (company_id, sku, unidades_vendidas_bruto, unidades_vendidas_liquido, valor_total_vendas_bruto, valor_total_vendas_liquido)
  SELECT
    venda.origin_company_id,
    venda.sku,
    COALESCE(SUM(venda.product_qty),0) AS unidades_vendidas_bruto,
    COALESCE((SUM(venda.product_qty) - SUM(devolucao.product_qty)), SUM(venda.product_qty)) AS unidades_vendidas_liquido,
    venda.valor_vendas AS valor_total_vendas_bruto,
    IF(devolucao.valor_devolucoes != 0, SUM(venda.valor_vendas - devolucao.valor_devolucoes), venda.valor_vendas) AS valor_total_vendas_liquido
	-- ROUND(SUM(venda.product_qty) * COALESCE(MIN(IF((prices.price = '0'), NULL, prices.price)), ((CEILING(((2.2 * 1.06) * MIN(prod.cost_price)) / 5) * 5) - 0.1)),2) AS valor_total_vendas_bruto,
    -- ROUND(COALESCE((SUM(venda.product_qty) - SUM(devolucao.product_qty)), SUM(venda.product_qty)) * COALESCE(MIN(IF((prices.price = '0'), NULL, prices.price)), ((CEILING(((2.2 * 1.06) * MIN(prod.cost_price)) / 5) * 5) - 0.1)),2) AS valor_total_vendas_liquido
  FROM (
    SELECT origin_company_id, sku, SUM(product_qty) AS product_qty, SUM(price_subtotal) AS valor_vendas
	FROM o_moves
	WHERE date(date) >= start_date AND date(date) <= end_date AND origin_company_id != 3 AND destination_location_id = 9 AND fiscal_category = 'Revenda' AND cancel != 't'
	GROUP BY origin_company_id, sku
  ) AS venda
  LEFT JOIN (
    SELECT destination_company_id, sku, SUM(product_qty) AS product_qty, SUM(price_subtotal) AS valor_devolucoes
	FROM o_moves 
	WHERE date(date) >= start_date AND date(date) <= end_date AND origin_company_id != 3 AND destination_location_id != 26 AND fiscal_category = 'Devolução de Revenda' AND cancel != 't'
	GROUP BY destination_company_id, sku
  ) AS devolucao 
  ON (devolucao.sku = venda.sku AND devolucao.destination_company_id = venda.origin_company_id)
  INNER JOIN o_products prod ON prod.sku = venda.sku
  -- LEFT JOIN o_prices prices ON (prices.mc = SUBSTR(prod.sku,1,(locate('-',prod.sku) - 1))) AND (prices.company_id = venda.origin_company_id)
  GROUP BY venda.origin_company_id, venda.sku;

  COMMIT;
END;

START TRANSACTION;
UPDATE o_dias set calculated = False where dia > '2018-08-12';
TRUNCATE TABLE o_stocks;
INSERT INTO o_stocks (company_id, company_code, location_id, location_name, sku, qty)
SELECT company_id, company_code, location_id, location_name, sku, qty FROM o_stocks_history WHERE day = '2018-08-12';
UPDATE o_stocks s
INNER JOIN (SELECT company_id, location_id, sku, SUM(u.qty), MIN(date) AS first_date FROM (
          SELECT m.origin_company_id AS company_id, m.origin_company_code AS company_code, 
          m.origin_location_id AS location_id, m.origin_location_name AS location_name, 
          m.sku, -(product_qty) AS qty, m.date
          FROM o_moves AS m
          WHERE DATE(m.date) < '2018-08-13'
          AND m.origin_company_id != '' AND m.origin_location_id != '' AND m.sku != ''
          AND m.state = 'done' 
		  UNION ALL
		  SELECT m.destination_company_id AS company_id, m.destination_company_code AS company_code, 
          m.destination_location_id AS location_id, m.destination_location_name AS location_name, 
          m.sku, (product_qty) AS qty, m.date
          FROM o_moves AS m
          WHERE DATE(m.date) < '2018-08-13'
          AND m.destination_company_id != '' AND m.destination_location_id != '' AND m.sku != ''
          AND m.state = 'done'
		) AS u
	    GROUP BY company_id, location_id, sku) AS fd
ON s.company_id = fd.company_id AND s.location_id = fd.location_id AND s.sku = fd.sku
SET s.first_move = fd.first_date;
UPDATE o_stocks s
INNER JOIN (SELECT company_id, location_id, sku, SUM(u.qty), MAX(date) AS last_date FROM (
          SELECT m.origin_company_id AS company_id, m.origin_company_code AS company_code, 
          m.origin_location_id AS location_id, m.origin_location_name AS location_name, 
          m.sku, -(product_qty) AS qty, m.date
          FROM o_moves AS m
          WHERE DATE(m.date) < '2018-08-13'
          AND m.origin_company_id != '' AND m.origin_location_id != '' AND m.sku != ''
          AND m.state = 'done' 
		  UNION ALL
		  SELECT m.destination_company_id AS company_id, m.destination_company_code AS company_code, 
          m.destination_location_id AS location_id, m.destination_location_name AS location_name, 
          m.sku, (product_qty) AS qty, m.date
          FROM o_moves AS m
          WHERE DATE(m.date) < '2018-08-13'
          AND m.destination_company_id != '' AND m.destination_location_id != '' AND m.sku != ''
          AND m.state = 'done'
		) AS u
	    GROUP BY company_id, location_id, sku) AS fd
ON s.company_id = fd.company_id AND s.location_id = fd.location_id AND s.sku = fd.sku
SET s.last_move = fd.last_date;
DELETE from o_stocks_history WHERE day > '2018-08-12';
COMMIT;

COPY (
SELECT p.default_code AS sku, pcs.champion, pcs.champion_count,
(pcs.champion_first_date_on AT TIME ZONE 'UTC' AT TIME ZONE 'America/Sao_Paulo')::date AS champion_first_date_on, 
(pcs.champion_first_date_off AT TIME ZONE 'UTC' AT TIME ZONE 'America/Sao_Paulo')::date AS champion_first_date_off,
(pcs.champion_last_date_on AT TIME ZONE 'UTC' AT TIME ZONE 'America/Sao_Paulo')::date AS champion_last_date_on, 
(pcs.champion_last_date_off AT TIME ZONE 'UTC' AT TIME ZONE 'America/Sao_Paulo')::date AS champion_last_date_off,
(pcs.create_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/Sao_Paulo')::date AS create_date, 
(pcs.write_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/Sao_Paulo')::date AS write_date
FROM product_champion_state pcs
INNER JOIN product_template pt ON pcs.product_tmpl_id = pt.id
INNER JOIN product_product p ON pt.id = p.product_tmpl_id
ORDER BY p.default_code
) TO stdout WITH (FORMAT CSV, DELIMITER ',', HEADER);
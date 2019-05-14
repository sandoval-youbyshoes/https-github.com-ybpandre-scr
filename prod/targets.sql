COPY (
SELECT c.id AS company_id, substring(pa.cnpj_cpf FROM '/(.*)-') AS company_code,
p.default_code AS sku, product_min_qty::integer as qty,
(op.create_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/Sao_Paulo')::date AS create_date,
(op.last_qty_change AT TIME ZONE 'UTC' AT TIME ZONE 'America/Sao_Paulo')::date AS write_date
FROM stock_warehouse_orderpoint op
INNER JOIN product_product p ON op.product_id = p.id
INNER JOIN res_company c ON op.company_id = c.id
INNER JOIN res_partner pa ON c.partner_id = pa.id
GROUP BY c.id, pa.cnpj_cpf, pa.cnpj_cpf, p.default_code, op.product_min_qty, op.create_date, op.last_qty_change ORDER BY pa.cnpj_cpf, p.default_code
) TO stdout WITH (FORMAT CSV, DELIMITER ',', HEADER);


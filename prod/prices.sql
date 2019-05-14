COPY (
SELECT COALESCE(promotional.company_id, rounded.company_id) AS company_id, COALESCE(promotional.company_code, rounded.company_code) AS company_code, 
COALESCE(promotional.modelo_cor, rounded.modelo_cor) AS modelo_cor, COALESCE(promotional.price_surcharge, rounded.price_surcharge) AS price, COALESCE(promotional.name, rounded.name) AS name
FROM 
(SELECT pi.name, c.id AS company_id, substring(p.cnpj_cpf FROM '/(.*)-') AS company_code,
substring(pi.name, '(.*):') AS modelo_cor, price_surcharge
FROM product_pricelist_item pi
INNER JOIN product_pricelist_version pv ON pi.price_version_id = pv.id
INNER JOIN product_pricelist pr ON pv.pricelist_id = pr.id
INNER JOIN res_company c ON pr.company_id = c.id
INNER JOIN res_partner p ON c.partner_id = p.id
WHERE substring(pi.name, '(.*):') IS NOT NULL AND pv.active = true AND price_surcharge IS NOT NULL AND c.id NOT IN (7,9)
) AS promotional
FULL JOIN
(SELECT pi.name, c.id AS company_id, substring(p.cnpj_cpf FROM '/(.*)-') AS company_code,
substring(pi.name, '(.*):') AS modelo_cor, price_surcharge
FROM product_pricelist_item pi
INNER JOIN product_pricelist_version pv ON pi.price_version_id = pv.id
INNER JOIN product_pricelist pr ON pv.pricelist_id = pr.id
CROSS JOIN res_company c
INNER JOIN res_partner p ON c.partner_id = p.id
WHERE c.id != 1 AND substring(pi.name, '(.*):') IS NOT NULL AND pv.active = true AND price_surcharge IS NOT NULL AND pr.name ilike '%arredondamento%' AND c.id NOT IN (7,9)
) AS rounded 
ON promotional.company_id = rounded.company_id AND promotional.modelo_cor = rounded.modelo_cor
ORDER BY company_id, modelo_cor
) TO stdout WITH (FORMAT CSV, DELIMITER ',', HEADER);

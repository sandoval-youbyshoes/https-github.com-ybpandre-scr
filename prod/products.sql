COPY ( SELECT p.default_code AS sku, p.id, (p.create_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/Sao_Paulo')::date AS create_date, (p.write_date AT TIME ZONE 'UTC' AT TIME ZONE 
'America/Sao_Paulo')::date AS write_date, UNACCENT(t.name) AS name, p.ean13, ip.value_float AS cost_price, ct."Collection" AS collection, CASE WHEN ct."Footwear Kind" !='' THEN UNACCENT(ct."Footwear Kind") ELSE 
UNACCENT(ct."Product Class") END AS footwear_kind, ct."Product Class" AS product_class, CASE WHEN ct."Size" !='' THEN ct."Size" ELSE ct."Onfit Size" END AS size, ct."Champion" AS champion FROM crosstab(
    'SELECT p.id, a.name::text AS attr, av.name::text AS value
	FROM product_product p
	INNER JOIN product_template t ON p.product_tmpl_id = t.id
	INNER JOIN product_attribute_value_product_product_rel avp ON p.id = avp.prod_id
	INNER JOIN product_attribute_value av ON avp.att_id = av.id
	INNER JOIN product_attribute_line_product_attribute_value_rel alav ON av.id = alav.val_id
	INNER JOIN product_attribute_line al ON alav.line_id = al.id AND t.id = al.product_tmpl_id
	INNER JOIN product_attribute a ON av.attribute_id = a.id AND al.attribute_id = a.id
	ORDER BY 1,2', -- needs to be "ORDER BY 1,2" here
	$$VALUES ('Collection'), ('Footwear Kind'), ('Product Class'), ('Size'), ('Onfit Size'), ('Champion')$$
   ) AS ct ("attr" int, "Collection" text, "Footwear Kind" text, "Product Class" text, "Size" text, "Onfit Size" text, "Champion" int) INNER JOIN product_product p ON ct.attr = p.id INNER JOIN product_template t ON 
p.product_tmpl_id = t.id INNER JOIN ir_property ip ON t.id = split_part(ip.res_id, ',', 2)::int WHERE ip.name = 'standard_price' AND ip.company_id = 1 AND p.active = true ORDER BY p.default_code
) TO stdout (FORMAT CSV, DELIMITER ',', HEADER);

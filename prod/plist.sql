COPY (
select pi.id as item_id, pi.name as name, pi.company_id, pv.id as version_id, pv.pricelist_id as pricelist from product_pricelist_item pi, product_pricelist_version pv where pv.id = pi.price_version_id and pv.active = 't'
) TO stdout WITH (FORMAT CSV, DELIMITER ',', HEADER);

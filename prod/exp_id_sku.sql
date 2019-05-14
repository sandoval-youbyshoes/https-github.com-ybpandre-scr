COPY (SELECT id, default_code FROM product_product WHERE default_code IS NOT NULL) TO '/tmp/id_sku_odoo.csv' WITH CSV;

COPY (
SELECT
CASE WHEN p.name !='' THEN p.name ELSE i.name END AS operation,
fc.name AS fiscal_category,
oc.id AS origin_company_id, substring(op.cnpj_cpf FROM '/(.*)-') AS origin_company_code, ol.id AS origin_location_id, ol.name AS origin_location_name,
dc.id AS destination_company_id, substring(dp.cnpj_cpf FROM '/(.*)-') AS destination_company_code, dl.id AS destination_location_id, dl.name AS destination_location_name,
pr.default_code AS sku,
m.product_qty::integer, m.state, m.date AT TIME ZONE 'UTC' AT TIME ZONE 'America/Sao_Paulo',
CASE WHEN venda.name IS NOT NULL THEN venda.name ELSE po.name END AS pos_order_name,
po.canceled_order AS cancel,
j.name AS payment_form,
CASE WHEN venda.price_unit IS NOT NULL THEN venda.price_unit ELSE pol.price_unit END AS price_unit,
CASE WHEN venda.discount IS NOT NULL THEN venda.discount ELSE pol.discount END AS discount,
CASE WHEN venda.price_unit IS NOT NULL THEN venda.price_unit * m.product_qty WHEN dev.price_unit IS NOT NULL THEN dev.price_unit * m.product_qty ELSE pol.price_subtotal END AS price_subtotal,
CASE WHEN venda.cnpj_cpf IS NOT NULL THEN venda.cnpj_cpf ELSE pp.cnpj_cpf END AS client
FROM stock_move m
INNER JOIN stock_location ol ON m.location_id = ol.id
LEFT JOIN res_company oc ON ol.company_id = oc.id
LEFT JOIN res_partner op ON oc.partner_id = op.id
INNER JOIN stock_location dl ON m.location_dest_id = dl.id
LEFT JOIN res_company dc ON dl.company_id = dc.id
LEFT JOIN res_partner dp ON dc.partner_id = dp.id
INNER JOIN product_product pr ON m.product_id = pr.id
LEFT JOIN stock_picking p ON m.picking_id = p.id
LEFT JOIN l10n_br_account_fiscal_category fc ON p.fiscal_category_id = fc.id
LEFT JOIN (
  SELECT stock_picking.name, res_partner.cnpj_cpf, lm.stock_move_id, l.price_unit, l.discount FROM stock_picking
  INNER JOIN res_partner ON stock_picking.partner_id = res_partner.id
  INNER JOIN l10n_br_account_fiscal_category ifc ON stock_picking.fiscal_category_id = ifc.id
  INNER JOIN account_invoice_stock_picking_rel ip ON stock_picking.id = ip.stock_picking_id
  INNER JOIN account_invoice ai ON ip.account_invoice_id = ai.id
  INNER JOIN account_invoice_line l ON ai.id = l.invoice_id
  INNER JOIN account_invoice_line_stock_move_rel lm ON lm.account_invoice_line_id = l.id
  WHERE ifc.name = 'Revenda' AND ai.state IN ('open', 'paid')
) AS venda ON m.id = venda.stock_move_id
LEFT JOIN (
  SELECT lm.stock_move_id, l.price_unit FROM stock_picking
  INNER JOIN l10n_br_account_fiscal_category ifc ON stock_picking.fiscal_category_id = ifc.id
  INNER JOIN account_invoice_stock_picking_rel ip ON stock_picking.id = ip.stock_picking_id
  INNER JOIN account_invoice ai ON ip.account_invoice_id = ai.id
  INNER JOIN account_invoice_line l ON ai.id = l.invoice_id
  INNER JOIN account_invoice_line_stock_move_rel lm ON lm.account_invoice_line_id = l.id
  WHERE ifc.name = 'Devolução de Revenda' AND ai.state IN ('open', 'paid')
) AS dev ON m.id = dev.stock_move_id
LEFT JOIN stock_inventory i ON m.inventory_id = i.id
LEFT JOIN pos_order po ON p.id = po.picking_id
LEFT JOIN pos_order_line pol ON pol.order_id = po.id AND m.product_id = pol.product_id
LEFT JOIN res_partner pp ON po.partner_id = pp.id
LEFT JOIN (
    SELECT MIN(id) AS id, pos_statement_id AS order_id, MIN(journal_id) AS journal_id
    FROM account_bank_statement_line bsl
    GROUP BY pos_statement_id
) AS payment ON po.id = payment.order_id
LEFT JOIN account_journal j ON payment.journal_id = j.id
WHERE pr.default_code IS NOT NULL
  AND (
    m.state = 'done'
    OR (p.company_id = 3 AND p.invoice_state = 'none' AND p.number_of_packages = 1)
    OR ((fc.name = 'Entrada' OR p.company_id = 3) AND p.fiscal_category_id = 10 AND m.state NOT IN ('cancel', 'done'))
  )
ORDER BY m.date
) TO stdout WITH (FORMAT CSV, DELIMITER ',', HEADER);


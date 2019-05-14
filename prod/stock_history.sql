COPY (
(
    SELECT
        *
    FROM
        (
        SELECT
            sl.name,
            sh.company_id,
            sh.location_id,
            pp.default_code,
            SUM(quantity) as qtde
        FROM
            stock_history sh
                    INNER JOIN product_product pp ON pp.id = sh.product_id
                    INNER JOIN stock_location sl ON sl.id = sh.location_id
        GROUP BY
            sh.company_id,
            sh.location_id,
            pp.default_code,
            sl.name
        ) as tmp
    WHERE tmp.qtde > 0
)
UNION
(
    SELECT
        'Entrada' as name,
        3 as company_id,
        26 as location_id,
        tmp.default_code,
        tmp.qtde
    FROM(
        SELECT
            DISTINCT on (pp.default_code)
            pp.default_code,
            sum(product_qty) as qtde
        FROM
            stock_move sm
                INNER JOIN product_product pp ON pp.id = sm.product_id
        WHERE
            picking_id IN(
                SELECT
                    sp.id
                FROM
                    stock_picking sp
                        LEFT JOIN res_partner rp ON (rp.id = sp.partner_id)
                WHERE
                    (picking_type_id = 7 AND state NOT IN ('done', 'cancel') AND sp.invoice_state = 'invoiced')
		    OR (picking_type_id = 7  and state = 'draft')
            )
        GROUP BY
            pp.default_code
    ) AS tmp
)
) TO stdout WITH (FORMAT CSV, DELIMITER ',', HEADER);

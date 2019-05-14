COPY (
SELECT
    bsl.id,
    po.name AS ORDER,
    UNACCENT(j.name) AS payment_form,
    bsl.amount,
    (bsl.create_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/Sao_Paulo')::date AS data,
    to_char(bsl.create_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/Sao_Paulo', 'HH24:MI:SS') as hora
FROM
    account_bank_statement_line bsl
        INNER JOIN pos_order po ON bsl.pos_statement_id = po.id
        INNER JOIN account_journal j ON bsl.journal_id = j.id
WHERE
    po.canceled_order != TRUE
) TO stdout WITH (FORMAT CSV, DELIMITER ',', HEADER);

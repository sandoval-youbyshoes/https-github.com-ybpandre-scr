COPY (
SELECT c.id AS id, substring(p.cnpj_cpf FROM '/(.*)-') AS code, unaccent(c.name) as name,
c.phone, co.name AS country, st.name AS state, ci.name AS city, p.district, p.street, p.street2, p.number, p.zip, p.cnpj_cpf
FROM res_company c
INNER JOIN res_partner p ON c.partner_id = p.id
INNER JOIN res_country co ON p.country_id = co.id
INNER JOIN res_country_state st ON p.state_id = st.id
INNER JOIN l10n_br_base_city ci ON p.l10n_br_city_id = ci.id
WHERE c.parent_id != c.id ORDER BY c.name
) TO stdout WITH (FORMAT CSV, DELIMITER ',', HEADER);


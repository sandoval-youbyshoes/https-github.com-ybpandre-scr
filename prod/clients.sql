COPY (
SELECT
    p.id,
    UNACCENT(p.name) as cliente,
    UNACCENT(legal_name) as legal_name,
    (p.create_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/Sao_Paulo')::date AS data_criacao,
    UNACCENT(cri.login) as usuario_criacao,
    data_alteracao,
    UNACCENT(alt.login) as usuario_alteracao,
    UNACCENT(street) as endereco_1,
    UNACCENT(street2) as endereco_2,
    number as numero,
    UNACCENT(district) as bairro,
    UNACCENT(city) as cidade,
    UNACCENT(rcs.name) as estado,
    zip as cep,
    UNACCENT(rc.name) as pais,
    cnpj_cpf,
    UNACCENT(email) as email,
    phone as telefone,
    mobile as celular,
    birthdate as data_nascimento,
    gender as genero,
    opt_out as mensagem,
    whatsapp
FROM
    res_partner p
        INNER JOIN res_users alt ON p.write_uid = alt.id
        INNER JOIN res_users cri ON p.create_uid = cri.id
        LEFT JOIN res_country_state rcs ON rcs.id = p.state_id
        LEFT JOIN res_country rc ON rc.id = p.country_id
WHERE
    is_company = False
    AND p.active = True
    AND cnpj_cpf IS NOT NULL
) TO stdout WITH (FORMAT CSV, DELIMITER ',', HEADER);

SELECT 
# REFERENCIA, ID_COMBINACAO,ordem, 
    CONCAT(
            "mv -n " ,
            REPLACE(IMAGEM, '\\', ''),
            " ../../img_oi17/",
            REFERENCIA,
            RIGHT(CONCAT('00000000', Ordem), 14-LENGTH(REFERENCIA)),
            '.jpg') AS Target
FROM
    soimagens.COMBINACAO
Where Imagem <> ""
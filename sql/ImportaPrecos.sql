/*
importa lista de precos - os que nao estao so precificados automaticamente pelo sistema.
*/
BEGIN;

TRUNCATE `YouHist`.`precoslojasatuais`; # aqui temos que ver se truncamos ou acresentamos...
#MAC:
load data local infile '/Volumes/GoogleDrive/My Drive/Giros/dados/PrecosLojasAtuais.csv'
into table precoslojasatuais
CHARACTER SET UTF8
fields terminated by ',' 
lines terminated by '\n' 
ignore 1 lines;
show warnings;

# atualiza data e suauario que atualizou esta tabela
INSERT INTO 
   TableUpdates
    (`NomeTabela`,`LUpdate`,`User`)
VALUES 
    ('precoslojasatuais', now(), CURRENT_USER() )
ON DUPLICATE KEY UPDATE 
    LUpdate=now(), 
    User=CURRENT_USER();

Commit;
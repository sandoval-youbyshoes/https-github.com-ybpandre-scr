/*
importa campeões
*/
BEGIN;

TRUNCATE `YouHist`.`o_champions`; # aqui temos que ver se truncamos ou acresentamos...
#MAC:
load data local infile '/Volumes/GoogleDrive/My Drive/Giros/dados/champions.csv'
into table o_champions
CHARACTER SET UTF8
fields terminated by ',' 
lines terminated by '\n' 
ignore 1 lines;
show warnings;

# atualiza data e usuario que atualizou esta tabela
INSERT INTO 
   TableUpdates
    (`NomeTabela`,`LUpdate`,`User`)
VALUES 
    ('o_champions', now(), CURRENT_USER() )
ON DUPLICATE KEY UPDATE 
    LUpdate=now(), 
    User=CURRENT_USER();

Commit;
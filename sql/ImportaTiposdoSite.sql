/*
importa lista de tipos do site
*/
BEGIN;

TRUNCATE `YouHist`.`listamcsubtipos`; # aqui temos que ver se truncamos ou acresentamos...
#MAC:
load data local infile '/Volumes/GoogleDrive/My Drive/Giros/dados/YouHistSQL/SiteLojaPic/listaMCsubtipos.csv'
into table listamcsubtipos
CHARACTER SET UTF8
fields terminated by ';' 
Optionally enclosed by '"'
lines terminated by '\n' 
ignore 1 lines
(`Modelo`,`Tipo`,`SubtipoOrig`,`SubSubtipo`,`TamSalto`,`Salto`,`TipoNome`); # precisa especificar o nomes dos campos pq tem campos calculados nesta tabela...
show warnings;

# atualiza data e suauario que atualizou esta tabela
INSERT INTO 
   TableUpdates
    (`NomeTabela`,`LUpdate`,`User`)
VALUES 
    ('listamcsubtipos', now(), CURRENT_USER() )
ON DUPLICATE KEY UPDATE 
    LUpdate=now(), 
    User=CURRENT_USER();
    
CALL `YouHist`.`RefrescaRankColsTipos`();
Commit;
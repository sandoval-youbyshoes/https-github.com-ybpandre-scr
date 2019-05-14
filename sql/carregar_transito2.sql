BEGIN;

TRUNCATE YouHist.o_transito_2;

load data local infile 'G:\\Meu Drive\\Giros\\dados\\transito2.csv'
into table o_transito_2
CHARACTER SET UTF8
fields terminated by ';' 
lines terminated by '\n'
ignore 1 lines;
-- (campo1, campo2, campo3); -- Campos explicitos para nao dar warnings no campo calculado...
show warnings;

INSERT INTO 
   TableUpdates
    (`NomeTabela`,`LUpdate`,`User`)
VALUES 
    ('o_transito_2', now(), CURRENT_USER() )
ON DUPLICATE KEY UPDATE 
    LUpdate=now(), 
    User=CURRENT_USER();

COMMIT;
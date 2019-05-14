BEGIN;

TRUNCATE YouHist.o_targets;

load data local infile 'G:\\Meu Drive\\Giros\\dados\\odoo\\targets.csv'
into table o_targets
CHARACTER SET UTF8
fields terminated by ',' 
lines terminated by '\n'
ignore 1 lines;
-- (default_code,name,ean13,cost_price,attr,Collection,Footwear Kind,Product Class,Size,Champion,Cost); -- Campos explicitos para nao dar warnings no campo calculado...
show warnings;

INSERT INTO 
   TableUpdates
    (`NomeTabela`,`LUpdate`,`User`)
VALUES 
    ('o_targets', now(), CURRENT_USER() )
ON DUPLICATE KEY UPDATE 
    LUpdate=now(), 
    User=CURRENT_USER();

COMMIT;
BEGIN;

TRUNCATE YouHist.o_companies;

load data local infile 'G:\\Meu Drive\\Giros\\dados\\odoo\\companies.csv'
into table o_companies
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
    ('o_companies', now(), CURRENT_USER() )
ON DUPLICATE KEY UPDATE 
    LUpdate=now(), 
    User=CURRENT_USER();

COMMIT;
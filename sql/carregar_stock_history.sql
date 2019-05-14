BEGIN;
TRUNCATE YouHist.o_stock_history;
load data local infile 'G:\Meu Drive\Giros\dados\odoo\stock_history.csv'
into table YouHist.o_stock_history CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
INSERT INTO TableUpdates (NomeTabela,LUpdate,User) VALUES ('o_stock_history', now(), CURRENT_USER()) ON DUPLICATE KEY UPDATE LUpdate=now(), User=CURRENT_USER();
COMMIT;
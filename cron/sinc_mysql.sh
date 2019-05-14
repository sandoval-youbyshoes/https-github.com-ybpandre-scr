data1=$(date "+%Y-%m-%d %H:%M:%S")
/usr/games/cowsay "Inicio " $data1
echo "PID: $$"

echo "   Eliminando querys abertas no mysql   "

mysql -u TI -psenhadoSQL1 -e "select id from information_schema.processlist" | while read id;
do
    if [[ "id" == "$id" ]]
    then
        continue
    fi
    echo "   Assassinando o processo $id   "
    mysql -u TI -psenhadoSQL1 -e "kill $id";
done

echo "   Querys do mysql paradas   "
echo " ##########################  "


echo "		"
echo "Importando Companies para o Mysql"
echo "		"

mysql -u TI -psenhadoSQL1 YouHist <<COMPANIES
BEGIN;
TRUNCATE YouHist.o_companies;
load data local infile '/home/you/grive/Giros/dados/odoo/companies.csv' into table YouHist.o_companies CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
INSERT INTO TableUpdates (NomeTabela,LUpdate,User) VALUES ('o_companies', now(), CURRENT_USER()) ON DUPLICATE KEY UPDATE LUpdate=now(), User=CURRENT_USER();
COMMIT;
COMPANIES


echo "		"
echo "Importando Clients para o Mysql"
echo "		"

mysql -u TI -psenhadoSQL1 YouHist <<CLIENTS
BEGIN;
TRUNCATE YouHist.o_clients;
load data local infile '/home/you/grive/Giros/dados/odoo/clients.csv' into table o_clients CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
INSERT INTO TableUpdates (NomeTabela,LUpdate,User) VALUES ('o_clients', now(), CURRENT_USER()) ON DUPLICATE KEY UPDATE LUpdate=now(), User=CURRENT_USER();
COMMIT;
CLIENTS


echo "		"
echo "Importando Prices para o Mysql"
echo "		"

mysql -u TI -psenhadoSQL1 YouHist <<PRECOS
BEGIN;
TRUNCATE YouHist.o_prices;
load data local infile '/home/you/grive/Giros/dados/odoo/prices.csv' into table YouHist.o_prices CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
INSERT INTO TableUpdates (NomeTabela,LUpdate,User) VALUES ('o_prices', now(), CURRENT_USER()) ON DUPLICATE KEY UPDATE LUpdate=now(), User=CURRENT_USER();
COMMIT;
PRECOS


echo "		"
echo "Importando Targets para o Mysql"
echo "		"

mysql -u TI -psenhadoSQL1 YouHist <<ALVOS
BEGIN;
TRUNCATE YouHist.o_targets;
load data local infile '/home/you/grive/Giros/dados/odoo/targets.csv' into table YouHist.o_targets CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
INSERT INTO TableUpdates (NomeTabela,LUpdate,User) VALUES ('o_targets', now(), CURRENT_USER()) ON DUPLICATE KEY UPDATE LUpdate=now(), User=CURRENT_USER();
COMMIT;
ALVOS


echo "		"
echo "Importando Stock History para o Mysql"
echo "		"

mysql -u TI -psenhadoSQL1 YouHist <<STOCK_HISTORY
BEGIN;
TRUNCATE YouHist.o_stock_history;
load data local infile '/home/you/grive/Giros/dados/odoo/stock_history.csv'
into table YouHist.o_stock_history CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
INSERT INTO TableUpdates (NomeTabela,LUpdate,User) VALUES ('o_stock_history', now(), CURRENT_USER()) ON DUPLICATE KEY UPDATE LUpdate=now(), User=CURRENT_USER();
COMMIT;
STOCK_HISTORY


echo "		"
echo "Importando Products para o Mysql"
echo "		"

mysql -u TI -psenhadoSQL1 YouHist <<PRODUCT
BEGIN;
TRUNCATE YouHist.o_products;
load data local infile '/home/you/grive/Giros/dados/odoo/products.csv' into table YouHist.o_products CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
INSERT INTO TableUpdates (NomeTabela,LUpdate,User) VALUES ('o_products', now(), CURRENT_USER()) ON DUPLICATE KEY UPDATE LUpdate=now(), User=CURRENT_USER();
COMMIT;
PRODUCT


echo "		"
echo "Importando Moves para o Mysql"
echo "		"

mysql -u TI -psenhadoSQL1 YouHist <<MOVES 
BEGIN;
TRUNCATE YouHist.o_moves;
load data local infile '/home/you/grive/Giros/dados/odoo/moves.csv'
into table YouHist.o_moves CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
INSERT INTO TableUpdates (NomeTabela,LUpdate,User) VALUES ('o_moves', now(), CURRENT_USER()) ON DUPLICATE KEY UPDATE LUpdate=now(), User=CURRENT_USER();
COMMIT;
MOVES


echo "          "
echo "Importando Champions para o Mysql"
echo "          "

mysql -u TI -psenhadoSQL1 YouHist <<CHAMPIONS
BEGIN;
TRUNCATE YouHist.o_champions;
load data local infile '/home/you/grive/Giros/dados/odoo/champions.csv'
into table YouHist.o_champions CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
INSERT INTO TableUpdates (NomeTabela,LUpdate,User) VALUES ('o_champions', now(), CURRENT_USER()) ON DUPLICATE KEY UPDATE LUpdate=now(), User=CURRENT_USER();
COMMIT;
CHAMPIONS


echo "          "
echo "Importando First_move para o Mysql"
echo "          "

mysql -u TI -psenhadoSQL1 YouHist <<FIRST
BEGIN;
TRUNCATE YouHist.o_first_move;
load data local infile '/home/you/grive/Giros/dados/odoo/first_move.csv'
into table YouHist.o_first_move CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
INSERT INTO TableUpdates (NomeTabela,LUpdate,User) VALUES ('o_first_move', now(), CURRENT_USER()) ON DUPLICATE KEY UPDATE LUpdate=now(), User=CURRENT_USER();
COMMIT;
FIRST


data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo  "Processo finalizado tempo: $tempo"

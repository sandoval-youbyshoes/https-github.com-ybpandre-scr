data1=$(date "+%Y-%m-%d %H:%M:%S")

echo "		"
echo "Importando Prices para o Mysql"
echo "PID: $$"
echo "		"

mysql -u TI -psenhadoSQL1 YouHist <<PRECOS &> /dev/null
BEGIN;
TRUNCATE YouHist.o_prices;
load data local infile '/home/you/grive/Giros/dados/odoo/prices.csv' into table YouHist.o_prices CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
INSERT INTO TableUpdates (NomeTabela,LUpdate,User) VALUES ('o_prices', now(), CURRENT_USER()) ON DUPLICATE KEY UPDATE LUpdate=now(), User=CURRENT_USER();
COMMIT;
PRECOS

data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"
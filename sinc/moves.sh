data1=$(date "+%Y-%m-%d %H:%M:%S")

echo "		"
echo "Importando Moves para o Mysql"
echo "PID: $$"
echo "		"

mysql -u TI -psenhadoSQL1 YouHist <<MOVES &> /dev/null 
BEGIN;
TRUNCATE YouHist.o_moves;
load data local infile '/home/you/grive/Giros/dados/odoo/moves.csv'
into table YouHist.o_moves CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
INSERT INTO TableUpdates (NomeTabela,LUpdate,User) VALUES ('o_moves', now(), CURRENT_USER()) ON DUPLICATE KEY UPDATE LUpdate=now(), User=CURRENT_USER();
COMMIT;
MOVES

data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"

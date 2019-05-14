data1=$(date "+%Y-%m-%d %H:%M:%S")

echo "		"
echo "Importando Targets para o Mysql"
echo "PID: $$"
echo "		"

mysql -u TI -psenhadoSQL1 YouHist <<ALVOS &> /dev/null
BEGIN;
TRUNCATE YouHist.o_targets;
load data local infile '/home/you/grive/Giros/dados/odoo/targets.csv' into table YouHist.o_targets CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
INSERT INTO TableUpdates (NomeTabela,LUpdate,User) VALUES ('o_targets', now(), CURRENT_USER()) ON DUPLICATE KEY UPDATE LUpdate=now(), User=CURRENT_USER();
COMMIT;
ALVOS

data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"
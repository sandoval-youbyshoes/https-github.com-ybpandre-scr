#!/bin/bash
date "+%Y-%m-%d %H:%M:%S"
data1=$(date "+%Y-%m-%d %H:%M:%S")

ontem=$(date -d '-1 day' '+%Y%m%d')

## ABC
#wget --tries=2 -O /home/you/grive/Giros/dados/entrantes_passantes/abc_passantes.csv "abc.youbyshoes.com.br:8002/local/people-counter/.api?export-csv&date=20190316-20190423&res=1h"

#wget --tries=2 -O /home/you/grive/Giros/dados/entrantes_passantes/abc_entrantes.csv "abc.youbyshoes.com.br:8001/local/people-counter/.api?export-csv&date=20190316-20190423&res=1h"


## ABC
#mysql -u TI -psenhadoSQL1 YouHist <<abc_passantes
#BEGIN;
#load data local infile '/home/you/grive/Giros/dados/entrantes_passantes/abc_passantes.csv' into table entrantes_passantes CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
#COMMIT;
#abc_passantes

#mysql -u TI -psenhadoSQL1 YouHist <<abc_entrantes
#BEGIN;
#load data local infile '/home/you/grive/Giros/dados/entrantes_passantes/abc_entrantes.csv' into table entrantes_passantes CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
#COMMIT;
#UPDATE entrantes_passantes SET local = 'ES 06 ABC', company_id = 8 WHERE local in ('ACCC8E54905A','ACCC8E54905C');
#UPDATE entrantes_passantes SET camera = 'Passantes' WHERE camera = 'Axis-ACCC8E54905C';
#UPDATE entrantes_passantes SET camera = 'Entrantes' WHERE camera = 'Axis-ACCC8E54905A';
#abc_entrantes


# CNT
wget --tries=2 -O /home/you/grive/Giros/dados/entrantes_passantes/cnt_entrantes.csv "youcnt.ddns.net:8001/local/people-counter/.api?export-csv&date=${ontem}$1&res=1h"

# CNT
mysql -u TI -psenhadoSQL1 YouHist <<cnt
BEGIN;
load data local infile '/home/you/grive/Giros/dados/entrantes_passantes/cnt_entrantes.csv' into table entrantes_passantes CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
COMMIT;
UPDATE entrantes_passantes SET local = 'ES 07 Center Norte', camera = 'Entrantes', company_id = 9 WHERE local = 'ACCC8E35EC8D';
cnt


echo "Gerando Arquivo acompanhamentodiario.csv ....."
mysql -u TI -psenhadoSQL1 YouHist -e "SELECT * FROM acompanhamentodiario WHERE data BETWEEN CURDATE() - INTERVAL 30 DAY AND CURDATE()" | sed 's/\t/;/g' > /home/you/grive/Giros/dados/acompanhamentodiario.csv
echo "Arquivo gerado"
echo "   "

data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"

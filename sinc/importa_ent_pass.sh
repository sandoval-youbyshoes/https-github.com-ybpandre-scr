#!/bin/bash
date "+%Y-%m-%d %H:%M:%S"
data1=$(date "+%Y-%m-%d %H:%M:%S")

# SPM
mysql -u TI -psenhadoSQL1 YouHist <<spm_passantes
BEGIN;
load data local infile '/home/you/grive/Giros/dados/entrantes_passantes/spm_passantes.csv' into table entrantes_passantes CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
COMMIT;
spm_passantes

mysql -u TI -psenhadoSQL1 YouHist <<spm_entrantes
BEGIN;
load data local infile '/home/you/grive/Giros/dados/entrantes_passantes/spm_entrantes.csv' into table entrantes_passantes CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
COMMIT;
UPDATE entrantes_passantes SET local = 'ES 03 SP Market', company_id = 5 WHERE local in ('ACCC8E363AC9','ACCC8E3613C3');
UPDATE entrantes_passantes SET camera = 'Passantes' WHERE camera = 'Axis-ACCC8E363AC9';
UPDATE entrantes_passantes SET camera = 'Entrantes' WHERE camera = 'Axis-ACCC8E3613C3';
spm_entrantes

# TTP
mysql -u TI -psenhadoSQL1 YouHist <<ttp_passantes
BEGIN;
load data local infile '/home/you/grive/Giros/dados/entrantes_passantes/ttp_passantes.csv' into table entrantes_passantes CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
COMMIT;
ttp_passantes

mysql -u TI -psenhadoSQL1 YouHist <<ttp_entrantes
BEGIN;
load data local infile '/home/you/grive/Giros/dados/entrantes_passantes/ttp_entrantes.csv' into table entrantes_passantes CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
COMMIT;
UPDATE entrantes_passantes SET local = 'ES 04 Tatuape', company_id = 6 WHERE local in ('00408CE9FCF4','ACCC8E35233E');
UPDATE entrantes_passantes SET camera = 'Passantes' WHERE camera = 'Axis-00408CE9FCF4';
UPDATE entrantes_passantes SET camera = 'Entrantes' WHERE camera = 'Axis-ACCC8E35233E';
ttp_entrantes

# IBR
mysql -u TI -psenhadoSQL1 YouHist <<ibr_passantes
BEGIN;
load data local infile '/home/you/grive/Giros/dados/entrantes_passantes/ibr_passantes.csv' into table entrantes_passantes CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
COMMIT;
ibr_passantes

mysql -u TI -psenhadoSQL1 YouHist <<ibr_entrantes
BEGIN;
load data local infile '/home/you/grive/Giros/dados/entrantes_passantes/ibr_entrantes.csv' into table entrantes_passantes CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
COMMIT;
UPDATE entrantes_passantes SET local = 'ES 05 Ibirapuera', company_id = 7 WHERE local in ('ACCC8E363ACC','ACCC8E3613C9');
UPDATE entrantes_passantes SET camera = 'Passantes' WHERE camera = 'Axis-ACCC8E363ACC';
UPDATE entrantes_passantes SET camera = 'Entrantes' WHERE camera = 'Axis-ACCC8E3613C9';
ibr_entrantes

# ABC
mysql -u TI -psenhadoSQL1 YouHist <<abc_passantes
BEGIN;
load data local infile '/home/you/grive/Giros/dados/entrantes_passantes/abc_passantes.csv' into table entrantes_passantes CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
COMMIT;
abc_passantes

mysql -u TI -psenhadoSQL1 YouHist <<abc_entrantes
BEGIN;
load data local infile '/home/you/grive/Giros/dados/entrantes_passantes/abc_entrantes.csv' into table entrantes_passantes CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
COMMIT;
UPDATE entrantes_passantes SET local = 'ES 06 ABC', company_id = 8 WHERE local in ('ACCC8E54905A','ACCC8E54905C');
UPDATE entrantes_passantes SET camera = 'Passantes' WHERE camera = 'Axis-ACCC8E54905C';
UPDATE entrantes_passantes SET camera = 'Entrantes' WHERE camera = 'Axis-ACCC8E54905A';
abc_entrantes

# CNT
mysql -u TI -psenhadoSQL1 YouHist <<cnt
BEGIN;
load data local infile '/home/you/grive/Giros/dados/entrantes_passantes/cnt_entrantes.csv' into table entrantes_passantes CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
COMMIT;
UPDATE entrantes_passantes SET local = 'ES 07 Center Norte', camera = 'Entrantes', company_id = 9 WHERE local = 'ACCC8E35EC8D';
cnt

data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"

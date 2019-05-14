echo "   Gerando arquivo plist   "

ssh root@172.16.211.120 "cd /opt/scripts_sql;PGPASSWORD=d8c823d866c7214417484a912b5577d1 psql -h 172.16.211.102 -d youbyshoes -U youbyshoes -f /opt/scripts_sql/plist.sql -o /opt/odoo/prod_erp/var/export/sql_views/plist.csv"

echo "   Baixando arquivo plist   "

rsync -pavzh --append-verify root@172.16.211.120:/opt/odoo/prod_erp/var/export/sql_views/plist.csv /home/you/grive/Giros/dados/odoo

echo "   Importando para o Mysql  "

mysql -u TI -psenhadoSQL1 YouHist <<PRECOS &> /dev/null
BEGIN;
TRUNCATE YouHist.plist;
load data local infile '/home/you/grive/Giros/dados/odoo/plist.csv' into table YouHist.plist CHARACTER SET UTF8 fields terminated by ',' lines terminated by '\n' ignore 1 lines;
COMMIT;
PRECOS

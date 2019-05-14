data1=$(date "+%Y-%m-%d %H:%M:%S")

echo "   Gerando arquivos na PROD   "
echo "      "
echo "   PID: $$   "
echo "      "

ssh root@172.16.211.120 "cd /opt/scripts_sql;PGPASSWORD=d8c823d866c7214417484a912b5577d1 ./direct_access_queries.sh 172.16.211.102 youbyshoes youbyshoes /opt/scripts_sql /opt/odoo/prod_erp/var/export/sql_views/" &> /dev/null

echo "   Importando arquivos de Producao...........   "

files='moves.csv products.csv targets.csv stock_history.csv prices.csv clients.csv companies.csv payments.csv champions.csv first_move.csv'

for f in $files; do
    rsync -avzh --inplace root@172.16.211.120:/opt/odoo/prod_erp/var/export/sql_views/$f /home/you/grive/Giros/dados/odoo
done

data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo  "   Processo finalizado tempo: $tempo   "

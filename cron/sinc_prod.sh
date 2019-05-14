data1=$(date "+%Y-%m-%d %H:%M:%S")
/usr/games/cowsay "Inicio " $data1

echo "Gerando arquivos na PROD"
echo "      "
echo "PID: $$"
echo "      "

ssh root@172.16.211.120 "cd /opt/scripts_sql;PGPASSWORD=d8c823d866c7214417484a912b5577d1 ./direct_access_queries.sh 172.16.211.102 youbyshoes youbyshoes /opt/scripts_sql /opt/odoo/prod_erp/var/export/sql_views/"

#scp root@172.16.211.120:/opt/odoo/prod_erp/var/export/sql_views/*.* /home/you/grive/Giros/dados/odoo/

cd /home/you/grive/Giros/dados/odoo

ls -lsa

files='moves.csv products.csv targets.csv stock_history.csv prices.csv clients.csv companies.csv payments.csv champions.csv first_move.csv'

for f in $files; do
    rsync -pavzh --append-verify root@172.16.211.120:/opt/odoo/prod_erp/var/export/sql_views/$f /home/you/grive/Giros/dados/odoo
done

for f in $files; do
if [ \! -s /home/you/grive/Giros/dados/odoo/$f ]; then 
     echo "/home/you/grive/Giros/dados/odoo/$f esta sem bytes" | mutt -s "$f esta sem bytes" t.i@youbyshoes.com.br; 
     exit
else
    echo "$f esta ok"
fi
done

ls -lsa

data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo  "Processo finalizado tempo: $tempo"

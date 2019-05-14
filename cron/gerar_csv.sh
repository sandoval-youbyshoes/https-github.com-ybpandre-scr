data1=$(date "+%Y-%m-%d %H:%M:%S")
/usr/games/cowsay "Inicio " $data1
echo "PID: $$"

echo "		"
echo "Executando AtualizaNewEval30()"
echo "		"

mysql -u TI -psenhadoSQL1 YouHist << atNe
call YouHist.AtualizaNewEval30();
atNe

data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"

echo "		"
echo "Exportando Arquivo eval_odoo.csv"
echo "		"
mysql -u TI -psenhadoSQL1 YouHist < /home/you/grive/scr/sql/exportaEval.sql | sed 's/\t/;/g' > /home/you/grive/Giros/dados/eval_odoo.csv
echo "Arquivo exportado"
echo "		"

echo "		"
echo "Executando AtualizaNewEval360()"
echo "		"

mysql -u TI -psenhadoSQL1 YouHist << atNe360
call YouHist.AtualizaNewEval360();
atNe360

data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"

echo "Exportando Arquivo eval_odoo360.csv"
echo "		"
mysql -u TI -psenhadoSQL1 YouHist < /home/you/grive/scr/sql/exportaEval360.sql | sed 's/\t/;/g' > /home/you/grive/Giros/dados/eval_odoo360.csv
echo "Arquivo exportado"
echo "		"


data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"
data1=$(date "+%Y-%m-%d %H:%M:%S")

echo "		"
echo "Executando AtualizaNewEval360()"
echo "PID: $$"
echo "   Inicio: $data1"

mysql -u TI -psenhadoSQL1 YouHist << atNe360 &> /dev/null
call YouHist.AtualizaNewEval360();
atNe360

data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"
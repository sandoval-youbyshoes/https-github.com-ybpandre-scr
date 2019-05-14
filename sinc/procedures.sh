data1=$(date "+%Y-%m-%d %H:%M:%S")

echo "		"
echo "Executando AtualizaMovimentos()"
echo "PID: $$"
echo "		"

mysql -u TI -psenhadoSQL1 YouHist << AtMv &> /dev/null
call YouHist.AtualizaMovimentos();
AtMv

echo "		"
echo "Executando RefrescaRankColsTipos()"
echo "PID: $$"
echo "		"
mysql -u TI -psenhadoSQL1 YouHist << Refresca &> /dev/null
call YouHist.RefrescaRankColsTipos();
Refresca


data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"
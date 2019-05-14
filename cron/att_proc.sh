data1=$(date "+%Y-%m-%d %H:%M:%S")
/usr/games/cowsay "Inicio " $data1
echo "PID: $$"

echo "		"
echo "Executando AtualizaMovimentos()"
echo "		"

mysql -u TI -psenhadoSQL1 YouHist << AtMv
call YouHist.AtualizaMovimentos();
AtMv
sleep 15

# echo "		"
# echo "Executando FastMovers()"
# echo "		"
# mysql -u TI -psenhadoSQL1 YouHist << atFM
# call YouHist.AtualizaFastMovers();
# atFM
# sleep 15

echo "		"
echo "Executando RefrescaRankColsTipos()"
echo "		"
mysql -u TI -psenhadoSQL1 YouHist << Refresca
call YouHist.RefrescaRankColsTipos();
call YouHist.RefrescaRankColsTipos();
call YouHist.RefrescaRankColsTipos();
Refresca
sleep 15

data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo  "Processo finalizado tempo: $tempo"

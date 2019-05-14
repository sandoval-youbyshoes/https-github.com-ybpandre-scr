data1=$(date "+%Y-%m-%d %H:%M:%S")

echo "		"
echo "Sincronizando Drive"
echo "PID: $$"
echo "		"

cd /home/you/grive
/usr/local/bin/grive -p /home/you/grive/

data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Drive Sincronizado Tempo de execucao: $tempo"
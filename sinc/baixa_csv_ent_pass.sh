date "+%Y-%m-%d %H:%M:%S"
data1=$(date "+%Y-%m-%d %H:%M:%S")

echo "PID: $$"

intervalo=$(date -d '-15 day' '+%Y%m%d')

# SPM
wget --tries=2 -O /home/you/grive/Giros/dados/entrantes_passantes/spm_passantes.csv "spm.youbyshoes.com.br:8002/local/people-counter/.api?export-csv&date=${intervalo}$1&res=1h"

wget --tries=2 -O /home/you/grive/Giros/dados/entrantes_passantes/spm_entrantes.csv "spm.youbyshoes.com.br:8001/local/people-counter/.api?export-csv&date=${intervalo}$1&res=1h"


# TTP
wget --tries=2 -O /home/you/grive/Giros/dados/entrantes_passantes/ttp_passantes.csv "ttp.youbyshoes.com.br:8002/local/people-counter/.api?export-csv&date=${intervalo}$1&res=1h"

wget --tries=2 -O /home/you/grive/Giros/dados/entrantes_passantes/ttp_entrantes.csv "ttp.youbyshoes.com.br:8001/local/people-counter/.api?export-csv&date=${intervalo}$1&res=1h"


# IBR
wget --tries=2 -O /home/you/grive/Giros/dados/entrantes_passantes/ibr_passantes.csv "ibr.youbyshoes.com.br:8002/local/people-counter/.api?export-csv&date=${intervalo}$1&res=1h"

wget --tries=2 -O /home/you/grive/Giros/dados/entrantes_passantes/ibr_entrantes.csv "ibr.youbyshoes.com.br:8001/local/people-counter/.api?export-csv&date=${intervalo}$1&res=1h"


# ABC
wget --tries=2 -O /home/you/grive/Giros/dados/entrantes_passantes/abc_passantes.csv "abc.youbyshoes.com.br:8002/local/people-counter/.api?export-csv&date=${intervalo}$1&res=1h"

wget --tries=2 -O /home/you/grive/Giros/dados/entrantes_passantes/abc_entrantes.csv "abc.youbyshoes.com.br:8001/local/people-counter/.api?export-csv&date=${intervalo}$1&res=1h"


# CNT
wget --tries=2 -O /home/you/grive/Giros/dados/entrantes_passantes/cnt_entrantes.csv "youcnt.ddns.net:8001/local/people-counter/.api?export-csv&date=${intervalo}$1&res=1h"

data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"
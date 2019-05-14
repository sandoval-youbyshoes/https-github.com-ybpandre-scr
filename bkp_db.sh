data1=$(date "+%Y-%m-%d %H:%M:%S")
dnome=$(date "+%Y%m%d")

Echo "Gerando Arquivo de dump"
mysqldump -u TI -psenhadoSQL1 YouHist > /home/you/bkp_mysql/bkp_$dnome.sql

data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo " Arquivo gerado com sucesso."
echo "Tempo de execução: $tempo"

echo "Copiando arquivo para o google drive"
cp /home/you/bkp_mysql/bkp_$dnome.sql /home/you/grive/Tomilhos/bkp_mysql/bkp_$dnome.sql

echo "Arquivo copiado com sucesso"
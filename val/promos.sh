lojas='3-SPM 4-TTP 5-IBR 6-ABC 7-CNT EMP'


for l in $lojas; do
nome=$(echo $l | cut -c3-6)

echo "   Atualizando parâmetro"
mysql -u TI -psenhadoSQL1 YouHist -e "UPDATE paramsrelats SET Valor='$l' WHERE Param='LocalC'"

echo "   Exportando Promo $l...."
data1=$(date "+%Y-%m-%d %H:%M:%S")
dnome=$(date "+%Y%m%d")

/opt/VStudio/vstudio -project "/home/you/grive/Giros/dados/YouHistSQL/HistYou.vsp" -make_new_report "Promos" -datasource "mysql://host = 'localhost' port = '3306' dbname = 'youhist' user = 'TI' password = 'senhadoSQL1' timeout = '60000'" -print_to_disk "/home/you/grive/Tomilhos/precos/$dnome/$l.ps" -format kTopostscript


data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"

echo "convertendo Promo $l...."
data1=$(date "+%Y-%m-%d %H:%M:%S")

ps2pdf -dOptimize=true -dUseFlateCompression=true -dPDFSETTINGS=/printer /home/you/grive/Tomilhos/precos/$dnome/$l.ps /home/you/grive/Tomilhos/precos/$dnome/$l.pdf

data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"
done
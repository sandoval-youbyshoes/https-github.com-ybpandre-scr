if [[ $1 -eq 3 ]];
then
   	lojas='3-SPM'
elif [[ $1 -eq 4 ]];
then
	lojas='4-TTP'
elif [[ $1 -eq 5 ]];
then
	lojas='5-IBR'
elif [[ $1 -eq 6 ]];
then
	lojas='6-ABC'
else
	lojas='3-SPM 4-TTP 5-IBR 6-ABC'
fi

dia=$(date +%u)

for l in $lojas; do

nome=$(echo $l | cut -c3-6)

echo "   Excluindo antigos CompSemanal-$nome....   "
cd /home/you/grive/Giros/RelatoriosVisuais/
find . -name "*CompSemanal-$nome*" -type f -delete

mysql -u TI -psenhadoSQL1 YouHist -e "UPDATE paramsrelats SET Valor='$l' WHERE Param='LocalC'"
if [ $dia -gt 3 ]
	then
	mysql -u TI -psenhadoSQL1 YouHist -e "UPDATE paramsrelats SET Valor='SIM' WHERE Param='SemanaIncompleta'"
else
	mysql -u TI -psenhadoSQL1 YouHist -e "UPDATE paramsrelats SET Valor='NAO' WHERE Param='SemanaIncompleta'"
fi

echo "Exportando CompSemanal $l...."
data1=$(date "+%Y-%m-%d %H:%M:%S")
dnome=$(date +"%d-%m-%Y")

/opt/VStudio/vstudio -project "/home/you/grive/Giros/dados/YouHistSQL/HistYou.vsp" -make_new_report "CompSemanal_auto" -datasource "mysql://host = 'localhost' port = '3306' dbname = 'youhist' user = 'TI' password = 'senhadoSQL1' timeout = '60000'" -print_to_disk "/home/you/rel/CompSemanal-$nome-$dnome.ps" -format kToPostscript

if [ $? -eq 0 ]
then
    echo "###   Arquivo /home/you/rel/CompSemanal-$nome-$dnome.ps gerado   ###"
else
    echo "#####   Falha  #####" 
fi
data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"

echo "convertendo CompSemanal $l...."
data1=$(date "+%Y-%m-%d %H:%M:%S")

ps2pdf -dOptimize=true -dUseFlateCompression=true -dPDFSETTINGS=/printer /home/you/rel/CompSemanal-$nome-$dnome.ps /home/you/grive/Giros/RelatoriosVisuais/CompSemanal-$nome-$dnome.pdf

if [ $? -eq 0 ]
then
    echo "###   Arquivo /home/you/grive/Giros/RelatoriosVisuais/CompSemanal-$nome-$dnome.pdf  ###"
else
    echo "#####   Falha  #####" 
fi
data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"
done
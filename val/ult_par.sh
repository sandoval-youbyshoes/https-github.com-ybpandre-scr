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
elif [[ $1 -eq 7 ]];
then
	lojas='7-CNT'
else
	lojas='3-SPM 4-TTP 5-IBR 6-ABC 7-CNT'
fi

for l in $lojas; do
nome=$(echo $l | cut -c3-6)


cowthink "Excluindo antigos UltimosPares-$nome...."
cd /home/you/grive/Giros/RelatoriosVisuais/
find . -name "*UltimosPares-$nome*" -type f -delete

cowthink "Atualizando parâmetro"
mysql -u TI -psenhadoSQL1 YouHist -e "UPDATE paramsrelats SET Valor='$l' WHERE Param='LocalC'"

cowthink "Exportando UltimosPares $l...."
data1=$(date "+%Y-%m-%d %H:%M:%S")
dnome=$(date +"%d-%m-%Y")

/opt/VStudio/vstudio -project "/home/you/grive/Giros/dados/YouHistSQL/HistYou.vsp" -make_new_report "UltimosPares_auto" -datasource "mysql://host = 'localhost' port = '3306' dbname = 'youhist' user = 'TI' password = 'senhadoSQL1' timeout = '60000'" -print_to_disk "/home/you/rel/UltimosPares-$nome-$dnome.ps" -format kToPostscript

if [ $? -eq 0 ]
then
    cowthink "Arquivo /home/you/rel/UltimosPares-$nome-$dnome.ps gerado"
else
    cowthink "Falha" 
fi
data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
cowthink "Tempo de execucao: $tempo"

cowthink "convertendo UltimosPares $l...."
data1=$(date "+%Y-%m-%d %H:%M:%S")

ps2pdf -dOptimize=true -dUseFlateCompression=true -dPDFSETTINGS=/printer /home/you/rel/UltimosPares-$nome-$dnome.ps /home/you/grive/Giros/RelatoriosVisuais/UltimosPares-$nome-$dnome.pdf

if [ $? -eq 0 ]
then
    cowthink "Arquivo /home/you/grive/Giros/RelatoriosVisuais/UltimosPares-$nome-$dnome.pdf"
else
    cowthink "Falha" 
fi
data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
cowthink "Tempo de execucao: $tempo"
done
echo "   Excluindo antigos FastMovers....   "
cd /home/you/grive/Giros/RelatoriosVisuais/
find . -name "*FastMovers*" -type f -delete

echo "   Exportando FastMovers....   "
data1=$(date "+%Y-%m-%d %H:%M:%S")
dnome=$(date +"%d-%m-%Y")

/opt/VStudio/vstudio -project "/home/you/grive/Giros/dados/YouHistSQL/HistYou.vsp" -make_new_report "FastMovers_auto" -datasource "mysql://host = 'localhost' port = '3306' dbname = 'youhist' user = 'TI' password = 'senhadoSQL1' timeout = '60000'" -print_to_disk "/home/you/rel/FastMovers-$dnome.ps" -format kToPostscript

if [ $? -eq 0 ]
then
    echo "###   Arquivo /home/you/rel/FastMovers-$dnome.ps gerado   ###"
else
    echo "#####   Falha  #####" 
fi
data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"

echo "   convertendo FastMovers   "
data1=$(date "+%Y-%m-%d %H:%M:%S")

ps2pdf -dOptimize=true -dUseFlateCompression=true -dPDFSETTINGS=/printer /home/you/rel/FastMovers-$dnome.ps /home/you/grive/Giros/RelatoriosVisuais/FastMovers-$dnome.pdf

if [ $? -eq 0 ]
then
    echo "###   Arquivo /home/you/grive/Giros/RelatoriosVisuais/FastMovers-$dnome.pdf  ###"
else
    echo "#####   Falha  #####" 
fi
data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"
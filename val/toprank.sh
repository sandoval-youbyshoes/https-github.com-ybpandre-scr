echo "Executando Refrascador de Rank..........."
mysql -u TI -psenhadoSQL1 YouHist << Refresca
call YouHist.RefrescaRankColsTipos();
call YouHist.RefrescaRankColsTipos();
call YouHist.RefrescaRankColsTipos();
Refresca
if [ $? -eq 0 ]
then
   echo "#######   Rank atualizado  #######"
else
   echo "##########   Falha ao atualizar rank ##########"
fi

echo "   Excluindo antigos TopRankColTipos....   "
cd /home/you/grive/Giros/RelatoriosVisuais/
find . -name "*TopRankColTipos*" -type f -delete

echo "   Exportando TopRankColTipos....   "
data1=$(date "+%Y-%m-%d %H:%M:%S")
dnome=$(date +"%d-%m-%Y")

/opt/VStudio/vstudio -project "/home/you/grive/Giros/dados/YouHistSQL/HistYou.vsp" -make_new_report "TopRankColTipos_auto" -datasource "mysql://host = 'localhost' port = '3306' dbname = 'youhist' user = 'TI' password = 'senhadoSQL1' timeout = '60000'" -print_to_disk "/home/you/rel/TopRankColTipos-$dnome.ps" -format kToPostscript

if [ $? -eq 0 ]
then
    echo "###   Arquivo /home/you/rel/TopRankColTipos-$dnome.ps gerado   ###"
else
    echo "#####   Falha  #####" 
fi
data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"

echo "   convertendo TopRankColTipos   "
data1=$(date "+%Y-%m-%d %H:%M:%S")

ps2pdf -dOptimize=true -dUseFlateCompression=true -dPDFSETTINGS=/printer /home/you/rel/TopRankColTipos-$dnome.ps /home/you/grive/Giros/RelatoriosVisuais/TopRankColTipos-$dnome.pdf

if [ $? -eq 0 ]
then
    echo "###   Arquivo /home/you/grive/Giros/RelatoriosVisuais/TopRankColTipos-$dnome.pdf  ###"
else
    echo "#####   Falha  #####" 
fi
data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"
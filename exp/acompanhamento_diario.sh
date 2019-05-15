date "+%Y-%m-%d %H:%M:%S"
data1=$(date "+%Y-%m-%d %H:%M:%S")
eval=$(mysql -N -u TI -psenhadoSQL1 YouHist -e 'Select Valor from paramsrelats Where Param="Atualizando"')

if [ $eval == 'SIM' ];
then
    echo "Eval está sendo atualizada"
    exit;
fi
echo "PID: $$"

echo "Gerando Arquivo acompanhamentodiario.csv ....."
mysql -u TI -psenhadoSQL1 YouHist -e "SELECT * FROM acompanhamentodiario WHERE data BETWEEN CURDATE() - INTERVAL 365 DAY AND CURDATE()" | sed 's/\t/;/g' > /home/you/grive/Giros/dados/acompanhamentodiario.csv
echo "Arquivo gerado"
echo "   "

data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"
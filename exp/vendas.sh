echo "Exportando Vendas....."
data1=$(date "+%Y-%m-%d %H:%M:%S")
if [ $eval == 'SIM' ];
then
    echo "Eval está sendo atualizada"
    exit;
fi
mysql -u TI -psenhadoSQL1 YouHist -e "SELECT * FROM youhist.vendas" | sed 's/\t/;/g' > /home/you/grive/Giros/dados/vendas.csv

data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')

if [ $? -eq 0 ]
then
    echo "Giros/dados/vendas.csv gerada com sucesso Tempo de execucao: $tempo"
else
    echo "Falha na exportação do vendas.csv Tempo de execucao: $tempo"
fi

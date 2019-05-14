echo "Exportando Vendas por coleção...."
data1=$(date "+%Y-%m-%d %H:%M:%S")
if [ $eval == 'SIM' ];
then
    echo "Eval está sendo atualizada"
    exit;
fi

mysql -u TI -psenhadoSQL1 YouHist -e "SELECT v.*, IFNULL(c.tiponovo,c.tipo) as tipo, c.colecao, col.id FROM youhist.vendas AS v, youhist.cadastromc as c, o_colecao as col WHERE v.data BETWEEN '2018-07-01' AND CURDATE() and substr(v.recurso,1,14) = c.ModeloCor and c.colecao = col.colecao" | sed 's/\t/;/g' > /home/you/grive/Giros/dados/vendas-col.csv

file_size_kb=`du -k "/home/you/grive/Giros/dados/vendas-col.csv" | cut -f1`

if [ $? -eq 0 ]
then
    echo "###   Giros/dados/vendas_col.csv exportada   ###"
    echo "###   tamanho do arquivo: $file_size_kb   ###"
else
    echo "#####   Falha na exportação do vendas_col.csv   #####"
fi

data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"
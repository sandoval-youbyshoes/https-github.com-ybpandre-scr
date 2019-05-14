
data1=$(date "+%Y-%m-%d %H:%M:%S")
dnome=$(date "+%Y%m%d")


lojas='3-SPM 4-TTP 5-IBR 6-ABC 7-CNT'

mkdir /home/you/grive/Tomilhos/precos/$dnome/sistema;


for l in $lojas; do
    echo "Exp arq para loja $l"
    mysql -u TI -psenhadoSQL1 YouHist -e "SELECT * FROM youhist.csvpromo where local = '$l' and \`Price List Items/ID Banco de Dados\` is not null" | sed 's/\t/;/g' > /home/you/grive/Tomilhos/precos/$dnome/sistema/$l.csv 
    arq="/home/you/grive/Tomilhos/precos/$dnome/sistema/$l.csv"
    if [ -s $arq ];
   then
        echo "   $l.csv tem produtos   "
    else
        rm -rf $arq
    fi
done

for l in $lojas; do
    echo "Exp arq para novos da loja $l"
    mysql -u TI -psenhadoSQL1 YouHist -e "Select mc.\`items_id/product_tmpl_id/id\`, ver.id, mc.\`items_id/base\`, mc.\`items_id/price_discount\`, mc.\`items_id/name\`, mc.name, mc.\`items_id/price_surcharge\` from  (SELECT LOCAL, \`items_id/product_tmpl_id/id\`, id, \`items_id/base\`, \`items_id/price_discount\`, \`items_id/name\`, name, \`items_id/price_surcharge\` FROM youhist.csvpromo where local = '$l' and \`Price List Items/ID Banco de Dados\` is null) mc, (select * from youhist.csvpromo where local = '$l' and \`Price List Items/ID Banco de Dados\` is not null limit 1) ver" | sed 's/\t/;/g' > /home/you/grive/Tomilhos/precos/$dnome/sistema/$l-novos.csv 
    arq="/home/you/grive/Tomilhos/precos/$dnome/sistema/$l-novos.csv"
    if [ -s $arq ];
   then
        echo "   $l-novos.csv tem produtos   "
    else
        rm -rf $arq
    fi
done

data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execucao: $tempo"
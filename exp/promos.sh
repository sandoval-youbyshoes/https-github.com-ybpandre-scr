data1=$(date "+%Y-%m-%d %H:%M:%S")
eval=$(mysql -N -u TI -psenhadoSQL1 YouHist -e 'Select Valor from paramsrelats Where Param="Atualizando"')

if [ $eval == 'SIM' ];
then
    echo "Eval está sendo atualizada"
    exit;
fi


## Pegando caminho do ultimo arquivo ##
base=$(find /home/you/grive/Tomilhos/precos/bases/ -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d" ")

dnome=$(date "+%Y%m%d")

echo "  ### Enviando modelos para tabela ###   "
echo "   Usando arrquivo: $base   "

mysql -u TI -psenhadoSQL1 YouHist <<PRODUCT
BEGIN;
TRUNCATE YouHist.gerapromo;
load data local infile '$base' into table YouHist.gerapromo CHARACTER SET UTF8 fields terminated by ';' lines terminated by '\n' ignore 1 lines;
COMMIT;
PRODUCT

## Sincronizar Pricelists ##
/home/you/grive/scr/sinc/plist.sh

echo "   ### Exportando arquivos ###   "
lojas="$(mysql -N -u TI -psenhadoSQL1 YouHist -e 'select distinct local from youhist.gerapromo')"


## Checa se existe pasta do dia e se tem alguma extra, cria de acordo com número novo (contando arquivos existentes) ##
if [ ! -d "/home/you/grive/Tomilhos/precos/$dnome" ]; then
    mkdir -p /home/you/grive/Tomilhos/precos/$dnome/sistema;

    echo "Criada pasta $dnome"
   
## exportando arquivos com mcs existentes ##
    for l in $lojas; do
        echo "Exp arq para loja $l"
        mysql -u TI -psenhadoSQL1 YouHist -e "SELECT * FROM youhist.csvpromo where local = '$l' and \`Price List Items/ID Banco de Dados\` is not null" | sed 's/\t/,/g' > /home/you/grive/Tomilhos/precos/$dnome/sistema/$l.csv 
        arq="/home/you/grive/Tomilhos/precos/$dnome/sistema/$l.csv"
        if [ -s $arq ];
        then
            echo "   $l.csv tem produtos   "
        else
            rm -rf $arq
        fi
    done

## exportando arquivos com preços novos ##
    for l in $lojas; do
        echo "Exp arq para novos da loja $l"
        mysql -u TI -psenhadoSQL1 YouHist -e "Select mc.\`items_id/product_tmpl_id/id\`, ver.id, mc.\`items_id/base\`, mc.\`items_id/price_discount\`, mc.\`items_id/name\`, mc.name, mc.\`items_id/price_surcharge\` from  (SELECT LOCAL, \`items_id/product_tmpl_id/id\`, id, \`items_id/base\`, \`items_id/price_discount\`, \`items_id/name\`, name, \`items_id/price_surcharge\` FROM youhist.csvpromo where local = '$l' and \`Price List Items/ID Banco de Dados\` is null) mc, (SELECT concat('__export__.product_pricelist_version_',p.version) as id FROM youhist.plist p, youhist.csvpromo c, youhist.locais l where c.LOCAL = l.LocalC and l.company_id = p.company and c.local = '$l' limit 1) ver" | sed 's/\t/,/g' > /home/you/grive/Tomilhos/precos/$dnome/sistema/$l-novos.csv 
        arq="/home/you/grive/Tomilhos/precos/$dnome/sistema/$l-novos.csv"
        if [ -s $arq ];
        then
            echo "   $l-novos.csv tem produtos   "
        else
            rm -rf $arq
        fi
    done

## criando pasta com número novo ##
else
    num=$(ls -dq /home/you/grive/Tomilhos/precos/*$dnome* | tail -f | wc -l)
    mkdir -p /home/you/grive/Tomilhos/precos/$dnome-$num/sistema;

    echo "Criada pasta $dnome-$num"

## exportando arquivos com mcs existentes ##
    for l in $lojas; do
        echo "Exp arq para loja $l"
        mysql -u TI -psenhadoSQL1 YouHist -e "SELECT * FROM youhist.csvpromo where local = '$l' and \`Price List Items/ID Banco de Dados\` is not null" | sed 's/\t/,/g' > /home/you/grive/Tomilhos/precos/$dnome-$num/sistema/$l.csv 
        arq="/home/you/grive/Tomilhos/precos/$dnome-$num/sistema/$l.csv"
        if [ -s $arq ];
        then
            echo "   $l.csv tem produtos   "
        else
            rm -rf $arq
        fi
    done

## exportando arquivos com preços novos ##
    for l in $lojas; do
        echo "   Exp arq para novos da loja $l   "
        mysql -u TI -psenhadoSQL1 YouHist -e "Select mc.\`items_id/product_tmpl_id/id\`, ver.id, mc.\`items_id/base\`, mc.\`items_id/price_discount\`, mc.\`items_id/name\`, mc.name, mc.\`items_id/price_surcharge\` from  (SELECT LOCAL, \`items_id/product_tmpl_id/id\`, id, \`items_id/base\`, \`items_id/price_discount\`, \`items_id/name\`, name, \`items_id/price_surcharge\` FROM youhist.csvpromo where local = '$l' and \`Price List Items/ID Banco de Dados\` is null) mc, (SELECT concat('__export__.product_pricelist_version_',p.version) as id FROM youhist.plist p, youhist.csvpromo c, youhist.locais l where c.LOCAL = l.LocalC and l.company_id = p.company and c.local = '$l' limit 1) ver" | sed 's/\t/,/g' > /home/you/grive/Tomilhos/precos/$dnome-$num/sistema/$l-novos.csv 
        arq="/home/you/grive/Tomilhos/precos/$dnome-$num/sistema/$l-novos.csv"
        if [ -s $arq ];
        then
            echo "   $l-novos.csv tem produtos   "
        else
            rm -rf $arq
        fi
    done
fi

data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
echo "Tempo de execução: $tempo"
#!/bin/bash
data1=$(date "+%Y-%m-%d %H:%M:%S")
/usr/games/cowsay "Inicio " $data1

/home/you/grive/scr/sinc/csv_prod.sh

mysql -u TI  -psenhadoSQL1 -h 192.168.68.37 YouHist -e "UPDATE paramsrelats SET Valor='SIM' WHERE Param='Atualizando'"
echo "Parâmetro setado para atualizando!"
files='companies.csv products.csv moves.csv targets.csv stock_history.csv prices.csv clients.csv champions.csv first_move.csv'

for f in $files; do
    if [ \! -s /home/you/grive/Giros/dados/odoo/$f ]; then 
        echo "/home/you/grive/Giros/dados/odoo/$f esta sem bytes" | mutt -s "$f esta sem bytes" t.i@youbyshoes.com.br;
         echo "   /home/you/grive/Giros/dados/odoo/$f esta sem bytes   "
         echo "   Terminando processo favor checar os arquivos   "

        exit
    else
        echo "$f esta ok"
    fi
done

/home/you/grive/scr/kill_mysql.sh

arqs='clients.sh products.sh companies.sh prices.sh targets.sh moves.sh stock_history.sh champions.sh first_move.sh at_movimentos.sh at_eval30.sh at_eval360.sh at_rankcolstipos.sh'

for arq in $arqs; do
    datarq=$(date "+%Y-%m-%d %H:%M:%S")
    # echo " "
    # echo " "
    # /home/you/grive/scr/kill_mysql.sh
    echo "Inicio: $datarq"
    
    /home/you/grive/scr/sinc/$arq

    if [ $? -eq 0 ]
    then
        /usr/games/cowsay "$arq executado com sucesso"
        continue
    else
        /usr/games/cowsay "Falha ao sincronizar $arq"
        exit
    fi
done

## Exportador do eval.csv
/home/you/grive/scr/exp/eval.sh
echo "Arquivo eval.csv exportado"

## Exportador do eval360.csv
/home/you/grive/scr/exp/eval360.sh
echo "Arquivo eval_360.csv exportado"

mysql -u TI  -psenhadoSQL1 -h 192.168.68.37 YouHist -e "UPDATE paramsrelats SET Valor='NAO' WHERE Param='Atualizando'"
echo "Parâmetro setado para Não atualizando!"
data2=$(date "+%Y-%m-%d %H:%M:%S")
tempo=$(date -u -d @$(($(date -d "$data2" '+%s') - $(date -d "$data1" '+%s'))) '+%T')
/usr/games/cowsay  "Processo eval.sh finalizado tempo: $tempo"
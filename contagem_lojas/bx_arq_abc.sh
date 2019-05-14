#!/bin/bash

dia1=$(date -d '- 30 day' '+%Y%m%d')
dia2=$(date -d '-1 day' '+%Y%m%d')

echo "Apagando arquivos"
rm -rf /home/you-abc/ent_pass/*

echo "Baixando Primeiro Entrantes"
wget --tries=1 -O /home/you-abc/ent_pass/abc_entrantes.csv "http://192.168.15.5:8001/local/people-counter/.api?export-csv&date=$dia1-$dia2&res=1h"

file_size=$(wc -c "/home/you-abc/ent_pass/abc_entrantes.csv" | awk '{print $1}')
printf "%d\n" $file_size
echo "Arquivo Entrantes com tamanho $file_size"

while [[ $file_size -le 0 ]]; do
  wget --tries=1 -O /home/you-abc/ent_pass/abc_entrantes.csv "http://192.168.15.5:8001/local/people-counter/.api?export-csv&date=$dia1-$dia2&res=1h"
  file_size=$(wc -c "/home/you-abc/ent_pass/abc_entrantes.csv" | awk '{print $1}')
  printf "%d\n" $file_size
  sleep 45
done

echo "Baixando Primeiro Passantes"
wget --tries=1 -O /home/you-abc/ent_pass/abc_passantes.csv "http://192.168.15.2:8002/local/people-counter/.api?export-csv&date=$dia1-$dia2&res=1h"

file_size=$(wc -c "/home/you-abc/ent_pass/abc_passantes.csv" | awk '{print $1}')
printf "%d\n" $file_size
echo "Arquivo Passantes com tamanho $file_size"

while [[ $file_size -le 0 ]]; do
  wget --tries=1 -O /home/you-abc/ent_pass/abc_passantes.csv "192.168.15.2:8002/local/people-counter/.api?export-csv&date=$dia1-$dia2&res=1h"
  file_size=$(wc -c "/home/you-abc/ent_pass/abc_passantes.csv" | awk '{print $1}')
  printf "%d\n" $file_size
  sleep 45
done



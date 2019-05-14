#!/bin/bash

dia1=$(date -d '- 30 day' '+%Y%m%d')
dia2=$(date -d '-1 day' '+%Y%m%d')

Echo "Apagando arquivos"
rm -rf /home/you/ent_pass/*

Echo "Baixando Primeiro Entrantes"
wget --tries=1 -O /home/you-spm/ent_pass/spm_entrantes.csv "http://192.168.23.112:8001/local/people-counter/.api?export-csv&date=$dia1-$dia2&res=1h"

file_size=$(wc -c "/home/you-spm/ent_pass/spm_entrantes.csv" | awk '{print $1}')
printf "%d\n" $file_size
echo "Arquivo Entrantes com tamanho $file_size"

while [[ $file_size -le 0 ]]; do
  wget --tries=1 -O /home/you-spm/ent_pass/spm_entrantes.csv "http://192.168.23.112:8001/local/people-counter/.api?export-csv&date=$dia1-$dia2&res=1h"
  file_size=$(wc -c "/home/you-spm/ent_pass/spm_entrantes.csv" | awk '{print $1}')
  printf "%d\n" $file_size
done

Echo "Baixando Primeiro Passantes"
wget --tries=1 -O /home/you-spm/ent_pass/spm_passantes.csv "http://192.168.23.108:8002/local/people-counter/.api?export-csv&date=$dia1-$dia2&res=1h"

file_size=$(wc -c "/home/you-spm/ent_pass/spm_passantes.csv" | awk '{print $1}')
printf "%d\n" $file_size
echo "Arquivo Passantes com tamanho $file_size"

while [[ $file_size -le 0 ]]; do
  wget --tries=1 -O /home/you-spm/ent_pass/spm_passantes.csv "http://192.168.23.108:8002/local/people-counter/.api?export-csv&date=$dia1-$dia2&res=1h"
  file_size=$(wc -c "/home/you-spm/ent_pass/spm_passantes.csv" | awk '{print $1}')
  printf "%d\n" $file_size
done



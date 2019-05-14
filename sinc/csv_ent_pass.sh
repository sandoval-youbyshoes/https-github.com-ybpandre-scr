#!/bin/bash

echo "Baixando arquivos SPM na máquina"
ssh you-spm@10.0.254.29 "bash /home/you-spm/bx_arq_spm.sh"

echo "Sincronizando arquivos SPM"
rsync -avzh you-spm@10.0.254.29:/home/you-spm/ent_pass/* /home/you/grive/Giros/dados/entrantes_passantes

echo "Baixando arquivos TTP na máquina"
ssh you-ttp@10.0.254.33 "bash /home/you-ttp/bx_arq_ttp.sh"

echo "Sincronizando arquivos TTP"
rsync -avzh you-ttp@10.0.254.33:/home/you-ttp/ent_pass/* /home/you/grive/Giros/dados/entrantes_passantes

echo "Baixando arquivos IBR na máquina"
ssh ibirapuera@10.0.254.37 "bash /home/ibirapuera/bx_arq_ibr.sh"

echo "Sincronizando arquivos IBR"
rsync -avzh ibirapuera@10.0.254.37:/home/ibirapuera/ent_pass/* /home/you/grive/Giros/dados/entrantes_passantes

echo "Baixando arquivos ABC na máquina"
ssh you-abc@10.0.254.41 "bash /home/you-abc/bx_arq_abc.sh"

echo "Sincronizando arquivos ABC"
rsync -avzh you-abc@10.0.254.41:/home/you-abc/ent_pass/* /home/you/grive/Giros/dados/entrantes_passantes

echo "Baixando arquivos CNT na máquina"
ssh ybp-cnt@10.0.254.21 "bash /home/ybp-cnt/bx_arq_cnt.sh"

echo "Sincronizando arquivos CNT"
rsync -avzh ybp-cnt@10.0.254.21:/home/ybp-cnt/ent_pass/* /home/you/grive/Giros/dados/entrantes_passantes

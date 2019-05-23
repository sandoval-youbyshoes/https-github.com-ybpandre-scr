echo "excluindo arquivo antigo"

rm -rf /home/you/grive/Giros/dados/eval_odoo.csv

echo "Exportando Arquivo eval_odoo.csv"

mysql -u TI -psenhadoSQL1 YouHist < /home/you/grive/scr/sql/exportaEval.sql | sed 's/\t/;/g' > /home/you/grive/Giros/dados/eval_odoo.csv


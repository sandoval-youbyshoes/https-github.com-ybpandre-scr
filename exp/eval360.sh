echo "Exportando Arquivo eval_odoo360.csv"

mysql -u TI -psenhadoSQL1 YouHist < /home/you/grive/scr/sql/exportaEval360.sql | sed 's/\t/;/g' > /home/you/grive/Giros/dados/eval_odoo360.csv
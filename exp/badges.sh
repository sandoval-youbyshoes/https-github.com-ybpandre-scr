cowthink "Exportando Arquivo BadgesLojas"

mysql -u TI -psenhadoSQL1 YouHist < /home/you/grive/scr/sql/BadgesLojas.sql | sed 's/\t/;/g' > /home/you/grive/Giros/dados/badges.csv


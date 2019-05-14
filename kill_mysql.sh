echo "   Eliminando querys abertas no mysql   "

mysql -u TI -psenhadoSQL1 -e "select id from information_schema.processlist" | while read id; 
do 
    if [[ "id" == "$id" ]]
    then
        continue
    fi
    echo "   Assassinando o processo $id   "
    mysql -u TI -psenhadoSQL1 -e "kill $id;"
done

echo "   Querys do mysql paradas   "
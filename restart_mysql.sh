processo=$(pgrep mysql)
echo "atando processo $processo do Mysql";
sudo kill -9 $processo;
echo "subindo nova instância do mysql"
sudo /etc/init.d/mysql start;
processoNovo=$(pgrep mysql)
echo "Mysql startado no processo $processoNovo"
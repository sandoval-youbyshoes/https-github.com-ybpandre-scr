cd /home/you/Temp/

rm -rf FotosMCMini/*

cd /mnt/z/FotosMC/
#cd /home/you/Temp/FotosMC/
#mcs=$(mysql -u TI -psenhadoSQL1 YouHist -se "SELECT concat(m.mc, '.jpg') as IMG FROM movimentos m INNER JOIN o_clients cli ON cli.cnpj_cpf = m.CPFouCNPJ WHERE m.tipo = 'V Adq Terc p Consumo' AND m.Quantidade > 0 AND cli.atualizado = 1 AND data >= (CURDATE()-INTERVAL 30 DAY) AND data <= CURDATE() AND cliente != 'Anonimo' AND SUBSTRING(cli.cliente, 1, 1) NOT IN ('0','1','2','3','4','5','6','7','8','9') AND SUBSTRING(m.mc, 1, 1) NOT IN ('0') GROUP BY m.MC ORDER BY m.MC")

mcs=$(mysql -u TI -psenhadoSQL1 YouHist -s < /home/you/grive/scr/sql/BI/img_bi.sql)

cp $mcs /home/you/Temp/FotosMCMini/

cd /home/you/Temp/FotosMCMini/

magick mogrify -resize 198x192 *.jpg

cp * /home/you/grive/Tomilhos/FotosMCMini/

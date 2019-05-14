/* 
  Importa lista de imagens existentes
  
  fazer:
  cd /Users/humberto/Documents/ImagensProdutosPiccadilly/FotosMC/
  ls > ../listaImgs.csv
  
  ou
  
  ls /Users/humberto/Documents/ImagensProdutosPiccadilly/FotosMC/ > /Users/humberto/Documents/ImagensProdutosPiccadilly/listaImgs.csv
  
*/
TRUNCATE 3IboxBase.listaimgs;
load data local infile '/Users/humberto/Documents/ImagensProdutosPiccadilly/listaImgs.csv' 
into table 3IboxBase.listaimgs
character set UTF8
fields terminated by ','
OPTIONALLY ENCLOSED BY '"'
(nomeimg); # precisa disto se a tabela tiver campos calculados....
show warnings; 
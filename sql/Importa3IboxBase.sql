BEGIN;
# Tabela CATEGORIA
TRUNCATE 3IboxBase.CATEGORIA;
load data local infile '/Users/humberto/Documents/ImagensProdutosPiccadilly/DBs/CATEGORIA.csv' 
into table 3IboxBase.CATEGORIA
character set UTF8
fields terminated by ','
OPTIONALLY ENCLOSED BY '"'
ignore 1 lines
(ID_CATEGORIA,NOME,ORDEM,EXIBE_CARRINHO); # precisa disto se a tabela tiver campos calculados....
show warnings; 

# Tabela CATEGORIA_VALOR
TRUNCATE 3IboxBase.CATEGORIA_VALOR;
load data local infile '/Users/humberto/Documents/ImagensProdutosPiccadilly/DBs/CATEGORIA_VALOR.csv'
into table 3IboxBase.CATEGORIA_VALOR
character set UTF8
fields terminated by ','
OPTIONALLY ENCLOSED BY '"'
ignore 1 lines
(ID_CATEGORIA_VALOR,ID_CATEGORIA,DESCRICAO,ORDEM,CODIGO_ERP); # precisa disto se a tabela tiver campos calculados....
show warnings; 

SET SQL_SAFE_UPDATES=0;
UPDATE 3IboxBase.CATEGORIA_VALOR SET DESCRICAO = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(CONCAT(UPPER(SUBSTR(DESCRICAO,1,1)),LOWER(SUBSTR(DESCRICAO,2))),' a',' A'),' b',' B'),' c',' C'),' d',' D'),' e',' E'),' f',' F'),' g',' G'),' h',' H'),' i',' I'),' j',' J'),' k',' K'),' l',' L'),' m',' M'),' n',' N'),' o',' O'),' p',' P'),' q',' Q'),' r',' R'),' s',' S'),' t',' T'),' u',' U'),' v',' V'),' w',' W'),' x',' X'),' y',' Y'),' z',' Z');
UPDATE 3IboxBase.CATEGORIA_VALOR SET DESCRICAO = REPLACE(DESCRICAO,' E ',' e ');
UPDATE 3IboxBase.CATEGORIA_VALOR SET DESCRICAO = REPLACE(DESCRICAO,' De ',' de ');
UPDATE 3IboxBase.CATEGORIA_VALOR SET DESCRICAO = REPLACE(DESCRICAO,' Da ',' da ');
UPDATE 3IboxBase.CATEGORIA_VALOR SET DESCRICAO = REPLACE(DESCRICAO,' Do ',' do ');
UPDATE 3IboxBase.CATEGORIA_VALOR SET DESCRICAO = REPLACE(DESCRICAO,' Ao ',' ao ');
UPDATE 3IboxBase.CATEGORIA_VALOR SET DESCRICAO = REPLACE(DESCRICAO,' Para ',' para ');
SET SQL_SAFE_UPDATES=1;

# Tabela COMBINACAO
TRUNCATE 3IboxBase.COMBINACAO;
load data local infile '/Users/humberto/Documents/ImagensProdutosPiccadilly/DBs/COMBINACAO.csv' 
into table 3IboxBase.COMBINACAO
character set UTF8
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' # Precisa pq o Campo Imagem tem um \ no meio... (usar NULL para campos com NULL)
ESCAPED BY ''
ignore 1 lines
(ID_COMBINACAO,NOME,REFERENCIA,ID_MODELO,ID_DIVISAO,OBSERVACAO,IMAGEM,ORDEM,RNK_REPR_VENDAS,RNK_NAC_VENDAS,TIPO,PODE_VENDER,GRADE,DT_ENTREGA,IMAGEM_ESPECIAL,IMAGEM_EXTRA,NCM,TAMANHO_GRANDE,ALTURA_SALTO,ID_GRADE); # precisa disto se a tabela tiver campos calculados....
show warnings; 

# Tabela COMBINACAO_CATEGORIA
TRUNCATE 3IboxBase.COMBINACAO_CATEGORIA;
load data local infile '/Users/humberto/Documents/ImagensProdutosPiccadilly/DBs/COMBINACAO_CATEGORIA.csv' 
into table 3IboxBase.COMBINACAO_CATEGORIA
character set UTF8
fields terminated by ','
OPTIONALLY ENCLOSED BY '"'
ignore 1 lines
(ID_COMBINACAO_CATEGORIA,ID_COMBINACAO,ID_CATEGORIA_VALOR); # precisa disto se a tabela tiver campos calculados....
show warnings;

# Tabela COMBINACAO_IMAGEM_EXTRA
TRUNCATE 3IboxBase.COMBINACAO_IMAGEM_EXTRA;
load data local infile '/Users/humberto/Documents/ImagensProdutosPiccadilly/DBs/COMBINACAO_IMAGEM_EXTRA.csv' 
into table 3IboxBase.COMBINACAO_IMAGEM_EXTRA
character set UTF8
fields terminated by ','
OPTIONALLY ENCLOSED BY '"'
ignore 1 lines
(ID_COMBINACAO_IMAGEM_EXTRA,ID_COMBINACAO,IMAGEM,ORDEM); # precisa disto se a tabela tiver campos calculados....
show warnings;

/* - Problema: as tabelas estao vazias... (21/Mar/2018)
# Tabela TABELA_PRECO
TRUNCATE 3IboxBase.TABELA_PRECO;
load data local infile '/Users/humberto/Documents/ImagensProdutosPiccadilly/DBs/TABELA_PRECO.csv' 
into table 3IboxBase.TABELA_PRECO
character set UTF8
fields terminated by ','
OPTIONALLY ENCLOSED BY '"'
ignore 1 lines
(ID_TABELA_PRECO,DESCRICAO,SIGLA_MOEDA,ARREDONDA_TABELA); # precisa disto se a tabela tiver campos calculados....
show warnings;

# Tabela TABELA_PRECO_ITEM
TRUNCATE 3IboxBase.TABELA_PRECO_ITEM;
load data local infile '/Users/humberto/Documents/ImagensProdutosPiccadilly/DBs/TABELA_PRECO_ITEM.csv' 
into table 3IboxBase.TABELA_PRECO_ITEM
character set UTF8
fields terminated by ','
OPTIONALLY ENCLOSED BY '"'
ignore 1 lines
(ID_TABELA_PRECO_ITEM,ID_TABELA_PRECO,ID_COMBINACAO,PRECO); # precisa disto se a tabela tiver campos calculados....
show warnings;
*/

# atualiza data e usuario que atualizou esta tabela
INSERT INTO 
   YouHist.TableUpdates
    (`NomeTabela`,`LUpdate`,`User`)
VALUES 
    ('3IboxBase', now(), CURRENT_USER() )
ON DUPLICATE KEY UPDATE 
    LUpdate=now(), 
    User=CURRENT_USER();

Commit;
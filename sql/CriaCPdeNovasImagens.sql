/* 
  Cria lista de imagens novas e comandos para move-las do diretorio do VIP para o nosso com o nome certo.
  Se baseia numa tabela oriunda da lista de arquivos de imagens (listaimgs) que deve ser atualizada antes de rodar esta query.
*/
select 
   concat("cp '",Imagem,"' ../../FotosMC/",MC,".jpg") as cmd
from (
SELECT 
    *,
    concat(referencia,right(concat('000000000',ordem),8)) as MC,
    concat(referencia,right(concat('000000000',ordem),8),".jpg") as nomeimg
FROM
    3IboxBase.COMBINACAO
) X
Left join 3IboxBase.listaimgs LST USING (nomeimg)
Where Imagem is not null
AND LST.nomeimg is null

    
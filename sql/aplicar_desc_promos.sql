select
	dados.LocalC as loja,
	dados.ModeloCor as mc,
	prod.name as nome,
	replace(eval.PrecoOriginal,'.',',') as `Preco Original`,
	replace((( dados.PrecoAtual - dados.resto ) -0.10 ),'.',',') as `Preco Novo`
from
	(
	-- Entrada de dados básicos
	select
		*,
		( PrecoAtual % 100 ) as resto,
		( PrecoAtual / 10 ) as dez
	from
		precoslojasatuais
	where
		PrecoAtual > 100 ) as dados,
	o_products as prod,
	new_eval as eval
	-- Fim da query de dados
where
	dados.dez > dados.resto
	and dados.modelocor = substring( prod.sku, 1, 14 )
	and dados.modelocor = eval.ModeloCor
	group by 1,2,3,4,5 order by 1,2 asc
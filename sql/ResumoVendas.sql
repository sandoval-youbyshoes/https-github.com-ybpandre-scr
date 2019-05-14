select local, sum(Total) as Tot, 
         sum(Quantidade) as Pares, count(*) as linhas, 
		 min(DataHora) as quando, max(DataHora), min(Dia), max(Dia), datediff(Max(dia),Min(Dia)) as dias_ativo, 
         count(distinct CPFouCNPJ) as CPF_un,count(distinct ticket) as Tickets_un, 
         count(distinct MC) as MC_un, count(DISTINCT SKU) as SKU_un 
from Movimentos 
where tipo='V Adq Terc p Consumo' group by Local

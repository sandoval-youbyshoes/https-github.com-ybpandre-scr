select 
   VDCLI.*,
   CLI.legal_name, CLI.telefone, CLI.celular, CLI.email, CLI.cidade
from (
select local, CPFouCNPJ, MC, sum(Total) as Tot, 
         sum(Quantidade) as Pares, count(*) as linhas, 
		 min(DataHora) as quando, max(DataHora), min(Dia), max(Dia), datediff(Max(dia),Min(Dia)) as dias_ativo, 
         count(distinct ticket) as Tickets_un, 
         count(distinct MC) as MC_un, count(DISTINCT SKU) as SKU_un 
from Movimentos
where tipo='V Adq Terc p Consumo'
   AND CPFok=1 AND isCPF=1
group by CPFouCNPJ, Local, MC
) VDCLI
left join o_clients CLI on (VDCLI.CPFouCNPJ=CLI.cnpj_cpf)


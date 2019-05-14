Drop table if exists TmpAcompDia;
set @old_sql_mode = @@sql_mode; 
set sql_mode = ''; 
Create Table TmpAcompDia (local VarChar(20), data date, mes varchar(9), Semana varchar(8), MinHoraVd time, MaxHoraVd time,
    NumTickets  decimal(6,0), qtdLiq  decimal(10,0), qtdBruta  decimal(10,0), PercTrDev decimal(5,2), ParesPorTicket decimal(12,2),
    valorLiq decimal(15,2), TicketMedio decimal(15,2), margem decimal(15,2), NumSKUs decimal(10,0), NumMCs decimal(10,0) )
ENGINE = MEMORY
as
SELECT * from acompanhamentodiario
where data between now() - interval 8 day and now() - interval 1 day
-- where data between '2018-08-06' and '2018-08-12'
;
set sql_mode = @old_sql_mode;

(select 
   'Quem Cedo Madruga' as Tipo,
   'venda mais cedo' as DiaCom,
   'Semanal' as Frequencia, 
   A.*
from TmpAcompDia A
Order by MinHoraVd ASC
Limit 1)
UNION 
(select 
   'Bohemia' as Tipo,
   'venda mais tarde' as DiaCom,
   'Semanal' as Frequencia, 
   A.*
from TmpAcompDia A
Order by MaxHoraVd DESC
Limit 1)
UNION
(select 
   'de Sol a Sol' as Tipo,
   'mais tempo de vendas' as DiaCom,
   'Semanal' as Frequencia, 
   A.*
from TmpAcompDia A
Order by (MaxHoraVd-MinHoraVd) Desc
Limit 1)
UNION(select 
   'Metralhadora' as Tipo,
   'mais pares vendidos (liq)' as DiaCom,
   'Semanal' as Frequencia, 
   A.*
from TmpAcompDia A
Order by qtdLiq DESC
Limit 1)
UNION
(select 
   'Atendedora' as Tipo,
   'mais tickets' as DiaCom,
   'Semanal' as Frequencia, 
   A.*
from TmpAcompDia A
Order by NumTickets DESC
Limit 1)
UNION
(select 
   'Pote de ouro' as Tipo,
   'maior valor vendido (liq)' as DiaCom,
   'Semanal' as Frequencia, 
   A.*
from TmpAcompDia A
Order by valorLiq DESC, qtdLiq Desc
Limit 1)
UNION
(select 
   'Lucrativa' as Tipo,
   'mais margem gerada' as DiaCom,
   'Semanal' as Frequencia, 
   A.*
from TmpAcompDia A
Order by margem DESC, qtdLiq Desc
Limit 1)
UNION
(select 
   'TicketPopular' as Tipo,
   'mais unidades por ticket medio' as DiaCom,
   'Semanal' as Frequencia, 
   A.*
from TmpAcompDia A
Order by ParesPorTicket DESC, qtdLiq Desc
Limit 1)
UNION
(select 
   'TicketGordo' as Tipo,
   'maior valor por ticket medio' as DiaCom,
   'Semanal' as Frequencia, 
   A.*
from TmpAcompDia A
Order by TicketMedio DESC
Limit 1)
UNION
(select 
   'UmDeCada' as Tipo,
   'maior variedade de MCs' as DiaCom,
   'Semanal' as Frequencia, 
   A.*
from TmpAcompDia A
Order by NumMCs DESC
Limit 1)
UNION
(select 
   'Definitivo' as Tipo,
   'menor troca/devolucao' as DiaCom,
   'Semanal' as Frequencia, 
   A.*
from TmpAcompDia A
Order by PercTrDev ASC, qtdLiq Desc
Limit 1)
UNION
(select 
   'Caiu na Rede' as Tipo,
   'maior conversao' as DiaCom,
   'Semanal' as Frequencia, 
   A.*
from TmpAcompDia A
Order by Conversao Desc, qtdLiq Desc
Limit 1)
UNION
(select 
   'Magnetica' as Tipo,
   'mais entrantes' as DiaCom,
   'Semanal' as Frequencia, 
   A.*
from TmpAcompDia A
Order by Entrantes Desc, qtdLiq Desc
Limit 1)

;

Drop table TmpAcompDia;
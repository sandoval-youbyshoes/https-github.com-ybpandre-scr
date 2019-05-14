/* 
para a planilha Descontados2018.xlsx 
*/
SELECT
    Local, Dia, Desconto,
    any_value(Descontado)  as Descontado,
    count(distinct SKU)    as NumSKUs,
    count(distinct MC)     as NumMCs,
    count(distinct ticket) as NumTickets,
    sum(quantidade)        as VendasUn,
    sum(Total)             as VendasFat
FROM
    YouHist.descontos2018
GROUP BY Local, Dia, Desconto
Order by Dia Desc, Local Asc, Desconto Asc
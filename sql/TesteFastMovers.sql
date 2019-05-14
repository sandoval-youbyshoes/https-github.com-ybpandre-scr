/*

Query de avaliacao de fastmovers

*/
SELECT 
   C.modelocor,
   C.velvdun,
   C.velvdun360,
   C.unidadesvendidasliquido,
   C.campeaoglobal,
   C.EstoqueEmMaos as EstEMEMP,
   if(C.NumVezesCampGlobal>0,1,0) as FoiCampeao,
   C.colecao,
   C.numlojasativo,
   C.NumLojasGCentralEmp,
   if((C.Colecao='2018-1-OUTINV' AND C.campeaoglobal=1) OR (Colecao='GERAL'),1,0) as AtivoCompra,
    if(C.velvdun>=0.555,1,0)  as FastMover,
    M.VendasUn As VendasUn45,
    M.VendasValor As VendasValor45
FROM
    YouHist.cadastromc C
    left join (
    SELECT 
    MC 							AS modelocor,
    SUM(Total) 				AS VendasValor,
    SUM(Quantidade) 	AS VendasUn
FROM
    YouHist.Movimentos
WHERE
    TIPO = 'V Adq Terc p Consumo'
    and dia>=now() - interval 45 day
GROUP BY MC
HAVING VendasUn > 0
    ) M on (M.ModeloCor=C.ModeloCor)
where (C.EstoqueEmMaos+C.EstoqueEmTransito) >0
AND C.ModeloCor is not NULL
Order By VelVdUn Desc



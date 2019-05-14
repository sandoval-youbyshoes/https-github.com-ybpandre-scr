/* 

Avaliacao de Descontos por tamanho, categoria e local 

Uso: Planilha PAINELPROMO2018.XLSX

*/
Select 
   Localc,
   IfNull(TipoNovo,'NA') As TipoNovo,
   Desconto,
   Tamanho,
   Sum(EstoqueEmMaos) as EstEM,
   Sum(EstoqueEmTransito) as EstET,
   round(Sum(VelVdUn),2) As VelVdUn,
   count(distinct if((EstoqueEmMaos+EstoqueEmTransito)>0,ModeloCor,NULL)) as NumMCs
From
    (SELECT 
        Ev.*,
		Pr.PrecoAtual,
		-- IF(LOCATE(LEFT(Ev.ModeloCor, 1), 'FC') > 0, LEFT(Ev.ModeloCor, 7), LEFT(Ev.ModeloCor, 6)) AS Modelo,
        if(Pr.PrecoAtual < 0.9*Ev.PrecoOriginal,1,0) as DescontadoAtual,
        greatest(0,ifnull(round(100*round(1-Pr.PrecoAtual/Ev.PrecoOriginal,1),0),0)) AS Desconto,
		Mt.TipoNovo,
        Mt.NumMcs
    FROM
        YouHist.evalcomcd Ev
    LEFT JOIN precoslojasatuais Pr USING (ModeloCor,LocalC)
    LEFT JOIN ModelosTipos Mt ON (IF(LOCATE(LEFT(Ev.ModeloCor, 1), 'FC') > 0, LEFT(Ev.ModeloCor, 7), LEFT(Ev.ModeloCor, 6)) = Mt.Modelo)
    WHERE
        Ev.LocalC <> 'NA' /* AND Ev.LocalC <>'0-CD' */ AND Ev.LocalC <>'2-TAM' AND Ev.LocalC<>'7-OSA'
		AND Ev.ModeloCor IS NOT NULL
		AND Tamanho >=33 AND Tamanho <= 40
	) Tab
Group By Localc, TipoNovo, Desconto, Tamanho  -- WITH ROLLUP
  
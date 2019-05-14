SELECT
	* 
FROM(
SELECT
	local,
	ModeloCor,
    colecao,
    sum(Alvo) as alvo,
	max( DCEADJ ) AS DCE,
	max( DIASATIVO ) AS DiasAtivo,
	sum( unidvendliq ) AS vendas,
	max( campglobal ) AS camp,
	sum( estCDEM ) AS ESTCD,
	sum( esttotal ) AS est,
	max( descontado ) AS desconto 
FROM
	new_eval where local != 'Youbyshoes Centro de Distribuicao' and colecao != 'Geral' group by 1,2,3
	) a 
WHERE
	((DiasAtivo > 14 and vendas < 2) or (DiasAtivo > 29 and vendas < 3) or (DiasAtivo > 45 and vendas < 4)) and colecao = 'PV1819' and est > 0 and alvo > 0 and desconto < 1 and estcd < 12 and camp < 1 group by 1,2,3 
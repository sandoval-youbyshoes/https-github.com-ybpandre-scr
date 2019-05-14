SELECT
	spm.MC
	,'ES 03 SP Market' as Local
	,MAX(spm.precoatual) as precoatual
	,SUM(spm.Tam33) AS `33`
	,SUM(spm.Tam34) AS `34`
	,SUM(spm.Tam35) AS `35`
	,SUM(spm.Tam36) AS `36`
	,SUM(spm.Tam37) AS `37`
	,SUM(spm.Tam38) AS `38`
	,SUM(spm.Tam39) AS `39`
	,SUM(spm.Tam40) AS `40`
-- 	*
FROM
	(
	SELECT
		EvalComCdn.ModeloCor AS MC,
		max(`EvalComCdn`.DiasAtivo) as DiasAtivo,
		SUM(EvalComCdn.VELVDUN) AS VelVdUn,
		SUM(EvalComCdn.VELGANHOPER) AS VelGanhoPer,
		SUM(EvalComCdn.EstTotal) AS EstTot,
		max(if(Tamanho=33,1,0)*EstoqueEmMaos) as Tam33,
		max(if(Tamanho=34,1,0)*EstoqueEmMaos) as Tam34,
		max(if(Tamanho=35,1,0)*EstoqueEmMaos) as Tam35,
		max(if(Tamanho=36,1,0)*EstoqueEmMaos) as Tam36,
		max(if(Tamanho=37,1,0)*EstoqueEmMaos) as Tam37,
		max(if(Tamanho=38,1,0)*EstoqueEmMaos) as Tam38,
		max(if(Tamanho=39,1,0)*EstoqueEmMaos) as Tam39,
		max(if(Tamanho=40,1,0)*EstoqueEmMaos) as Tam40,
		round(min(evalComCdn.PrecoCorrente),2) as PrecoAtual
	FROM
		EvalComCdn
	WHERE
		LOCAL = 'Youbyshoes Loja 03 SP Market'
		AND ModeloCor is not null
		AND (PrimeiraMovimentacao <>"Sem movimentacao")
		AND Col<>'GERAL'
	GROUP BY
		EvalComCdn.ModeloCor
	HAVING
		(EstTot > 0)
		AND DiasAtivo <= 21
	ORDER BY
		SUM(EvalComCdn.VELGANHOPER) DESC
	) as spm
GROUP BY
	spm.mc
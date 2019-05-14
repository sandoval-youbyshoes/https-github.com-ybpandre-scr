(
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
)
UNION ALL
(
SELECT
	ttp.MC
	,'ES 04 Tatuape' as Local
	,MAX(ttp.precoatual) as precoatual
	,SUM(ttp.Tam33) AS `33`
	,SUM(ttp.Tam34) AS `34`
	,SUM(ttp.Tam35) AS `35`
	,SUM(ttp.Tam36) AS `36`
	,SUM(ttp.Tam37) AS `37`
	,SUM(ttp.Tam38) AS `38`
	,SUM(ttp.Tam39) AS `39`
	,SUM(ttp.Tam40) AS `40`
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
		LOCAL = 'Youbyshoes Loja 04 Tatuape'
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
	) as ttp
GROUP BY
	ttp.mc
)
UNION ALL
(
SELECT
	ibr.MC
	,'ES 05 Ibirapuera' as Local
	,MAX(ibr.precoatual) as precoatual
	,SUM(ibr.Tam33) AS `33`
	,SUM(ibr.Tam34) AS `34`
	,SUM(ibr.Tam35) AS `35`
	,SUM(ibr.Tam36) AS `36`
	,SUM(ibr.Tam37) AS `37`
	,SUM(ibr.Tam38) AS `38`
	,SUM(ibr.Tam39) AS `39`
	,SUM(ibr.Tam40) AS `40`
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
		LOCAL = 'Youbyshoes Loja 05 Ibirapuera'
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
	) as ibr
GROUP BY
	ibr.mc
)
UNION ALL
(
SELECT
	abc.MC
	,'ES 06 ABC' as Local
	,MAX(abc.precoatual) as precoatual
	,SUM(abc.Tam33) AS `33`
	,SUM(abc.Tam34) AS `34`
	,SUM(abc.Tam35) AS `35`
	,SUM(abc.Tam36) AS `36`
	,SUM(abc.Tam37) AS `37`
	,SUM(abc.Tam38) AS `38`
	,SUM(abc.Tam39) AS `39`
	,SUM(abc.Tam40) AS `40`
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
		LOCAL = 'Youbyshoes Loja 06 ABC'
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
	) as abc
GROUP BY
	abc.mc
)
UNION ALL
(
SELECT
	cnt.MC
	,'ES 07 Center Norte' as Local
	,MAX(cnt.precoatual) as precoatual
	,SUM(cnt.Tam33) AS `33`
	,SUM(cnt.Tam34) AS `34`
	,SUM(cnt.Tam35) AS `35`
	,SUM(cnt.Tam36) AS `36`
	,SUM(cnt.Tam37) AS `37`
	,SUM(cnt.Tam38) AS `38`
	,SUM(cnt.Tam39) AS `39`
	,SUM(cnt.Tam40) AS `40`
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
		LOCAL = 'Youbyshoes Loja 07 Center Norte'
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
	) as cnt
GROUP BY
	cnt.mc
)
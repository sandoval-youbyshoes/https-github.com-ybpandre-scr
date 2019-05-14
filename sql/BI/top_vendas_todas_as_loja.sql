(
	SELECT
		aa.MC
        ,'ES 03 SP Market' as Local
		,MAX(aa.precoatual) as precoatual
		,SUM(`33`) AS `33`
		,SUM(`34`) AS `34`
		,SUM(`35`) AS `35`
		,SUM(`36`) AS `36`
		,SUM(`37`) AS `37`
		,SUM(`38`) AS `38`
		,SUM(`39`) AS `39`
		,SUM(`40`) AS `40`
	FROM
		(
		SELECT
			tmp.MC
			,tmp.precoatual
			,CASE WHEN ec.tamanho = 33 THEN estoqueemmaos ELSE 0 END `33`
			,CASE WHEN ec.tamanho = 34 THEN estoqueemmaos ELSE 0 END `34`
			,CASE WHEN ec.tamanho = 35 THEN estoqueemmaos ELSE 0 END `35`
			,CASE WHEN ec.tamanho = 36 THEN estoqueemmaos ELSE 0 END `36`
			,CASE WHEN ec.tamanho = 37 THEN estoqueemmaos ELSE 0 END `37`
			,CASE WHEN ec.tamanho = 38 THEN estoqueemmaos ELSE 0 END `38`
			,CASE WHEN ec.tamanho = 39 THEN estoqueemmaos ELSE 0 END `39`
			,CASE WHEN ec.tamanho = 40 THEN estoqueemmaos ELSE 0 END `40`
		FROM
			(
			SELECT
				EvalComCdn.ModeloCor AS MC,
				SUM(EvalComCdn.VELVDUN) AS VelVdUn,
				SUM(EvalComCdn.VELGANHOPER)  AS VelGanhoPer,
				SUM(EvalComCdn.EstTotal) AS EstTot,
				ROUND(MIN(IFNULL(P.PrecoAtual,PrecoPadrao)), 2) as PrecoAtual
			FROM
				EvalComCdn
					LEFT JOIN PrecosLojasAtuais P USING (ModeloCor,LocalC)
			WHERE
				LOCALC= '3-SPM' AND ModeloCor IS NOT NULL AND (PrimeiraMovimentacao <> "Sem movimentacao") AND Colecao <> 'GERAL'
			GROUP BY
				EvalComCdn.ModeloCor
			HAVING
				(EstTot > 0) AND VelVdUn > 0
			ORDER BY
				SUM(VELGANHOPER) DESC
			LIMIT 24
			) as tmp
			INNER JOIN evalcomcdn ec ON ec.modelocor = tmp.mc
		WHERE
			ec.LOCALC= '3-SPM'
		ORDER BY
			tmp.velganhoper DESC
		) AS aa
	GROUP BY
		AA.MC
)
UNION ALL
(
	SELECT
		aa.MC
        ,'ES 04 Tatuape' as Local
		,MAX(aa.precoatual) as precoatual
		,SUM(`33`) AS `33`
		,SUM(`34`) AS `34`
		,SUM(`35`) AS `35`
		,SUM(`36`) AS `36`
		,SUM(`37`) AS `37`
		,SUM(`38`) AS `38`
		,SUM(`39`) AS `39`
		,SUM(`40`) AS `40`
	FROM
		(
		SELECT
			tmp.MC
			,tmp.precoatual
			,CASE WHEN ec.tamanho = 33 THEN estoqueemmaos ELSE 0 END `33`
			,CASE WHEN ec.tamanho = 34 THEN estoqueemmaos ELSE 0 END `34`
			,CASE WHEN ec.tamanho = 35 THEN estoqueemmaos ELSE 0 END `35`
			,CASE WHEN ec.tamanho = 36 THEN estoqueemmaos ELSE 0 END `36`
			,CASE WHEN ec.tamanho = 37 THEN estoqueemmaos ELSE 0 END `37`
			,CASE WHEN ec.tamanho = 38 THEN estoqueemmaos ELSE 0 END `38`
			,CASE WHEN ec.tamanho = 39 THEN estoqueemmaos ELSE 0 END `39`
			,CASE WHEN ec.tamanho = 40 THEN estoqueemmaos ELSE 0 END `40`
		FROM
			(
			SELECT
				EvalComCdn.ModeloCor AS MC,
				SUM(EvalComCdn.VELVDUN) AS VelVdUn,
				SUM(EvalComCdn.VELGANHOPER)  AS VelGanhoPer,
				SUM(EvalComCdn.EstTotal) AS EstTot,
				ROUND(MIN(IFNULL(P.PrecoAtual,PrecoPadrao)), 2) as PrecoAtual
			FROM
				EvalComCdn
					LEFT JOIN PrecosLojasAtuais P USING (ModeloCor,LocalC)
			WHERE
				LOCALC= '4-TTP' AND ModeloCor IS NOT NULL AND (PrimeiraMovimentacao <> "Sem movimentacao") AND Colecao <> 'GERAL'
			GROUP BY
				EvalComCdn.ModeloCor
			HAVING
				(EstTot > 0) AND VelVdUn > 0
			ORDER BY
				SUM(VELGANHOPER) DESC
			LIMIT 24
			) as tmp
			INNER JOIN evalcomcdn ec ON ec.modelocor = tmp.mc
		WHERE
			ec.LOCALC= '4-TTP'
		ORDER BY
			tmp.velganhoper DESC
		) AS aa
	GROUP BY
		AA.MC
)
UNION ALL
(
	SELECT
		aa.MC
        ,'ES 05 Ibirapuera' as Local
		,MAX(aa.precoatual) as precoatual
		,SUM(`33`) AS `33`
		,SUM(`34`) AS `34`
		,SUM(`35`) AS `35`
		,SUM(`36`) AS `36`
		,SUM(`37`) AS `37`
		,SUM(`38`) AS `38`
		,SUM(`39`) AS `39`
		,SUM(`40`) AS `40`
	FROM
		(
		SELECT
			tmp.MC
			,tmp.precoatual
			,CASE WHEN ec.tamanho = 33 THEN estoqueemmaos ELSE 0 END `33`
			,CASE WHEN ec.tamanho = 34 THEN estoqueemmaos ELSE 0 END `34`
			,CASE WHEN ec.tamanho = 35 THEN estoqueemmaos ELSE 0 END `35`
			,CASE WHEN ec.tamanho = 36 THEN estoqueemmaos ELSE 0 END `36`
			,CASE WHEN ec.tamanho = 37 THEN estoqueemmaos ELSE 0 END `37`
			,CASE WHEN ec.tamanho = 38 THEN estoqueemmaos ELSE 0 END `38`
			,CASE WHEN ec.tamanho = 39 THEN estoqueemmaos ELSE 0 END `39`
			,CASE WHEN ec.tamanho = 40 THEN estoqueemmaos ELSE 0 END `40`
		FROM
			(
			SELECT
				EvalComCdn.ModeloCor AS MC,
				SUM(EvalComCdn.VELVDUN) AS VelVdUn,
				SUM(EvalComCdn.VELGANHOPER)  AS VelGanhoPer,
				SUM(EvalComCdn.EstTotal) AS EstTot,
				ROUND(MIN(IFNULL(P.PrecoAtual,PrecoPadrao)), 2) as PrecoAtual
			FROM
				EvalComCdn
					LEFT JOIN PrecosLojasAtuais P USING (ModeloCor,LocalC)
			WHERE
				LOCALC= '5-IBR' AND ModeloCor IS NOT NULL AND (PrimeiraMovimentacao <> "Sem movimentacao") AND Colecao <> 'GERAL'
			GROUP BY
				EvalComCdn.ModeloCor
			HAVING
				(EstTot > 0) AND VelVdUn > 0
			ORDER BY
				SUM(VELGANHOPER) DESC
			LIMIT 24
			) as tmp
			INNER JOIN evalcomcdn ec ON ec.modelocor = tmp.mc
		WHERE
			ec.LOCALC= '5-IBR'
		ORDER BY
			tmp.velganhoper DESC
		) AS aa
	GROUP BY
		AA.MC
)
UNION ALL
(
	SELECT
		aa.MC
        ,'ES 06 ABC' as Local
		,MAX(aa.precoatual) as precoatual
		,SUM(`33`) AS `33`
		,SUM(`34`) AS `34`
		,SUM(`35`) AS `35`
		,SUM(`36`) AS `36`
		,SUM(`37`) AS `37`
		,SUM(`38`) AS `38`
		,SUM(`39`) AS `39`
		,SUM(`40`) AS `40`
	FROM
		(
		SELECT
			tmp.MC
			,tmp.precoatual
			,CASE WHEN ec.tamanho = 33 THEN estoqueemmaos ELSE 0 END `33`
			,CASE WHEN ec.tamanho = 34 THEN estoqueemmaos ELSE 0 END `34`
			,CASE WHEN ec.tamanho = 35 THEN estoqueemmaos ELSE 0 END `35`
			,CASE WHEN ec.tamanho = 36 THEN estoqueemmaos ELSE 0 END `36`
			,CASE WHEN ec.tamanho = 37 THEN estoqueemmaos ELSE 0 END `37`
			,CASE WHEN ec.tamanho = 38 THEN estoqueemmaos ELSE 0 END `38`
			,CASE WHEN ec.tamanho = 39 THEN estoqueemmaos ELSE 0 END `39`
			,CASE WHEN ec.tamanho = 40 THEN estoqueemmaos ELSE 0 END `40`
		FROM
			(
			SELECT
				EvalComCdn.ModeloCor AS MC,
				SUM(EvalComCdn.VELVDUN) AS VelVdUn,
				SUM(EvalComCdn.VELGANHOPER)  AS VelGanhoPer,
				SUM(EvalComCdn.EstTotal) AS EstTot,
				ROUND(MIN(IFNULL(P.PrecoAtual,PrecoPadrao)), 2) as PrecoAtual
			FROM
				EvalComCdn
					LEFT JOIN PrecosLojasAtuais P USING (ModeloCor,LocalC)
			WHERE
				LOCALC= '6-ABC' AND ModeloCor IS NOT NULL AND (PrimeiraMovimentacao <> "Sem movimentacao") AND Colecao <> 'GERAL'
			GROUP BY
				EvalComCdn.ModeloCor
			HAVING
				(EstTot > 0) AND VelVdUn > 0
			ORDER BY
				SUM(VELGANHOPER) DESC
			LIMIT 24
			) as tmp
			INNER JOIN evalcomcdn ec ON ec.modelocor = tmp.mc
		WHERE
			ec.LOCALC= '6-ABC'
		ORDER BY
			tmp.velganhoper DESC
		) AS aa
	GROUP BY
		AA.MC
)
UNION ALL
(
	SELECT
		aa.MC
        ,'ES 07 Center Norte' as Local
		,MAX(aa.precoatual) as precoatual
		,SUM(`33`) AS `33`
		,SUM(`34`) AS `34`
		,SUM(`35`) AS `35`
		,SUM(`36`) AS `36`
		,SUM(`37`) AS `37`
		,SUM(`38`) AS `38`
		,SUM(`39`) AS `39`
		,SUM(`40`) AS `40`
	FROM
		(
		SELECT
			tmp.MC
			,tmp.precoatual
			,CASE WHEN ec.tamanho = 33 THEN estoqueemmaos ELSE 0 END `33`
			,CASE WHEN ec.tamanho = 34 THEN estoqueemmaos ELSE 0 END `34`
			,CASE WHEN ec.tamanho = 35 THEN estoqueemmaos ELSE 0 END `35`
			,CASE WHEN ec.tamanho = 36 THEN estoqueemmaos ELSE 0 END `36`
			,CASE WHEN ec.tamanho = 37 THEN estoqueemmaos ELSE 0 END `37`
			,CASE WHEN ec.tamanho = 38 THEN estoqueemmaos ELSE 0 END `38`
			,CASE WHEN ec.tamanho = 39 THEN estoqueemmaos ELSE 0 END `39`
			,CASE WHEN ec.tamanho = 40 THEN estoqueemmaos ELSE 0 END `40`
		FROM
			(
			SELECT
				EvalComCdn.ModeloCor AS MC,
				SUM(EvalComCdn.VELVDUN) AS VelVdUn,
				SUM(EvalComCdn.VELGANHOPER)  AS VelGanhoPer,
				SUM(EvalComCdn.EstTotal) AS EstTot,
				ROUND(MIN(IFNULL(P.PrecoAtual,PrecoPadrao)), 2) as PrecoAtual
			FROM
				EvalComCdn
					LEFT JOIN PrecosLojasAtuais P USING (ModeloCor,LocalC)
			WHERE
				LOCALC= '7-CNT' AND ModeloCor IS NOT NULL AND (PrimeiraMovimentacao <> "Sem movimentacao") AND Colecao <> 'GERAL'
			GROUP BY
				EvalComCdn.ModeloCor
			HAVING
				(EstTot > 0) AND VelVdUn > 0
			ORDER BY
				SUM(VELGANHOPER) DESC
			LIMIT 24
			) as tmp
			INNER JOIN evalcomcdn ec ON ec.modelocor = tmp.mc
		WHERE
			ec.LOCALC= '7-CNT'
		ORDER BY
			tmp.velganhoper DESC
		) AS aa
	GROUP BY
		AA.MC
)
SELECT
	DISTINCT(IMG)
FROM
	(
	(
		SELECT
			concat(m.mc, '.jpg') as IMG
		FROM
			movimentos m
				INNER JOIN o_clients cli ON cli.cnpj_cpf = m.CPFouCNPJ
		WHERE
			m.tipo = 'V Adq Terc p Consumo'
			AND m.Quantidade > 0
			AND cli.atualizado = 1
			-- AND data >= (CURDATE()-INTERVAL 30 DAY) AND data <= CURDATE()
			AND cliente != 'Anonimo'
			AND SUBSTRING(cli.cliente, 1, 1) NOT IN ('0','1','2','3','4','5','6','7','8','9') AND SUBSTRING(m.mc, 1, 1) NOT IN ('0') GROUP BY m.MC ORDER BY m.MC
	)
	UNION ALL
	(
		SELECT
			CONCAT(top_spm.mc, '.jpg') as IMG
		FROM
			(
			SELECT
				EvalComCdn.ModeloCor AS MC,
				SUM(EvalComCdn.VELVDUN) AS VelVdUn,
				SUM(EvalComCdn.EstTotal) AS EstTot
			FROM
				EvalComCdn
			WHERE
				LOCALC= '3-SPM' AND ModeloCor IS NOT NULL AND (PrimeiraMovimentacao <> "Sem movimentacao") AND Colecao <> 'GERAL'
			GROUP BY
				EvalComCdn.ModeloCor
			HAVING
				(EstTot > 0) AND VelVdUn > 0
			ORDER BY
				SUM(VELGANHOPER) DESC
			LIMIT 24
			) as top_spm
	)
	UNION ALL
	(
		SELECT
			CONCAT(top_spm.mc, '.jpg') as IMG
		FROM
			(
			SELECT
				EvalComCdn.ModeloCor AS MC,
				SUM(EvalComCdn.VELVDUN) AS VelVdUn,
				SUM(EvalComCdn.EstTotal) AS EstTot
			FROM
				EvalComCdn
			WHERE
				LOCALC= '4-TTP' AND ModeloCor IS NOT NULL AND (PrimeiraMovimentacao <> "Sem movimentacao") AND Colecao <> 'GERAL'
			GROUP BY
				EvalComCdn.ModeloCor
			HAVING
				(EstTot > 0) AND VelVdUn > 0
			ORDER BY
				SUM(VELGANHOPER) DESC
			LIMIT 24
			) as top_spm
	)
	UNION ALL
	(
		SELECT
			CONCAT(top_spm.mc, '.jpg') as IMG
		FROM
			(
			SELECT
				EvalComCdn.ModeloCor AS MC,
				SUM(EvalComCdn.VELVDUN) AS VelVdUn,
				SUM(EvalComCdn.EstTotal) AS EstTot
			FROM
				EvalComCdn
			WHERE
				LOCALC= '5-IBR' AND ModeloCor IS NOT NULL AND (PrimeiraMovimentacao <> "Sem movimentacao") AND Colecao <> 'GERAL'
			GROUP BY
				EvalComCdn.ModeloCor
			HAVING
				(EstTot > 0) AND VelVdUn > 0
			ORDER BY
				SUM(VELGANHOPER) DESC
			LIMIT 24
			) as top_spm
	)
	UNION ALL
	(
		SELECT
			CONCAT(top_spm.mc, '.jpg') as IMG
		FROM
			(
			SELECT
				EvalComCdn.ModeloCor AS MC,
				SUM(EvalComCdn.VELVDUN) AS VelVdUn,
				SUM(EvalComCdn.EstTotal) AS EstTot
			FROM
				EvalComCdn
			WHERE
				LOCALC= '6-ABC' AND ModeloCor IS NOT NULL AND (PrimeiraMovimentacao <> "Sem movimentacao") AND Colecao <> 'GERAL'
			GROUP BY
				EvalComCdn.ModeloCor
			HAVING
				(EstTot > 0) AND VelVdUn > 0
			ORDER BY
				SUM(VELGANHOPER) DESC
			LIMIT 24
			) as top_spm
	)
	UNION ALL
	(
		SELECT
			CONCAT(top_spm.mc, '.jpg') as IMG
		FROM
			(
			SELECT
				EvalComCdn.ModeloCor AS MC,
				SUM(EvalComCdn.VELVDUN) AS VelVdUn,
				SUM(EvalComCdn.EstTotal) AS EstTot
			FROM
				EvalComCdn
			WHERE
				LOCALC= '7-CNT' AND ModeloCor IS NOT NULL AND (PrimeiraMovimentacao <> "Sem movimentacao") AND Colecao <> 'GERAL'
			GROUP BY
				EvalComCdn.ModeloCor
			HAVING
				(EstTot > 0) AND VelVdUn > 0
			ORDER BY
				SUM(VELGANHOPER) DESC
			LIMIT 24
			) as top_spm   
	)
    UNION ALL
	(
		SELECT
			CONCAT(nov_spm.mc, '.jpg') as IMG
		FROM
			(
			SELECT
				EvalComCdn.ModeloCor AS MC,
				max(`EvalComCdn`.DiasAtivo) as DiasAtivo,
				SUM(EvalComCdn.VELVDUN) AS VelVdUn,
				SUM(EvalComCdn.EstTotal) AS EstTot
			FROM
				EvalComCdn
			WHERE
				LOCAL = 'Youbyshoes Loja 03 SP Market' AND ModeloCor is not null AND (PrimeiraMovimentacao <>"Sem movimentacao") AND Col<>'GERAL'
			GROUP BY
				EvalComCdn.ModeloCor
			HAVING
				(EstTot > 0) AND DiasAtivo <= 21
			ORDER BY
				SUM(EvalComCdn.VELGANHOPER) DESC
			) as nov_spm
	)
	UNION ALL
	(
		SELECT
			CONCAT(nov_ttp.mc, '.jpg') as IMG
		FROM
			(
			SELECT
				EvalComCdn.ModeloCor AS MC,
				max(`EvalComCdn`.DiasAtivo) as DiasAtivo,
				SUM(EvalComCdn.VELVDUN) AS VelVdUn,
				SUM(EvalComCdn.EstTotal) AS EstTot
			FROM
				EvalComCdn
			WHERE
				LOCAL = 'Youbyshoes Loja 04 Tatuape' AND ModeloCor is not null AND (PrimeiraMovimentacao <>"Sem movimentacao") AND Col<>'GERAL'
			GROUP BY
				EvalComCdn.ModeloCor
			HAVING
				(EstTot > 0) AND DiasAtivo <= 21
			ORDER BY
				SUM(EvalComCdn.VELGANHOPER) DESC
			) as nov_ttp
	)
	UNION ALL
	(
		SELECT
			CONCAT(nov_ibr.mc, '.jpg') as IMG
		FROM
			(
			SELECT
				EvalComCdn.ModeloCor AS MC,
				max(`EvalComCdn`.DiasAtivo) as DiasAtivo,
				SUM(EvalComCdn.VELVDUN) AS VelVdUn,
				SUM(EvalComCdn.EstTotal) AS EstTot
			FROM
				EvalComCdn
			WHERE
				LOCAL = 'Youbyshoes Loja 05 Ibirapuera' AND ModeloCor is not null AND (PrimeiraMovimentacao <>"Sem movimentacao") AND Col<>'GERAL'
			GROUP BY
				EvalComCdn.ModeloCor
			HAVING
				(EstTot > 0) AND DiasAtivo <= 21
			ORDER BY
				SUM(EvalComCdn.VELGANHOPER) DESC
			) as nov_ibr
	)
	UNION ALL
	(
		SELECT
			CONCAT(nov_abc.mc, '.jpg') as IMG
		FROM
			(
			SELECT
				EvalComCdn.ModeloCor AS MC,
				max(`EvalComCdn`.DiasAtivo) as DiasAtivo,
				SUM(EvalComCdn.VELVDUN) AS VelVdUn,
				SUM(EvalComCdn.EstTotal) AS EstTot
			FROM
				EvalComCdn
			WHERE
				LOCAL = 'Youbyshoes Loja 06 ABC' AND ModeloCor is not null AND (PrimeiraMovimentacao <>"Sem movimentacao") AND Col<>'GERAL'
			GROUP BY
				EvalComCdn.ModeloCor
			HAVING
				(EstTot > 0) AND DiasAtivo <= 21
			ORDER BY
				SUM(EvalComCdn.VELGANHOPER) DESC
			) as nov_abc
	)
	UNION ALL
	(
		SELECT
			CONCAT(nov_cnt.mc, '.jpg') as IMG
		FROM
			(
			SELECT
				EvalComCdn.ModeloCor AS MC,
				max(`EvalComCdn`.DiasAtivo) as DiasAtivo,
				SUM(EvalComCdn.VELVDUN) AS VelVdUn,
				SUM(EvalComCdn.EstTotal) AS EstTot
			FROM
				EvalComCdn
			WHERE
				LOCAL = 'Youbyshoes Loja 07 Center Norte' AND ModeloCor is not null AND (PrimeiraMovimentacao <>"Sem movimentacao") AND Col<>'GERAL'
			GROUP BY
				EvalComCdn.ModeloCor
			HAVING
				(EstTot > 0) AND DiasAtivo <= 21
			ORDER BY
				SUM(EvalComCdn.VELGANHOPER) DESC
			) as nov_cnt
	)
) AS imgs
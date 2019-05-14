SELECT 
    LocalC,
    ANY_VALUE(Local) as Local,
    ModeloCor,
    Tamanho,
    Any_value(SKU) as SKU,
    ANY_VALUE(Tipo) as Tipo,
    ANY_VALUE(col) as Colec,
    ANY_VALUE(CampeaoGlobal) as CampGlob,
    COUNT(DISTINCT SKU) as NumSKUs,
    SUM(AlvoAtual) as AlvoAtual,
    SUM(EstoqueEmMaos) as EstEM,
    SUM(EstoqueEmTransito) as EstET,
    SUM(UnidadesVendidasLiquido) AS VendasUnL,
    ROUND(SUM(VELVDUN), 3) AS VeloVendas,
    SUM(EstEMCD) AS EstCDEM,
    GREATEST(0, 2 - SUM(AlvoAtual)) AS AumentoAlvos,
    2 as AlvoNovo
FROM
    evalcomcd
WHERE
    (Tamanho >= 34 AND Tamanho <= 38)
GROUP BY ModeloCor , LocalC , Tamanho
HAVING EstCDEM > 12 AND VeloVendas > 0.01
    AND AumentoAlvos > 0 AND Tipo not in ("Palmilhas","Extra")
ORDER BY LocalC , ModeloCor , Tamanho
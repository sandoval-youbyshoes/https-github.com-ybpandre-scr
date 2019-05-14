Select
   BIG.*,
   Resumo.CatNumMCs,
   Resumo.CatEstoqueTotal,
   Resumo.CatNumMCsDisp,
   Resumo.CatNumMCsDispCent,
--   CONCAT($P(ImgPath), ModeloCor,'.jpg') AS ImageFile
   'xxx' as ImageFile
from ( -- BIG
Select
    Wrap.*,
    if(Wrap.MCNumSKUsDisp>=Wrap.MCNumSKUs,1,0) as MCisDisp,
    if(Wrap.MCNumSKUsDispCent>=Wrap.MCNumSKUsCent,1,0) as MCisDispCent,
    M.TipoNovo
from ( -- Wrap
SELECT 
    E.LocalC,
    E.ModeloCor,
    LEFT(E.ModeloCor,
            IF((LEFT(E.ModeloCor, 1) BETWEEN 'a' AND 'z'),
                7,
                6)) AS Modelo,
    count(distinct E.SKU) as NumSKUs,
    sum(EstoqueEmMaos) As EstoqueEmMaos,
    sum(EstoqueEmTransito) As EstoqueEmTransito,
    sum(AlvoAtual) As Alvo,
    min(DataCadastroAlvo) as DataCadastroAlvo,
    max(DataModificacaoAlvo) as MaxDataModificacaoAlvo,
    min(DataModificacaoAlvo) as MinDataModificacaoAlvo,
    max(DiasComEstoque) as DiasComEstoque,
    sum(UnidadesVendidasBruto) as UnidadesVendidasBruto,
    sum(ValorVendasBruto) as ValorVendasBruto,
    sum(UnidadesVendidasLiquido) as UnidadesVendidasLiquido,
    sum(ValorVendasLiquido) as ValorVendasLiquido,
    sum(UnidadesVendidasBruto360) as UnidadesVendidasBruto360,
    sum(ValorVendasBruto360) as ValorVendasBruto360,
    sum(UnidadesVendidasLiquido360) as UnidadesVendidasLiquido360,
    sum(ValorVendasLiquido360) as ValorVendasLiquido360,
    min(CustoUnitario) as CustoUnitario,
    max(PrecoCorrente) as PrecoCorrente,
    max(CampeaoGlobal) as Campeao,
    if(max(NumVezesCampGlobal)>0,1,0) as FoiCampeao,
    any_value(COL) as Colecao,
    max(E.DiasAtivo) as DiasAtivo,
    Min(DiasUltModAlvo) as DiasUltModAlvo,
    round(sum(VM.Ganho),2) as GANHOPER,
    sum(VELVDUN) as VELVDUN,
    round(sum(VM.VelGanho),2) as VELGANHOPER,
    round(sum(GANHOPER360),2) as GANHOPER360,
    round(sum(VELVDUN360),2) as VELVDUN360,
    round(sum(VELGANHOPER360),2) as VELGANHOPER360,
    sum(if(EstoqueEmMaos>0,1,0)) as MCNumSKUsDisp,
    sum(if(EstoqueEmMaos is not null,1,0)) as MCNumSKUs,
    sum(if((Tamanho between '34' and '38') AND EstoqueEmMaos>0,1,0)) as MCNumSKUsDispCent,
    sum(if((Tamanho between '34' and '38') AND EstoqueEmMaos is not null,1,0)) as MCNumSKUsCent,
    if(ifnull(min(ifnull(P.PrecoAtual,E.PrecoPadrao)),min(`E`.PrecoCorrente))<0.9*min(E.PrecoPadrao),1,0) As Descontado,
	ifnull(round(100-100*round(ifnull(min(ifnull(P.PrecoAtual,E.PrecoPadrao)),min(`E`.PrecoCorrente))/min(E.PrecoPadrao),1),0),0) AS Desconto,
	round(min(ifnull(P.PrecoAtual,E.PrecoPadrao)),2) as PrecoAtual,
    min(E.PrecoPadrao) as PrecoPadrao,
	round(min(`E`.PrecoOriginal),2) as PrecoOriginal
FROM
    eval30x360 E
LEFT JOIN PrecosLojasAtuais P USING (LocalC, ModeloCor)
LEFT JOIN VendasEGanhosMovimentos30d VM USING (SKU,Local)
Group by LocalC,ModeloCor
HAVING
    (EstoqueEmMaos+EstoqueEmTransito) > 0 AND Colecao <> 'Geral'
    AND LocalC<>'0-CD'
    ) Wrap
Left Join modelostipos M USING(Modelo)
) BIG
left Join
( -- Resumo
Select
    LocalC,
	TipoNovo,
	Count(distinct ModeloCor) as CatNumMCs,
	sum(EstoqueEmMaos) as CatTipoEstoqueEmMaos,
    sum(EstoqueEmTransito) as CatEstoqueEmTransito,
    sum(EstoqueEmMaos)+sum(EstoqueEmTransito) As CatEstoqueTotal,
    sum(MCDisp) as CatNumMCsDisp,
    sum(MCDispCent) as CatNumMCsDispCent
from ( -- WR
Select 
	TB.*,
    if(NumSKUsDisp>=NumSKUs,1,0) as MCDisp,
    if(NumSKUsDispCent>=NumSKUsCent,1,0) as MCDispCent,
    M.TipoNovo
from ( -- TB
select
    LocalC,
	ModeloCor,
    LEFT(ModeloCor,
            IF((LEFT(ModeloCor, 1) BETWEEN 'a' AND 'z'),
                7,
                6)) AS Modelo,
	any_value(Col) as Colecao,
    sum(EstoqueEmMaos) as EstoqueEmMaos,
    sum(EstoqueEmTransito) as EstoqueEmTransito,
    sum(if(EstoqueEmMaos>0,1,0)) as NumSKUsDisp,
    sum(if(EstoqueEmMaos is not null,1,0)) as NumSKUs,
    sum(if((Tamanho between '34' and '38') AND EstoqueEmMaos>0,1,0)) as NumSKUsDispCent,
    sum(if((Tamanho between '34' and '38') AND EstoqueEmMaos is not null,1,0)) as NumSKUsCent
from eval30x360
Group by LocalC, ModeloCor
Having 
	(EstoqueEmMaos+EstoqueEmTransito) > 0 AND Colecao <> 'Geral'
) TB
Left Join modelostipos M USING(Modelo)
) WR
Group by LocalC, TipoNovo
) Resumo USING (LocalC, TipoNovo)
    
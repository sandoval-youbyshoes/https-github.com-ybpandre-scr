DROP PROCEDURE IF EXISTS youhist.RefrescaRankColsTipos;
CREATE PROCEDURE youhist.`RefrescaRankColsTipos`()
BEGIN
   /*
   Avaliacao Top Vendedores por Colecao-Tiponovo
   A ser chamada depois de atualizar a Movimentos
   */

   DROP TABLE IF EXISTS RankColsTipos;

   CREATE TABLE RankColsTipos
   (
      MCRank       INT,
      Colecao      VARCHAR(20),
      TipoNovo     VARCHAR(30),
      ModeloCor    VARCHAR(20),
      VdasUn       INT,
      VendasFin    DECIMAL(10, 2)
   )
   AS
       SELECT MCRank,
             Colecao,
             TipoNovo,
             ModeloCor,
             VdasUn,
             VendasFin
        FROM (                                                      -- Wrapper
              SELECT @mcrank :=
                        if(
                              (@TipoNovo = TipoNovo AND @Colecao = Colecao)
                           OR (TipoNovo IS NULL),
                           @mcrank + 1,
                           1) AS MCRank,
                     @Tiponovo := TipoNovo AS XTipoNovo,
                     @Colecao := Colecao AS XColecao,
                     Ranked.*
                FROM (                          SELECT Colecao,
                               ModeloCor,
                               TipoNovo,
                               sum(Unidades_vendidas_Liquido) AS VdasUn,
                               sum(valor_total_vendas_liquido) AS VendasFin,
                               Count(DISTINCT Modelocor) AS NumMCs
                          FROM (  
                            SELECT Movs.*,
									Substr(movs.sku,1,14) as modelocor,
                                       ifnull(ModTipo.TipoNovo, 'NA')
                                          AS TipoNovo,
                                       new_eval.CustoUni
                                          AS CustoUnitario,
                                       new_eval.PrecoOriginal
                                          AS PrecoOriginal,
                                       new_eval.Colecao
                                          AS Colecao
                                  FROM o_vendas Movs
                                       LEFT JOIN ModelosTipos ModTipo
                                          on (ModTipo.Modelo = substr(movs.sku,1,6))
                                       LEFT JOIN new_eval on (new_eval.ModeloCor = substr(movs.sku,1,14))
                                       where new_eval.`Colecao`<> 'GERAL' group by 1,2,3,4,5,6,7,8,9,10,11) tb
                                       GROUP BY Colecao, ModeloCor, TipoNovo ORDER BY Colecao, TipoNovo, VdasUn DESC) Ranked ) wrapper
   ;

   ALTER TABLE `YouHist`.`RankColsTipos`
      ADD UNIQUE INDEX
             `idx_RankColsTipos_MC` USING BTREE
             (`ModeloCor` (20) ASC);
   ALTER TABLE `YouHist`.`RankColsTipos`
      ADD INDEX `idx_RankColsTipos_Tipo` USING BTREE (`TipoNovo` (30) ASC);
   ALTER TABLE `YouHist`.`RankColsTipos`
      ADD INDEX `idx_RankColsTipos_Col` USING BTREE (`Colecao` (20) ASC);
   ALTER TABLE `YouHist`.`RankColsTipos`
      ADD INDEX `idx_RankColsTipos_Rank` USING BTREE (`MCRank` ASC);


   INSERT INTO TableUpdates(`NomeTabela`, `LUpdate`, `User`)
        VALUES ('RankColsTipos', now(), CURRENT_USER())
   ON DUPLICATE KEY UPDATE LUpdate = now(), User = CURRENT_USER();
END;

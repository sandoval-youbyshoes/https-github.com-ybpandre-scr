DROP PROCEDURE IF EXISTS youhist.AtualizaMovimentos;
CREATE PROCEDURE youhist.`AtualizaMovimentos`()
BEGIN
   -- Limpa os dados da tabela, somente os dados do odoo ap?s a abertura do caixa em todas as lojas
   DELETE FROM Movimentos
         WHERE tipo = 'V Adq Terc p Consumo' AND data BETWEEN CURDATE() - INTERVAL 15 DAY AND CURDATE();

   #mapeia e insere precos do Odoo para a tabela:
   INSERT INTO `YouHist`.`Movimentos`(`Tipo`,
                                      `Local`,
                                      `SKU`,
                                      `Data`,
                                      `Hora`,
                                      `Quantidade`,
                                      `Valor`,
                                      `TotalE`,
                                      `Ticket`,
                                      `CPFouCNPJ`)
      SELECT 'V Adq Terc p Consumo' AS Tipo,
             LC.LocalM AS Local,
             MV.sku AS SKU,
             date_format(date, "%Y-%m-%d") AS Data,
             date_format(date, "%T") AS Hora,
             IF(origin_company_id = 0, -1, 1) * product_qty AS Quantidade,
               IF(origin_company_id = 0, -1, 1)
             * IF(price_unit IS NULL OR price_unit = 0,
                  price_subtotal / product_qty,
                  price_unit) AS Valor,
             abs(price_subtotal) AS TotalE,
             operation AS Ticket,
             client AS CPForCNPJ
        FROM YouHist.o_moves MV
             LEFT JOIN locais LC
                ON (IF(
                       destination_company_id = 0,
                       origin_company_id,
                       IF(origin_company_id = 0,
                          destination_company_id,
                          NULL)) =
                    LC.company_id)
       WHERE
			 LC.LocalM IS NOT NULL
             AND fiscal_category LIKE "%Revenda"
             AND MV.date BETWEEN CURDATE() - INTERVAL 15 DAY AND CURDATE();

   /* o abaixo e' para garantir uma entrada pelo menos com a data de seunda para a comparacao semanal funcionar */
   INSERT INTO `YouHist`.`MovimentosUnion`(`Tipo`,
                                           `Local`,
                                           `SKU`,
                                           `Data`,
                                           `Hora`,
                                           `Quantidade`,
                                           `Valor`,
                                           `TotalE`,
                                           `Ticket`,
                                           `CPFouCNPJ`)
        VALUES ('V Adq Terc p Consumo',
               'ES 07 Center Norte',
               '00000000000000-00',
               DATE_FORMAT(NOW(), '%x-%m-%d'),
               '00:00:00',
               0,
               0.0,
               0.0,
               '',
               '000.000.000-00'),
               ('V Adq Terc p Consumo',
               'ES 03 SP Market',
               '00000000000000-00',
               DATE_FORMAT(NOW(), '%x-%m-%d'),
               '00:00:00',
               0,
               0.0,
               0.0,
               '',
               '000.000.000-00'),
               ('V Adq Terc p Consumo',
               'ES 05 Ibirapuera',
               '00000000000000-00',
               DATE_FORMAT(NOW(), '%x-%m-%d'),
               '00:00:00',
               0,
               0.0,
               0.0,
               '',
               '000.000.000-00'),
               ('V Adq Terc p Consumo',
               'ES 06 ABC',
               '00000000000000-00',
               DATE_FORMAT(NOW(), '%x-%m-%d'),
               '00:00:00',
               0,
               0.0,
               0.0,
               '',
               '000.000.000-00'),
               ('V Adq Terc p Consumo',
               'ES 04 Tatuape',
               '00000000000000-00',
               DATE_FORMAT(NOW(), '%x-%m-%d'),
               '00:00:00',
               0,
               0.0,
               0.0,
               '',
               '000.000.000-00');

   # atualiza data e usuario que atualizou esta tabela
   INSERT INTO TableUpdates(`NomeTabela`, `LUpdate`, `User`)
        VALUES ('Movimentos', now(), concat(CURRENT_USER(), "-DadosOdoo"))
   ON DUPLICATE KEY UPDATE LUpdate = now(), User = CURRENT_USER();

   CALL `YouHist`.`RefrescaRankColsTipos`();
END;

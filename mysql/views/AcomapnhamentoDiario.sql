ALTER ALGORITHM = UNDEFINED DEFINER = `TI` @`%` SQL SECURITY DEFINER VIEW `youhist`.`acompanhamentodiario`
AS
   SELECT `vendas`.`Local`
             AS `local`,
          `vendas`.`Data`
             AS `data`,
          min(`vendas`.`Mês`)
             AS `mes`,
          week(`vendas`.`Data`, 3)
             AS `Semana`,
          min(`vendas`.`Hora`)
             AS `MinHoraVd`,
          max(`vendas`.`Hora`)
             AS `MaxHoraVd`,
          count(DISTINCT `vendas`.`Pedido`)
             AS `NumTickets`,
          sum(`vendas`.`Quantidade`)
             AS `qtdLiq`,
          sum(if((`vendas`.`Quantidade` > 0), `vendas`.`Quantidade`, 0))
             AS `qtdBruta`,
          round(
             (  (  1
                 - (  sum(`vendas`.`Quantidade`)
                    / sum(
                         if((`vendas`.`Quantidade` > 0),
                            `vendas`.`Quantidade`,
                            0))))
              * 100),
             0)
             AS `PercTrDev`,
          round(
             if(
                (count(DISTINCT `vendas`.`Pedido`) > 0),
                (  sum(`vendas`.`Quantidade`)
                 / count(DISTINCT `vendas`.`Pedido`)),
                0),
             1)
             AS `ParesPorTicket`,
          sum(`vendas`.`Valor`)
             AS `valorLiq`,
          round(
             if((count(DISTINCT `vendas`.`Pedido`) > 0),
                (sum(`vendas`.`Valor`) / count(DISTINCT `vendas`.`Pedido`)),
                0),
             2)
             AS `TicketMedio`,
          round(sum(`vendas`.`Margem`), 2)
             AS `margem`,
          count(DISTINCT `vendas`.`Recurso`)
             AS `NumSKUs`,
          count(DISTINCT substring_index(`vendas`.`Recurso`, '-', 1))
             AS `NumMCs`,
          min(`ent`.`entrantes`)
             AS `entrantes`,
          min(`pass`.`passantes`)
             AS `passantes`,
          (count(DISTINCT `pass`.`passantes`) / min(`ent`.`entrantes`))
             AS `Atracao`,
          (count(DISTINCT `vendas`.`Pedido`) / min(`ent`.`entrantes`))
             AS `Conversao`
   FROM ((`youhist`.`vendas`
          LEFT JOIN
          (SELECT `youhist`.`entrantes_passantes`.`local`
                     AS `local`,
                  date_format(
                     `youhist`.`entrantes_passantes`.`interval_start`,
                     '%Y-%m-%d')
                     AS `data`,
                  sum(`youhist`.`entrantes_passantes`.`in`)
                     AS `entrantes`
           FROM `youhist`.`entrantes_passantes`
           WHERE (`youhist`.`entrantes_passantes`.`camera` = 'entrantes' and date_format(`youhist`.`entrantes_passantes`.`interval_start`,'%H:%i:%s') BETWEEN '10:00:00' and '21:00:00')
           GROUP BY `youhist`.`entrantes_passantes`.`local`,
                    date_format(
                       `youhist`.`entrantes_passantes`.`interval_start`,
                       '%Y-%m-%d')) `ent`
             ON ((    (`ent`.`local` = `vendas`.`Local`)
                  AND (convert(`ent`.`data` USING utf8) = `vendas`.`Data`))))
         LEFT JOIN
         (SELECT `youhist`.`entrantes_passantes`.`local`
                    AS `local`,
                 date_format(
                    `youhist`.`entrantes_passantes`.`interval_start`,
                    '%Y-%m-%d')
                    AS `data`,
                 sum(`youhist`.`entrantes_passantes`.`in`)
                    AS `passantes`
          FROM `youhist`.`entrantes_passantes`
          WHERE (`youhist`.`entrantes_passantes`.`camera` = 'passantes' and date_format(`youhist`.`entrantes_passantes`.`interval_start`,'%H:%i:%s') BETWEEN '10:00:00' and '21:00:00')
          GROUP BY `youhist`.`entrantes_passantes`.`local`,
                   date_format(
                      `youhist`.`entrantes_passantes`.`interval_start`,
                      '%Y-%m-%d')) `pass`
            ON ((    (`pass`.`local` = `vendas`.`Local`)
                 AND (convert(`pass`.`data` USING utf8) = `vendas`.`Data`))))
   WHERE (    (`vendas`.`Local` <> 'ES 01 CD')
          AND (NOT ((`vendas`.`Pedido` LIKE '%W0005OUT%03%'))))
   GROUP BY `vendas`.`Local`, `vendas`.`Data`;
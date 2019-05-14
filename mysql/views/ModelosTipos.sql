ALTER ALGORITHM = UNDEFINED DEFINER = `TI` @`%` SQL SECURITY DEFINER VIEW `modelostipos` AS
select
  `t`.`Modelo` AS `Modelo`,
  if(
    (`t`.`Tipo` = 'Tênis'),
    'Tênis',
    left(`t`.`Tipo`,(length(`t`.`Tipo`) - 1))
  ) AS `Tipo`,
  `t`.`SubTipo` AS `Subtipo`,
  `t`.`SubSubtipo` AS `SubSubtipo`,
  `t`.`TipoNome` AS `TipoNome`,
  `t`.`Salto` AS `Salto`,
  `t`.`TamSalto` AS `TamSalto`,
  `j`.`NumMCs` AS `NumMCs`,
  if(
    (`j`.`NumMCs` > 10),
    if(
      (`t`.`Tipo` = 'Tênis'),
      if(
        (left(`t`.`SubTipo`, length('Tênis')) = 'Tênis'),
        `t`.`SubTipo`,
        concat('Tênis ', `t`.`SubTipo`)
      ),
      if(
        (
          left(
            `t`.`SubTipo`,
            length(left(`t`.`Tipo`,(length(`t`.`Tipo`) - 1)))
          ) = left(`t`.`Tipo`,(length(`t`.`Tipo`) - 1))
        ),
        `t`.`SubTipo`,
        concat(
          left(`t`.`Tipo`,(length(`t`.`Tipo`) - 1)),
          ' ',
          `t`.`SubTipo`
        )
      )
    ),
    if(
      (`t`.`Tipo` = 'Tênis'),
      'Tênis Outros',
      concat(
        left(`t`.`Tipo`,(length(`t`.`Tipo`) - 1)),
        ' Outros'
      )
    )
  ) AS `TipoNovo`
from
  (
    `youhist`.`listamcsubtipos` `t`
    left join (
      select
        `stnmc`.`Tipo` AS `Tipo`,
        `stnmc`.`Subtipo` AS `SubTipo`,
        sum(`stnmc`.`NumMCs`) AS `NumMCs`
      from
        (
          select
            `lmc`.`Modelo` AS `Modelo`,
            `lmc`.`Tipo` AS `Tipo`,
            `lmc`.`SubTipo` AS `Subtipo`,
            `lmc`.`SubSubtipo` AS `SubSubtipo`,
            `lmc`.`TamSalto` AS `TamSalto`,
            `lmc`.`Salto` AS `Salto`,
            `lmc`.`TipoNome` AS `TipoNome`,
            `nm`.`NumMCs` AS `NumMCs`
          from
            (
              `youhist`.`listamcsubtipos` `lmc`
              join (
                select
                  if(
                    (left(`youhist`.`new_eval`.`ModeloCor`, 1) = 'F'),
                    left(`youhist`.`new_eval`.`ModeloCor`, 7),
                    left(`youhist`.`new_eval`.`ModeloCor`, 6)
                  ) AS `Modelo`,
                  count(distinct `youhist`.`new_eval`.`ModeloCor`) AS `NumMCs`
                from
                  `youhist`.`new_eval`
                where
                  (
                    (`youhist`.`new_eval`.`ModeloCor` is not null)
                    and (
                      (
                        greatest(`youhist`.`new_eval`.`EEM`, 0) + greatest(`youhist`.`new_eval`.`EET`, 0)
                      ) > 0
                    )
                  )
                group by
                  if(
                    (left(`youhist`.`new_eval`.`ModeloCor`, 1) = 'F'),
                    left(`youhist`.`new_eval`.`ModeloCor`, 7),
                    left(`youhist`.`new_eval`.`ModeloCor`, 6)
                  )
              ) `nm` on((`nm`.`Modelo` = `lmc`.`Modelo`))
            )
        ) `stnmc`
      group by
        `stnmc`.`Tipo`,
        `stnmc`.`Subtipo`
    ) `j` on(
      (
        (`t`.`Tipo` = `j`.`Tipo`)
        and (`t`.`SubTipo` = `j`.`SubTipo`)
      )
    )
  );
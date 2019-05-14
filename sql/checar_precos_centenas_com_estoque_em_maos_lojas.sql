SELECT
  *,
  (PRECO - MOD(Preco,100) - 0.1) as novo
FROM
  (
  SELECT
    DISTINCT LOCALC,
    modelocor,
    SUM(EEM) as EEM,
    MAX(PRecoCorrente) as Preco
  FROM
    new_eval
  WHERE
    (PrecoCorrente / 10) > MOD(PREcocorrente, 100)
  GROUP BY
    1,2
  ) base
WHERE
  EEM > 0
ORDER BY
  modelocor
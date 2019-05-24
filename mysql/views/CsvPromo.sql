ALTER ALGORITHM = UNDEFINED DEFINER = `TI` @`%` SQL SECURITY DEFINER VIEW `youhist`.`csvpromo` AS
SELECT
  `pr`.`Local` AS `LOCAL`,
  concat('ybp_product.', `pr`.`mc`) AS `items_id/product_tmpl_id/id`,
  ifnull(
    concat(
      '__export__.product_pricelist_version_',
      `pi`.`version`
    ),
    ''
  ) AS `id`,
  '2' AS `items_id/base`,
  '-1' AS `items_id/price_discount`,
  `pi`.`item_Id` AS `Price List Items/ID Banco de Dados`,
  substr(`pr`.`Local`, 3, 3) AS `name`,
  `pr`.`pfinal` AS `items_id/price_surcharge`,
  `pi`.`pricelist` AS `Price List/ID Banco de Dados`,
  REPLACE(
    concat(`pr`.`mc`, ': ', `pr`.`tipo`),
    CHAR(13, 10),
    ''
  ) AS `items_id/name`
FROM
  (
    (
      `youhist`.`gerapromo` `pr`
      JOIN `youhist`.`locais` `l` ON ((`pr`.`Local` = `l`.`LocalC`))
    )
    LEFT JOIN `youhist`.`plist` `pi` ON (
      (
        (`pi`.`company` = `l`.`company_id`)
        AND (`pr`.`mc` = substr(`pi`.`name`, 1, 14))
      )
    )
  );
ALTER ALGORITHM = UNDEFINED DEFINER = `TI` @`%` SQL SECURITY DEFINER VIEW `csvpromo` AS
select
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
  concat(`pr`.`mc`, ': ', `pr`.`tipo`) AS `items_id/name`,
  substr(`pr`.`Local`, 3, 3) AS `name`,
  `pr`.`pfinal` AS `items_id/price_surcharge`,
  `pi`.`pricelist` AS `Price List/ID Banco de Dados`
from
  (
    (
      `gerapromo` `pr`
      join `locais` `l` on((`pr`.`Local` = `l`.`LocalC`))
    )
    left join `plist` `pi` on(
      (
        (`pi`.`company` = `l`.`company_id`)
        and (
          convert(`pr`.`mc` using utf8) = substr(`pi`.`name`, 1, 14)
        )
      )
    )
  );
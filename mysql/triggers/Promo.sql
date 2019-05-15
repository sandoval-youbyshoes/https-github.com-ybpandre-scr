BEGIN
   SET new.porig =
          (SELECT n.PrecoOriginal
             FROM new_eval n
            WHERE new.mc = n.modelocor
            LIMIT 1);
   SET new.nome =
          (SELECT p.name
             FROM o_products p
            WHERE SUBSTR(p.sku, 1, 14) = new.mc
            LIMIT 1);
   SET new.tipo = TRIM(TRAILING '
' FROM new.tipo);
   SET new.tipo = TRIM(TRAILING '
' FROM new.tipo);
   SET new.tipo = TRIM(TRAILING '
' FROM new.tipo);
   SET new.tipo = TRIM(TRAILING ' ' FROM new.tipo);

   IF (new.desconto IS NULL OR new.desconto = '' OR new.desconto < 1)
   THEN
      SET new.desconto = ROUND((1 -(new.pfinal / new.porig)) * 100, 0);
      SET new.pfinal = REPLACE(new.pfinal, ',', '.');
   ELSE
  SET new.pfinal = IF(new.porig * (1 - (new.desconto /100)) % 10 >= 9,TRUNCATE(new.porig * (1 - (new.desconto /100)),0) + 0.9,new.porig * (1 - (new.desconto /100)) - MOD(new.porig * (1 - (new.desconto /100)),10) - 0.1);
   END IF;

   IF (new.pfinal % 100 < new.pfinal / 10)
   THEN
      SET new.pfinal = new.pfinal - (new.pfinal % 100) - 0.1;
   END IF;
END
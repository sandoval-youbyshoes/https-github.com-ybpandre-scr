BEGIN
   IF (NEW.collection = 'OI19')
   THEN
      SET NEW.markup = 2.862;
   ELSE
      SET NEW.markup = 2.332;
   END IF;

   IF (MOD(NEW.markup * NEW.cost_price, 10) >= 5)
   THEN
      SET NEW.PrOrig =
             ROUND(
                  (NEW.markup * NEW.cost_price)
                - MOD(NEW.markup * NEW.cost_price, 10)
                + 10
                - 0.1,
                2);
   ELSE
      SET NEW.PrOrig =
             ROUND(
                  (NEW.markup * NEW.cost_price)
                - MOD(NEW.markup * NEW.cost_price, 10)
                - 0.1,
                2);
   END IF;
   SET new.mc = substr(new.sku,1,14);
END
DROP PROCEDURE IF EXISTS youhist.o_filldates;
CREATE PROCEDURE youhist.`o_filldates`(dateStart DATE, dateEnd DATE)
BEGIN
  WHILE dateStart <= dateEnd DO
    INSERT INTO o_dias (dia, calculated) VALUES (dateStart, false)
	ON DUPLICATE KEY UPDATE dia=dia;
    SET dateStart = date_add(dateStart, INTERVAL 1 DAY);
  END WHILE;
END;

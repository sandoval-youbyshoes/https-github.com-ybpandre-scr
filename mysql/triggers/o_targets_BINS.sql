BEGIN
IF NEW.company_id = 10 THEN
SET NEW.company_id = 7;
SET NEW.company_code = '0005';
END IF;

IF NEW.company_id = 11 THEN
SET NEW.company_id = 9;
SET NEW.company_code = '0007';
END IF;
END
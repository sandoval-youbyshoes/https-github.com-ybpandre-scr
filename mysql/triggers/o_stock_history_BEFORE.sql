BEGIN
	IF NEW.company_id = 10 THEN
		SET NEW.company_id = 7;
	END IF;
-- 	
	IF NEW.company_id = 11 THEN
		SET NEW.company_id = 9;
	END IF;
-- 
	IF NEW.location_id = 116 THEN
		SET NEW.location_id = 54;
	END IF;
-- 
	IF NEW.location_id = 129 THEN
		SET NEW.location_id = 68;
	END IF;
-- 
	IF NEW.location_id = 115 THEN
		SET NEW.location_id = 53;
	END IF;
-- 
	IF NEW.location_id = 128 THEN
		SET NEW.location_id = 67;
	END IF;
END
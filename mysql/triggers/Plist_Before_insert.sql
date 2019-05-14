BEGIN
	IF NEW.company = 10 THEN
		SET NEW.company = 7;
	END IF;
    
	IF NEW.company = 11 THEN
		SET NEW.company = 9;
	END IF;
END
BEGIN
--
-- IF NEW.destination_company_id = 10 AND NEW.origin_company_id = 0 AND NEW.destination_location_id = 115 AND NEW.origin_location_id = 8 AND NEW.fiscal_category = 'Recebimento de Transferência entre filiais' THEN
-- SET NEW.origin_company_id = 10, NEW.origin_location_id = 116;
-- END IF;
--
-- IF NEW.destination_company_id = 0 AND NEW.origin_company_id = 10 AND NEW.destination_location_id = 9 AND NEW.origin_location_id = 115 AND NEW.fiscal_category = 'Envio de Transferência entre filiais' THEN
-- SET NEW.destination_company_id = 10, NEW.destination_location_id = 116;
-- END IF;
-- LOCATION NAME
	IF NEW.destination_location_id IN (116, 129) THEN
		SET NEW.destination_location_name = 'Entrada';
	END IF;
	--
	IF NEW.origin_location_id IN (116, 129) THEN
		SET NEW.origin_location_name = 'Entrada';
	END IF;

	-- COMPANY CODE
	-- IBR
	IF NEW.origin_company_id = 10 THEN
		SET NEW.origin_company_code = '0008';
	END IF;

	IF NEW.destination_company_id = 10 THEN
		SET NEW.destination_company_code = '0008';
	END IF;

	-- CNT
	IF NEW.origin_company_id = 11 THEN
		SET NEW.origin_company_code = '0009';
	END IF;

	IF NEW.destination_company_id = 11 THEN
		SET NEW.destination_company_code = '0009';
	END IF;


	-- Troca Moves de entrada da loja 08 para 05
	IF NEW.origin_company_id = 10 THEN
		SET NEW.origin_company_id = 7, NEW.origin_company_code = '0005';
	END IF;

	-- Troca Moves de entrada da loja 09 para 07
	IF NEW.origin_company_id = 11 THEN
		SET NEW.origin_company_id = 9, NEW.origin_company_code = '0007';
	END IF;

	-- Troca Moves de Saida da loja 08 para loja 05
	IF NEW.destination_company_id = 10 THEN
		SET NEW.destination_company_id = 7, NEW.destination_company_code = '0005';
	END IF;

	-- Troca Moves de Saida da loja 09 para loja 07
	IF NEW.destination_company_id = 11 THEN
		SET NEW.destination_company_id = 9, NEW.destination_company_code = '0007';
	END IF;

	-- LOCATION ENTRADA
	-- IBR
	IF NEW.origin_location_id = 116 THEN
		SET NEW.origin_location_id = 54;
	END IF;
	--
	IF NEW.destination_location_id = 116 THEN
		SET NEW.destination_location_id = 54;
	END IF;

	-- CNT
	IF NEW.origin_location_id = 129 THEN
		SET NEW.origin_location_id = 68;
	END IF;
	--
	IF NEW.destination_location_id = 129 THEN
		SET NEW.destination_location_id = 68;
	END IF;

	-- LOCATION ESTOQUE
	-- IBR
	IF NEW.origin_location_id = 115 THEN
		SET NEW.origin_location_id = 53;
	END IF;
	--
	IF NEW.destination_location_id = 115 THEN
		SET NEW.destination_location_id = 53;
	END IF;

	-- CNT
	IF NEW.origin_location_id = 128 THEN
		SET NEW.origin_location_id = 67;
	END IF;
	--
	IF NEW.destination_location_id = 128 THEN
		SET NEW.destination_location_id = 67;
	END IF;

	--
	IF NEW.origin_company_id = 7 AND NEW.origin_location_id = 53 AND NEW.destination_company_id = 0 AND NEW.destination_location_id = 9 AND NEW.fiscal_category = 'Revenda' AND NEW.operation like '%OUT%' THEN
	   SET NEW.fiscal_category = 'Envio de Transferência entre filiais';
	END IF;
END
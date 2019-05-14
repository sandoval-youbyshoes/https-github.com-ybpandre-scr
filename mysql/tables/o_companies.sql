CREATE TABLE `o_companies` (
  `company_id` int(11) NOT NULL,
  `code` text,
  `name` text,
  `phone` text,
  `country` text,
  `state` text,
  `city` text,
  `district` text,
  `street` text,
  `street2` text,
  `number` text,
  `zip` text,
  `cnpj_cpf` text,
  PRIMARY KEY (`company_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

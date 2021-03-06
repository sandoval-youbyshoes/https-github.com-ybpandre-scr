CREATE TABLE `o_clients` (
  `id` int(11) DEFAULT NULL,
  `cliente` varchar(100) DEFAULT NULL,
  `legal_name` varchar(100) DEFAULT NULL,
  `data_criacao` varchar(50) DEFAULT NULL,
  `usuario_criacao` varchar(100) DEFAULT NULL,
  `data_alteracao` varchar(50) DEFAULT NULL,
  `usuario_alteracao` varchar(100) DEFAULT NULL,
  `endereco_1` varchar(100) DEFAULT NULL,
  `endereco_2` varchar(50) DEFAULT NULL,
  `numero` varchar(10) DEFAULT NULL,
  `bairro` varchar(50) DEFAULT NULL,
  `cidade` varchar(50) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `cep` varchar(20) DEFAULT NULL,
  `pais` varchar(30) DEFAULT NULL,
  `cnpj_cpf` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `celular` varchar(20) DEFAULT NULL,
  `data_nascimento` varchar(20) DEFAULT NULL,
  `genero` varchar(1) DEFAULT NULL,
  `mensagem` varchar(1) DEFAULT NULL,
  `whatsapp` varchar(1) DEFAULT NULL,
  `atualizado` varchar(1) GENERATED ALWAYS AS (if(((`cliente` <> '') and (`endereco_1` <> '') and (`numero` <> '') and (`cep` <> '') and ((`cnpj_cpf` <> '') or (`cnpj_cpf` <> '000.000.000-00')) and (`email` <> '') and (`telefone` <> '') and (`data_nascimento` <> '') and (`genero` <> '') and (`mensagem` <> '') and (`whatsapp` <> '')),1,0)) VIRTUAL,
  PRIMARY KEY (`cnpj_cpf`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

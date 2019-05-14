ALTER ALGORITHM = UNDEFINED DEFINER = `TI` @`%` SQL SECURITY DEFINER VIEW `vendas_clientes` AS
select
  `cli`.`cliente` AS `cliente`,
  `ven`.`CPFouCNPJ` AS `CPFouCNPJ`,
  `cli`.`data_criacao` AS `data_criacao`,
  `cli`.`usuario_criacao` AS `usuario_criacao`,
  `cli`.`data_alteracao` AS `data_alteracao`,
  `cli`.`usuario_alteracao` AS `usuario_alteracao`,
  `cli`.`endereco_1` AS `endereco_1`,
  `cli`.`endereco_2` AS `endereco_2`,
  `cli`.`numero` AS `numero`,
  `cli`.`bairro` AS `bairro`,
  `cli`.`cidade` AS `cidade`,
  `cli`.`estado` AS `estado`,
  `cli`.`cep` AS `cep`,
  `cli`.`pais` AS `pais`,
  `cli`.`email` AS `email`,
  `cli`.`telefone` AS `telefone`,
  `cli`.`celular` AS `celular`,
  `cli`.`data_nascimento` AS `data_nascimento`,
  `cli`.`genero` AS `genero`,
  `cli`.`mensagem` AS `mensagem`,
  `cli`.`whatsapp` AS `whatsapp`,
  `cli`.`atualizado` AS `atualizado`,
  `ven`.`local` AS `local`,
  `ven`.`Tot` AS `Tot`,
  `ven`.`Pares` AS `Pares`,
  `ven`.`linhas` AS `linhas`,
  `ven`.`MinDataHora` AS `MinDataHora`,
  `ven`.`MaxDataHora` AS `MaxDataHora`,
  `ven`.`MinDia` AS `MinDia`,
  `ven`.`MaxDia` AS `MaxDia`,
  `ven`.`Dias_ativo` AS `Dias_ativo`,
  `ven`.`Tickets_un` AS `Tickets_un`,
  `ven`.`MC_un` AS `MC_un`,
  `ven`.`SKU_un` AS `SKU_un`
from
  (
    `resumocpfvendas` `ven`
    join `o_clients` `cli` on(
      (
        convert(`cli`.`cnpj_cpf` using utf8) = `ven`.`CPFouCNPJ`
      )
    )
  );
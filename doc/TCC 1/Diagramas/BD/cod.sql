drop database `tcc`;
create database `tcc`;
use `tcc`;


-- -----------------------------------------------------
-- Table `TCC`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TCC`.`tb_usuario` (
  `id_user` INT NOT NULL,
  `nm_nome` VARCHAR(45) NULL,
  `ds_email` VARCHAR(45) NULL,
  `nu_cpf` VARCHAR(45) NULL,
  `dt_nascimento` DATE NULL,
  `id_user_firebase` VARCHAR(45) NULL,
  PRIMARY KEY (`id_user`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `TCC`.`tb_estabelecimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TCC`.`tb_estabelecimento` (
  `id_estabelecimento` INT NOT NULL,
  `nm_estabelecimento` VARCHAR(45) NULL,
  `ds_email_estabelcimento` VARCHAR(45) NULL,
  PRIMARY KEY (`id_estabelecimento`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `TCC`.`tb_loja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TCC`.`tb_loja` (
  `id_loja` INT NOT NULL,
  `nm_store` VARCHAR(45) NULL,
  `ds_rua` VARCHAR(45) NULL,
  `nu_store` VARCHAR(45) NULL,
  `nu_cep` VARCHAR(45) NULL,
  `ds_bairro` VARCHAR(45) NULL,
  `ds_municipio` VARCHAR(45) NULL,
  `ds_estado` VARCHAR(45) NULL,
  `ds_pais` VARCHAR(45) NULL,
  `fk_estabelicimento` INT NULL,
  `ds_logitude` DECIMAL(10,7) NULL,
  `ds_latitude` DECIMAL(10,7) NULL,
  PRIMARY KEY (`id_loja`),
  INDEX `fk_estabelecimento_idx` (`fk_estabelicimento` ASC) VISIBLE,
  CONSTRAINT `fk_estabelecimento`
    FOREIGN KEY (`fk_estabelicimento`)
    REFERENCES `TCC`.`tb_estabelecimento` (`id_estabelecimento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `TCC`.`tb_funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TCC`.`tb_funcionario` (
  `id_funcionario` INT NOT NULL,
  `nm_funcionario` VARCHAR(45) NULL,
  `fk_loja` INT NULL,
  PRIMARY KEY (`id_funcionario`),
  INDEX `fk_store_idx` (`fk_loja` ASC) VISIBLE,
  CONSTRAINT `fk_store`
    FOREIGN KEY (`fk_loja`)
    REFERENCES `TCC`.`tb_loja` (`id_loja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `TCC`.`tb_agendamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TCC`.`tb_agendamento` (
  `id_agendamento` INT NOT NULL AUTO_INCREMENT,
  `fk_usuario` INT NULL,
  `fk_loja` INT NULL,
  `dt_agendamento` DATE NULL,
  `tm_agendamento` TIME NULL,
  `fk_funcionario` INT NULL,
  `cd_status` VARCHAR(45) NULL,
  `dt_criacao` DATETIME NULL,
  PRIMARY KEY (`id_agendamento`),
  INDEX `fk_user_agendamento_idx` (`fk_usuario` ASC) VISIBLE,
  INDEX `fk_store_idx` (`fk_loja` ASC) VISIBLE,
  INDEX `fk_func_idx` (`fk_funcionario` ASC) VISIBLE,
  CONSTRAINT `fk_user_agendamento`
    FOREIGN KEY (`fk_usuario`)
    REFERENCES `TCC`.`tb_usuario` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_loja`
    FOREIGN KEY (`fk_loja`)
    REFERENCES `TCC`.`tb_loja` (`id_loja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_func`
    FOREIGN KEY (`fk_funcionario`)
    REFERENCES `TCC`.`tb_funcionario` (`id_funcionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `TCC`.`tb_servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TCC`.`tb_servico` (
  `id_servico` INT NOT NULL,
  `nm_servico` VARCHAR(45) NULL,
  `ds_servico` VARCHAR(45) NULL,
  `vl_servico` DECIMAL NULL,
  `tm_duracao` TIME NULL,
  `fk_store` INT NULL,
  PRIMARY KEY (`id_servico`),
  INDEX `fk_store_idx` (`fk_store` ASC) VISIBLE,
  CONSTRAINT `fk_store_servico`
    FOREIGN KEY (`fk_store`)
    REFERENCES `TCC`.`tb_loja` (`id_loja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TCC`.`tb_agendamento_servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TCC`.`tb_agendamento_servico` (
  `id_agendamento_servico` INT NOT NULL,
  `fk_agendamento` INT NULL,
  `fk_servico` INT NULL,
  PRIMARY KEY (`id_agendamento_servico`),
  INDEX `fk_servico_idx` (`fk_servico` ASC) VISIBLE,
  INDEX `fk_agendamento_idx` (`fk_agendamento` ASC) VISIBLE,
  CONSTRAINT `fk_servico`
    FOREIGN KEY (`fk_servico`)
    REFERENCES `TCC`.`tb_servico` (`id_servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_agendamento`
    FOREIGN KEY (`fk_agendamento`)
    REFERENCES `TCC`.`tb_agendamento` (`id_agendamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TCC`.`tb_pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TCC`.`tb_pagamento` (
  `id_pagamento` INT NOT NULL,
  `fk_agendamento` INT NULL,
  `vl_total` DECIMAL NULL,
  `tp_pagamento` VARCHAR(45) NULL,
  `cd_status_pagamento` VARCHAR(45) NULL,
  `ds_stripe_payment_intent_id` VARCHAR(45) NULL,
  `ds_stripe_status` VARCHAR(45) NULL,
  `dt_pagamento` VARCHAR(45) NULL,
  PRIMARY KEY (`id_pagamento`),
  INDEX `fk_agendamento_idx` (`fk_agendamento` ASC) VISIBLE,
  CONSTRAINT `fk_agendamento_pagamento`
    FOREIGN KEY (`fk_agendamento`)
    REFERENCES `TCC`.`tb_agendamento` (`id_agendamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
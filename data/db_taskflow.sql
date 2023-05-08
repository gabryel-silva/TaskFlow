-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_taskflow
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_taskflow
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_taskflow` DEFAULT CHARACTER SET utf8 ;
USE `db_taskflow` ;

-- -----------------------------------------------------
-- Table `db_taskflow`.`Perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_taskflow`.`Perfil` (
  `idperfil` INT NOT NULL,
  `Cargo` VARCHAR(100) NULL,
  `Descricao` VARCHAR(2000) NULL,
  `Foto` VARCHAR(200) NULL,
  PRIMARY KEY (`idperfil`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_taskflow`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_taskflow`.`Usuario` (
  `idUsuario` INT NOT NULL,
  `Nome` VARCHAR(100) NOT NULL,
  `Email` VARCHAR(50) NOT NULL,
  `Data_de_nascimento` DATE NOT NULL,
  `Telefone` INT(11) NOT NULL,
  `Senha` VARCHAR(16) NOT NULL,
  `perfil_idperfil` INT NOT NULL,
  PRIMARY KEY (`idUsuario`),
  -- INDEX `fk_Usuario_perfil_idx` (`perfil_idperfil` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_perfil`
    FOREIGN KEY (`perfil_idperfil`)
    REFERENCES `db_taskflow`.`Perfil` (`idperfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_taskflow`.`Tarefas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_taskflow`.`Tarefas` (
  `idTarefas` INT NOT NULL,
  `Titulo` VARCHAR(100) NOT NULL,
  `Descricao` VARCHAR(2000) NOT NULL,
  `Prazo_de_entrega` DATE NOT NULL,
  `Data_de_inicio` DATE NOT NULL,
  `Status_da_tarefa` CHAR(20) NOT NULL,
  `prioridade` CHAR(20) NOT NULL,
  PRIMARY KEY (`idTarefas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_taskflow`.`Tarefas_has_Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_taskflow`.`Tarefas_has_Usuario` (
  `Tarefas_idTarefas` INT NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`Tarefas_idTarefas`, `Usuario_idUsuario`),
  -- INDEX `fk_Tarefas_has_Usuario_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  -- INDEX `fk_Tarefas_has_Usuario_Tarefas1_idx` (`Tarefas_idTarefas` ASC) VISIBLE,
  CONSTRAINT `fk_Tarefas_has_Usuario_Tarefas1`
    FOREIGN KEY (`Tarefas_idTarefas`)
    REFERENCES `db_taskflow`.`Tarefas` (`idTarefas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tarefas_has_Usuario_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `db_taskflow`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_taskflow`.`Equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_taskflow`.`Equipe` (
  `idEquipe` INT NOT NULL,
  `Integrante` VARCHAR(100) NOT NULL,
  `Administrador` VARCHAR(100) NOT NULL,
  `Nome_da_equipe` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idEquipe`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_taskflow`.`Usuario_has_Equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_taskflow`.`Usuario_has_Equipe` (
  `Usuario_idUsuario` INT NOT NULL,
  `Equipe_idEquipe` INT NOT NULL,
  PRIMARY KEY (`Usuario_idUsuario`, `Equipe_idEquipe`),
  -- INDEX `fk_Usuario_has_Equipe_Equipe1_idx` (`Equipe_idEquipe` ASC) VISIBLE,
  -- INDEX `fk_Usuario_has_Equipe_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_has_Equipe_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `db_taskflow`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Equipe_Equipe1`
    FOREIGN KEY (`Equipe_idEquipe`)
    REFERENCES `db_taskflow`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_taskflow`.`Projeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_taskflow`.`Projeto` (
  `idProjeto` INT NOT NULL,
  `Nome_do_projeto` VARCHAR(100) NOT NULL,
  `Descricao` VARCHAR(2000) NOT NULL,
  `Prazo_de_entrega` DATE NOT NULL,
  `Data_de_inicio` DATE NOT NULL,
  `Status_do_projeto` CHAR(20) NOT NULL,
  PRIMARY KEY (`idProjeto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_taskflow`.`Equipe_has_Projeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_taskflow`.`Equipe_has_Projeto` (
  `Equipe_idEquipe` INT NOT NULL,
  `Projeto_idProjeto` INT NOT NULL,
  PRIMARY KEY (`Equipe_idEquipe`, `Projeto_idProjeto`),
  -- INDEX `fk_Equipe_has_Projeto_Projeto1_idx` (`Projeto_idProjeto` ASC) VISIBLE,
  -- INDEX `fk_Equipe_has_Projeto_Equipe1_idx` (`Equipe_idEquipe` ASC) VISIBLE,
  CONSTRAINT `fk_Equipe_has_Projeto_Equipe1`
    FOREIGN KEY (`Equipe_idEquipe`)
    REFERENCES `db_taskflow`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipe_has_Projeto_Projeto1`
    FOREIGN KEY (`Projeto_idProjeto`)
    REFERENCES `db_taskflow`.`Projeto` (`idProjeto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

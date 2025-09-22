-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`videos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`videos` ;

CREATE TABLE IF NOT EXISTS `mydb`.`videos` (
  `idVideos` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `titulo` VARCHAR(120) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `fecha_pub` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `duracion_s` INT NOT NULL,
  PRIMARY KEY (`idVideos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comentarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`comentarios` ;

CREATE TABLE IF NOT EXISTS `mydb`.`comentarios` (
  `idComentarios` INT NOT NULL AUTO_INCREMENT,
  `id_video` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `texto` TEXT NOT NULL,
  `fecha_coment` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idComentarios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`likes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`likes` ;

CREATE TABLE IF NOT EXISTS `mydb`.`likes` (
  `idLikes` INT NOT NULL AUTO_INCREMENT,
  `id_video` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `fecha_like` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idLikes`),
  UNIQUE INDEX `uq_likes_usuario_video` (`id_video` ASC, `id_usuario` ASC) INVISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`seguidores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`seguidores` ;

CREATE TABLE IF NOT EXISTS `mydb`.`seguidores` (
  `idSeguidores` INT NOT NULL AUTO_INCREMENT,
  `id_seguidor` INT NOT NULL,
  `id_seguido` INT NOT NULL,
  `fecha_inicio` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idSeguidores`),
  UNIQUE INDEX `index2` (`id_seguidor` ASC, `id_seguido` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`usuarios` ;

CREATE TABLE IF NOT EXISTS `mydb`.`usuarios` (
  `idUsuarios` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  `email` VARCHAR(120) NOT NULL,
  `fecha_registro` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `PAIS` VARCHAR(80) NOT NULL,
  `videos_id` INT NOT NULL,
  `comentarios_id` INT NOT NULL,
  `likes_id` INT NOT NULL,
  `seguidores_id` INT NOT NULL,
  PRIMARY KEY (`idUsuarios`, `likes_id`),
  UNIQUE INDEX `uq_usuarios_username` (`username` ASC) INVISIBLE,
  UNIQUE INDEX `uq_usuarios_email` (`email` ASC) VISIBLE,
  INDEX `fk_usuarios_videos_idx` (`videos_id` ASC) VISIBLE,
  INDEX `fk_usuarios_comentarios1_idx` (`comentarios_id` ASC) VISIBLE,
  INDEX `fk_usuarios_likes1_idx` (`likes_id` ASC) VISIBLE,
  INDEX `fk_usuarios_seguidores1_idx` (`seguidores_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_videos`
    FOREIGN KEY (`videos_id`)
    REFERENCES `mydb`.`videos` (`idVideos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_comentarios1`
    FOREIGN KEY (`comentarios_id`)
    REFERENCES `mydb`.`comentarios` (`idComentarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_likes1`
    FOREIGN KEY (`likes_id`)
    REFERENCES `mydb`.`likes` (`idLikes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_seguidores1`
    FOREIGN KEY (`seguidores_id`)
    REFERENCES `mydb`.`seguidores` (`idSeguidores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

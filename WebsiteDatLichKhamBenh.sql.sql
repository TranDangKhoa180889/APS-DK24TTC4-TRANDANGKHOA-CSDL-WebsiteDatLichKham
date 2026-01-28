-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema csdl_datlichkham
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `csdl_datlichkham` ;

-- -----------------------------------------------------
-- Schema csdl_datlichkham
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `csdl_datlichkham` DEFAULT CHARACTER SET utf8mb3 ;
USE `csdl_datlichkham` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `password` VARCHAR(255) NULL DEFAULT NULL,
  `firstName` VARCHAR(255) NULL DEFAULT NULL,
  `lastName` VARCHAR(255) NULL DEFAULT NULL,
  `address` VARCHAR(255) NULL DEFAULT NULL,
  `phonenumber` VARCHAR(255) NULL DEFAULT NULL,
  `gender` VARCHAR(50) NULL DEFAULT NULL,
  `image` LONGBLOB NULL DEFAULT NULL,
  `roleId` VARCHAR(50) NULL DEFAULT NULL,
  `positionId` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bookings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bookings` ;

CREATE TABLE IF NOT EXISTS `bookings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `statusId` INT NULL DEFAULT NULL,
  `doctorId` INT NOT NULL,
  `patientId` INT NOT NULL,
  `date` VARCHAR(255) NULL DEFAULT NULL,
  `timeType` VARCHAR(255) NULL DEFAULT NULL,
  `token` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_booking_doctor` (`doctorId` ASC) VISIBLE,
  INDEX `fk_booking_patient` (`patientId` ASC) VISIBLE,
  CONSTRAINT `fk_booking_doctor`
    FOREIGN KEY (`doctorId`)
    REFERENCES `user` (`id`),
  CONSTRAINT `fk_booking_patient`
    FOREIGN KEY (`patientId`)
    REFERENCES `user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `clinics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinics` ;

CREATE TABLE IF NOT EXISTS `clinics` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `address` VARCHAR(255) NULL DEFAULT NULL,
  `phone` VARCHAR(50) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `specialties`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `specialties` ;

CREATE TABLE IF NOT EXISTS `specialties` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `image` LONGBLOB NULL DEFAULT NULL,
  `descriptionHTML` TEXT NULL DEFAULT NULL,
  `descriptionMarkdown` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `doctor_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `doctor_info` ;

CREATE TABLE IF NOT EXISTS `doctor_info` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `doctorId` INT NOT NULL,
  `specialtyId` INT NOT NULL,
  `clinicId` INT NOT NULL,
  `price` VARCHAR(255) NULL DEFAULT NULL,
  `paymentId` VARCHAR(255) NULL DEFAULT NULL,
  `note` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_doctor_user` (`doctorId` ASC) VISIBLE,
  INDEX `fk_doctor_specialty` (`specialtyId` ASC) VISIBLE,
  INDEX `fk_doctor_clinic` (`clinicId` ASC) VISIBLE,
  CONSTRAINT `fk_doctor_clinic`
    FOREIGN KEY (`clinicId`)
    REFERENCES `clinics` (`id`),
  CONSTRAINT `fk_doctor_specialty`
    FOREIGN KEY (`specialtyId`)
    REFERENCES `specialties` (`id`),
  CONSTRAINT `fk_doctor_user`
    FOREIGN KEY (`doctorId`)
    REFERENCES `user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `patient_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patient_history` ;

CREATE TABLE IF NOT EXISTS `patient_history` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `patientId` INT NOT NULL,
  `doctorId` INT NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `drugs` TEXT NULL DEFAULT NULL,
  `files` LONGBLOB NULL DEFAULT NULL,
  `reason` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_history_patient` (`patientId` ASC) VISIBLE,
  INDEX `fk_history_doctor` (`doctorId` ASC) VISIBLE,
  CONSTRAINT `fk_history_doctor`
    FOREIGN KEY (`doctorId`)
    REFERENCES `user` (`id`),
  CONSTRAINT `fk_history_patient`
    FOREIGN KEY (`patientId`)
    REFERENCES `user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


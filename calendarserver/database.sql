-- MySQL Script generated by MySQL Workbench
-- Sat Aug 12 23:35:42 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema calendardb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema calendardb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `calendardb` DEFAULT CHARACTER SET utf8 ;
USE `calendardb` ;

-- -----------------------------------------------------
-- Table `calendardb`.`userCalendar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calendardb`.`userCalendar` (
  `calendarID` INT NOT NULL,
  `calendarDescription` VARCHAR(45) NULL,
  `calendarName` VARCHAR(45) NULL,
  PRIMARY KEY (`calendarID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `calendardb`.`userAccount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calendardb`.`userAccount` (
  `userID` INT NOT NULL,
  `userName` VARCHAR(45) NULL,
  `calendarID` INT NOT NULL,
  `userEmail` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`userID`, `calendarID`),
  INDEX `fk_userAccount_userCalendar_idx` (`calendarID` ASC),
  CONSTRAINT `fk_userAccount_userCalendar`
    FOREIGN KEY (`calendarID`)
    REFERENCES `calendardb`.`userCalendar` (`calendarID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `calendardb`.`eventTable`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calendardb`.`eventTable` (
  `eventID` INT NOT NULL,
  `eventName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`eventID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `calendardb`.`EventToUserMapping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calendardb`.`EventToUserMapping` (
  `eventTable_eventID` INT NOT NULL,
  `userAccount_userID` INT NOT NULL,
  `userAccount_calendarID` INT NOT NULL,
  PRIMARY KEY (`eventTable_eventID`, `userAccount_userID`, `userAccount_calendarID`),
  INDEX `fk_eventTable_has_userAccount_userAccount1_idx` (`userAccount_userID` ASC, `userAccount_calendarID` ASC),
  INDEX `fk_eventTable_has_userAccount_eventTable1_idx` (`eventTable_eventID` ASC),
  CONSTRAINT `fk_eventTable_has_userAccount_eventTable1`
    FOREIGN KEY (`eventTable_eventID`)
    REFERENCES `calendardb`.`eventTable` (`eventID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_eventTable_has_userAccount_userAccount1`
    FOREIGN KEY (`userAccount_userID` , `userAccount_calendarID`)
    REFERENCES `calendardb`.`userAccount` (`userID` , `calendarID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `calendardb`.`calendarToEventMapping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calendardb`.`calendarToEventMapping` (
  `userCalendar_calendarID` INT NOT NULL,
  `eventTable_eventID` INT NOT NULL,
  PRIMARY KEY (`userCalendar_calendarID`, `eventTable_eventID`),
  INDEX `fk_userCalendar_has_eventTable_eventTable1_idx` (`eventTable_eventID` ASC),
  INDEX `fk_userCalendar_has_eventTable_userCalendar1_idx` (`userCalendar_calendarID` ASC),
  CONSTRAINT `fk_userCalendar_has_eventTable_userCalendar1`
    FOREIGN KEY (`userCalendar_calendarID`)
    REFERENCES `calendardb`.`userCalendar` (`calendarID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_userCalendar_has_eventTable_eventTable1`
    FOREIGN KEY (`eventTable_eventID`)
    REFERENCES `calendardb`.`eventTable` (`eventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `calendardb`.`table1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calendardb`.`table1` (
)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
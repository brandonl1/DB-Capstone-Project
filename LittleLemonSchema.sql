-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema little_lemon_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema little_lemon_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `little_lemon_db` DEFAULT CHARACTER SET utf8 ;
USE `little_lemon_db` ;

-- -----------------------------------------------------
-- Table `little_lemon_db`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Customer` (
  `CustomerID` INT NOT NULL,
  `FullName` VARCHAR(255) NOT NULL,
  `ContactNumber` VARCHAR(10) NOT NULL,
  `Email` VARCHAR(225) NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Bookings` (
  `BookingID` INT NOT NULL,
  `BookingDate` DATETIME NOT NULL,
  `TableNumber` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `Customer_id_fk_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `Customer_id_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `little_lemon_db`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `little_lemon_db`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Menu` (
  `MenuID` INT NOT NULL,
  `MenuName` VARCHAR(255) NOT NULL,
  `Cuisine` VARCHAR(225) NOT NULL,
  `MenuItemsID` INT NOT NULL,
  PRIMARY KEY (`MenuID`),
  INDEX `fk_MenuItemsID_idx` (`MenuItemsID` ASC) VISIBLE,
  CONSTRAINT `fk_MenuItemsID`
    FOREIGN KEY (`MenuItemsID`)
    REFERENCES `little_lemon_db`.`MenuItems` (`MenuItemsID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `little_lemon_db`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`MenuItems` (
  `MenuItemsID` INT NOT NULL,
  `CourseName` VARCHAR(255) NOT NULL,
  `StarterName` VARCHAR(255) NOT NULL,
  `DesertName` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`MenuItemsID`))
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `little_lemon_db`.`Delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Delivery` (
  `DeliveryID` INT NOT NULL,
  `DeliveryDate` DATETIME NOT NULL,
  `DeliveryStatus` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DeliveryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Orders` (
  `OrderID` INT NOT NULL,
  `Date` DATETIME NOT NULL,
  `Quantity` INT NOT NULL,
  `TotalCost` DECIMAL(8,2) NOT NULL,
  `BookingID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `MenuID` INT NOT NULL,
  `DeliveryID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `FK_BookingID_idx` (`BookingID` ASC) VISIBLE,
  INDEX `fk_MenuID_idx` (`MenuID` ASC) VISIBLE,
  INDEX `fk_DeliveryID_idx` (`DeliveryID` ASC) VISIBLE,
  CONSTRAINT `fk_CustomerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `little_lemon_db`.`Customer` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_BookingID`
    FOREIGN KEY (`BookingID`)
    REFERENCES `little_lemon_db`.`Bookings` (`BookingID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_MenuID`
    FOREIGN KEY (`MenuID`)
    REFERENCES `little_lemon_db`.`Menu` (`MenuID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_DeliveryID`
    FOREIGN KEY (`DeliveryID`)
    REFERENCES `little_lemon_db`.`Delivery` (`DeliveryID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Staff` (
  `StaffID` INT NOT NULL,
  `FullName` VARCHAR(255) NOT NULL,
  `ContactNumber` VARCHAR(10) NOT NULL,
  `Email` VARCHAR(225) NOT NULL,
  `Role` VARCHAR(45) NOT NULL,
  `Salary` DECIMAL(8,2) NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`StaffID`),
  INDEX `fk_CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `CustomerID_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `little_lemon_db`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

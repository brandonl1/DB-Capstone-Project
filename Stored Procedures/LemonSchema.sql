-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema little_lemon_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema little_lemon_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `little_lemon_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `little_lemon_db` ;

-- -----------------------------------------------------
-- Table `little_lemon_db`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `TableNo` INT NULL DEFAULT NULL,
  `GuestFirstName` VARCHAR(100) NOT NULL,
  `GuestLastName` VARCHAR(100) NOT NULL,
  `BookingSlot` TIME NOT NULL,
  `EmployeeID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`BookingID`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Customer` (
  `CustomerID` INT NOT NULL,
  `FullName` VARCHAR(255) NOT NULL,
  `ContactNumber` VARCHAR(10) NOT NULL,
  `Email` VARCHAR(225) NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Employees` (
  `EmployeeID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NULL DEFAULT NULL,
  `Role` VARCHAR(100) NULL DEFAULT NULL,
  `Address` VARCHAR(255) NULL DEFAULT NULL,
  `Contact_Number` INT NULL DEFAULT NULL,
  `Email` VARCHAR(255) NULL DEFAULT NULL,
  `Annual_Salary` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`MenuItems` (
  `ItemID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(200) NULL DEFAULT NULL,
  `Type` VARCHAR(100) NULL DEFAULT NULL,
  `Price` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ItemID`))
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`Menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Menus` (
  `MenuID` INT NOT NULL,
  `ItemID` INT NOT NULL,
  `Cuisine` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`MenuID`, `ItemID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Orders` (
  `OrderID` INT NOT NULL,
  `TableNo` INT NOT NULL,
  `MenuID` INT NULL DEFAULT NULL,
  `BookingID` INT NULL DEFAULT NULL,
  `BillAmount` INT NULL DEFAULT NULL,
  `Quantity` INT NULL DEFAULT NULL,
  PRIMARY KEY (`OrderID`, `TableNo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `little_lemon_db` ;

-- -----------------------------------------------------
-- procedure AddBooking
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_db`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddBooking`()
BEGIN
    -- Modifying columns in Bookings table
    ALTER TABLE Bookings MODIFY COLUMN TableNumber INT;
    ALTER TABLE Bookings MODIFY COLUMN CustomerID INT;

    -- Inserting data into Bookings table
    INSERT INTO Bookings (BookingID, BookingDate, TableNumber, CustomerID) VALUES
    (10, '2022-10-10', 5, 1),
    (11, '2022-11-12', 3, 3),
    (12, '2022-10-11', 2, 2),
    (13, '2022-10-13', 2, 1);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure BasicSalesReport
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_db`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BasicSalesReport`()
BEGIN
    SELECT
        SUM(BillAmount) AS TotalSales,
        AVG(BillAmount) AS AverageSale,
        MIN(BillAmount) AS MinBillPaid,
        MAX(BillAmount) AS MaxBillPaid
    FROM Orders;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CheckBooking
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_db`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckBooking`(IN booking_date DATE, IN table_number INT)
BEGIN
    DECLARE bookedTable INT DEFAULT 0;

    SELECT COUNT(*)
    INTO bookedTable
    FROM Bookings 
    WHERE BookingDate = BookingSlot AND TableNumber = TableNo;

    IF bookedTable > 0 THEN
        SELECT CONCAT("Table ", table_number, " is already booked") AS "Booking Status";
    ELSE
        SELECT CONCAT("Table ", table_number, " is not booked") AS "Booking Status";
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GuestStatus
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_db`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GuestStatus`()
BEGIN
    SELECT CONCAT(b.GuestFirstName, ' ', b.GuestLastName) AS GuestName,
           CASE e.Role
               WHEN 'Manager' THEN 'Ready to pay'
               WHEN 'Assistant Manager' THEN 'Ready to pay'
               WHEN 'Head Chef' THEN 'Ready to serve'
               WHEN 'Assistant Chef' THEN 'Preparing Order'
               WHEN 'Head Waiter' THEN 'Order served'
           END AS OrderStatus
    FROM Bookings b
    LEFT JOIN Employees e ON b.EmployeeID = e.EmployeeID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure PeakHours
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_db`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PeakHours`()
BEGIN
    SELECT HOUR(BookingSlot) AS BookingHour, COUNT(*) AS NumberOfBookings
    FROM Bookings
    GROUP BY BookingHour
    ORDER BY NumberOfBookings DESC;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

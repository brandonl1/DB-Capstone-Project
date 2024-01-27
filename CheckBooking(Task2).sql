#TASK2
#for your second task, Little Lemon need you to create a stored procedure called CheckBooking to check whether a table in the restaurant is already booked. Creating this procedure helps to minimize the effort involved in repeatedly coding the same SQL statements.
#The procedure should have two input parameters in the form of booking date and table number. You can also create a variable in the procedure to check the status of each table.
DROP PROCEDURE IF EXISTS CheckBooking;
DELIMITER //

CREATE PROCEDURE CheckBooking(IN booking_date DATE, IN table_number INT)
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
END //

DELIMITER ;
CALL CheckBooking('2022-11-12', 6);

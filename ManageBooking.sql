DELIMITER //
CREATE PROCEDURE AddValidBooking(
    IN Booking_Date DATE,
    IN Table_Number INT
)
BEGIN
    DECLARE bookingExists INT DEFAULT 0;
    
    START TRANSACTION;

    -- Check if the table is already booked on the given date
    SELECT COUNT(*) INTO bookingExists
    FROM Bookings
    WHERE BookingDate = Booking_Date AND TableNo = Table_Number;

    IF bookingExists > 0 THEN
        -- Table is already booked, rollback the transaction
        ROLLBACK;
        SELECT CONCAT('Table ', Table_Number, ' is already booked - booking cancelled') AS "Booking Status";
    ELSE
        -- Table is available, add the new booking
        -- Assuming other fields are either nullable or have default values
        INSERT INTO Bookings (BookingDate, TableNo)
        VALUES (Booking_Date, Table_Number);
        COMMIT;
        SELECT 'Booking successful' AS "Booking Status";
    END IF;
END //

DELIMITER ;
CALL AddValidBooking("2022-10-10", 5);
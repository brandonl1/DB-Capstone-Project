DELIMITER //

CREATE PROCEDURE UpdateBooking(
    IN booking_id INT,
    IN new_booking_date DATE
)
BEGIN
    DECLARE rows_affected INT;

    UPDATE Bookings
    SET BookingDate = new_booking_date
    WHERE BookingID = booking_id;

    SET rows_affected = ROW_COUNT();

    IF rows_affected > 0 THEN
        SELECT CONCAT('Booking ID ', booking_id, ' has been successfully updated to ', new_booking_date) AS 'Update Status';
    ELSE
        SELECT CONCAT('No booking found with Booking ID ', booking_id) AS 'Update Status';
    END IF;
END //

DELIMITER ;

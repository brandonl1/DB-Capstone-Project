ALTER TABLE Bookings MODIFY COLUMN TableNumber INT;
ALTER TABLE Bookings MODIFY COLUMN CustomerID INT;
INSERT INTO Bookings (BookingID, BookingDate, TableNo, CustomerID) VALUES
(10, '2022-10-10', 5, 1),
(11, '2022-11-12', 3, 3),
(12, '2022-10-11', 2, 2),
(13, '2022-10-13', 2, 1);

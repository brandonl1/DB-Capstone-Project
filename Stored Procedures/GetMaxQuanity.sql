
CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(Quantity) AS 'Maximum Ordered Quantity'
    FROM Orders;
END 


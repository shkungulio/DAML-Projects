/****************************************************************
Function to Calculate Average Car Price:
This function calculates the average price of cars in stock.
*****************************************************************/

-- use the database
USE BNG_Car_Dealer;
GO

-- create CalculateAvgCarPrice function
CREATE FUNCTION CalculateAvgCarPrice(@price FLOAT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @avg_price FLOAT;
	SET @avg_price = AVG(@price);
	RETURN @avg_price;
END;
GO
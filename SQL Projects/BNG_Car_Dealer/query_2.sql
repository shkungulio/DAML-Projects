/*********************************************************************
Query to display sales date, car year, car make, car model, car price, 
sales price, and sales profit. Display only cars made more than 2000 
sales profit and order them in descending order.
***********************************************************************/

SELECT s.sale_date, c.[year], c.make, c.model, c.price, s.sale_price,
	(s.sale_price - c.price) AS sales_profit
FROM Cars c
JOIN Sales s ON c.car_id = s.car_id
GROUP BY s.sale_date, c.[year], c.make, c.model, c.price, s.sale_price
HAVING (s.sale_price - c.price) > 2000
ORDER BY sales_profit DESC;
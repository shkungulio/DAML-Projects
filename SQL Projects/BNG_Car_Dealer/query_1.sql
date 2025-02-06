/****************************************************************
Query to display employee names, role, 3 or more total number of sales, 
and revenue generated from the sales.
***********************************************************************/

SELECT e.first_name, e.last_name, e.role,
	COUNT(s.sale_id) AS total_sales,
	SUM(s.sale_price) AS total_revenue
FROM Employees e
JOIN Sales_Employees se ON e.employee_id = se.employee_id
JOIN Sales s ON se.sale_id = s.sale_id
GROUP BY e.employee_id, e.first_name, e.last_name, e.role
HAVING COUNT(s.sale_id) >= 3;
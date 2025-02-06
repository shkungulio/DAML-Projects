/**************************************************************
A view that shows column information from two related tables.
***************************************************************/

CREATE VIEW CarSalesInfo AS
SELECT
    S.sale_id,
    C.make AS car_make,
    C.model AS car_model,
    C.year AS car_year,
    C.price AS car_price,
    C.mileage AS car_mileage,
    C.color AS car_color,
    Cu.first_name AS customer_first_name,
    Cu.last_name AS customer_last_name,
    Cu.city AS customer_city,
    Cu.state AS customer_state,
    S.sale_date,
    S.sale_price
FROM
    Sales S
    INNER JOIN Cars C ON S.car_id = C.car_id
    INNER JOIN Customers Cu ON S.customer_id = Cu.customer_id;

/**********************************************************************************
This script creates the database named BNG_Car_Dealer with five tables and 
populate the tables using data from Mockaroo @ https://www.mackaroo.com
***********************************************************************************/
USE master;
GO

IF db_id('BNG_Car_Dealer') IS NOT NULL
DROP DATABASE BNG_Car_Dealer; --if database already exist and populated with data, drop it.
GO

CREATE DATABASE BNG_Car_Dealer; -- create database
GO

USE BNG_Car_Dealer;

-- Create the Cars table
CREATE TABLE Cars (
    car_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, -- unique car id id which is the auto-generated primary key
    make VARCHAR(255), -- the car make
    model VARCHAR(255), -- the car model
    year INT, -- the year car was released
    price DECIMAL(10, 2), -- the price of the car
    mileage INT, -- current car mileage
    color VARCHAR(50) -- the color of the car
);

-- Create the Customers table
CREATE TABLE Customers (
    customer_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, -- unique Customer id which is the auto-generated primary key
    first_name VARCHAR(50), -- customer's first name
    last_name VARCHAR(50), -- customer's last name
    email VARCHAR(100), -- customer's email address
    phone VARCHAR(20), -- customer's phone number
    address VARCHAR(255), -- customer's street address
	city VARCHAR(100), -- customer's city
	state VARCHAR(2), -- customer's state
	zip_code VARCHAR(5) -- customer's zip code
);

-- Create the Sales table
CREATE TABLE Sales (
    sale_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, -- unique Sale id which is the auto-generated primary key
    car_id INT, -- car id from Cars table (Foreign Key)
    customer_id INT, -- customer id from Customers table (Foreign Key)
    sale_date DATE, -- the date when the car sale was made
    sale_price DECIMAL(10, 2), -- car sale price
    FOREIGN KEY (car_id) REFERENCES Cars(car_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create the Employees table
CREATE TABLE Employees (
    employee_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, -- unique Employee id id which is the auto-generated primary key
    first_name VARCHAR(50), -- employee first name
    last_name VARCHAR(50), -- employee last name
    role VARCHAR(50) -- employee role
);

-- Create the Sales_Employees table
CREATE TABLE Sales_Employees (
    sale_employee_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, -- unique Sale_Employees id id which is the auto-generated primary key
    sale_id INT, -- sale id from Sales table (Foreign Key)
    employee_id INT, -- employee id from Employee table (Foreign Key)
    FOREIGN KEY (sale_id) REFERENCES Sales(sale_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);


-- populate database tables with sample database
-- data populated by Mockaroo @ https://www.mockaroo.com/
----------------------------------------------------------
-- Insert sample data into Cars table
INSERT INTO Cars (make, model, year, price, mileage, color)
VALUES
    ('Honda', 'Civic', 2023, 22000.00, 5000, 'Silver'),
	('Maserati', 'MC20 Base', 2022, 234986.00, 576, 'White'),
	('Toyota','Venza',2012,20107.64,14741,'Goldenrod'),
	('Toyota','RAV4',2012,23691.47,14797,'Mauv'),
	('Chrysler','Voyager',2002,18802.42,15839,'Turquoise'),
	('Mercedes-Benz','E-Class',1989,14582.13,13202,'Aquamarine'),
	('Toyota', 'Camry', 2022, 25000.00, 10000, 'Blue'),
    ('Ford', 'F-150', 2021, 35000.00, 15000, 'Red'),
	('Toyota','Previa',1991,18343.18,8078,'Green'),
	('Ford','LTD Crown Victoria',1985,10748.88,16236,'Puce'),
	('Lincoln','Navigator L',2010,16452.82,17565,'Khaki'),
	('Mercedes-Benz','SLR McLaren',2008,10408.73,10034,'Mauv'),
	('Mitsubishi','Challenger',2000,12933.55,15988,'Pink'),
	('Chrysler','LHS',1995,18386.07,16153,'Teal');

-- Insert sample data into Customers table
INSERT INTO Customers (first_name, last_name, email, phone, address, city, state, zip_code)
VALUES
    ('John', 'Doe', 'johndoe@email.com', '555-555-5555', '123 Main St', 'Anytown', 'CA', '12345'),
	('Ariella','Kerfod','akerfod0@vinaora.com','312-868-7919','0 Delaware Junction','Schaumburg','IL','60193'),
	('Netta','Lowson','nlowson1@mozilla.com','515-410-5127','3 Sunfield Place','Des Moines','IA','50936'),
	('Farrah','Bartolijn','fbartolijn2@icio.us','212-414-1303','00 Lotheville Terrace','New York City','NY','10249'),
	('Jane', 'Smith', 'janesmith@email.com', '555-555-5556', '456 Elm St', 'Othertown', 'NY', '54321'),
	('Aindrea','Holston','aholston3@blogtalkradio.com','215-241-5710','734 La Follette Trail','Philadelphia','PA','19184'),
	('Griz','Castaner','gcastaner4@amazon.de','303-792-3390','361 Farragut Center','Aurora','CO','80045'),
	('Natal','Beecraft','nbeecraft5@yandex.ru','312-920-1639','98032 Muir Junction','Chicago','IL','60663'),
	('Rickert','Anglin','ranglin6@mayoclinic.com','205-347-4614','61 Marcy Court','Birmingham','AL','35220'),
	('Bob', 'Johnson', 'bobjohnson@email.com', '555-555-5557', '789 Oak St', 'Anycity', 'TX', '67890'),
	('Lacee','Money','lmoney7@blogspot.com','915-690-0352','5487 Tomscot Court','El Paso','TX','88584'),
	('Andy','Smullen','asmullen8@icio.us','904-140-0703','699 Cherokee Court','Jacksonville','FL','32215');

-- Insert sample data into Sales table
INSERT INTO Sales (car_id, customer_id, sale_date, sale_price)
VALUES
    (1, 1, '2023-10-12', 24333.00),
    (2, 2, '2023-10-13', 240936.00),
    (3, 3, '2023-10-14', 23100.00),
	(4, 4, '2023-10-10', 25496.00),
	(5, 5, '2023-08-07', 20338.00),
	(6, 6, '2022-12-17', 18472.00),
	(7, 7, '2023-09-30', 26269.00),
	(8, 8, '2023-06-25', 36577.00),
	(9, 9, '2023-01-30', 20068.00),
	(10, 10, '2023-01-10', 12065.00);

-- Insert sample data into Employees table
INSERT INTO Employees (first_name, last_name, role)
VALUES
    ('Sarah', 'Brown', 'Salesperson'),
    ('Mike', 'Johnson', 'Manager'),
    ('Emily', 'Davis', 'Salesperson');

-- Insert sample data into Sales_Employees table
INSERT INTO Sales_Employees (sale_id, employee_id)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
	(4, 2),
	(5, 1),
    (6, 3),
    (7, 3),
	(8, 3),
	(9, 1),
    (10, 3);
	
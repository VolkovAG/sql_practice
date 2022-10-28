/* #SQL #Fundamentals

    <6 kyu> SQL Basics: Simple WITH

    Description:
For this challenge you need to create a SELECT statement, this SELECT statement will use an IN to check whether a
department has had a sale with a price over 90.00 dollars BUT the sql MUST use the WITH statement which will be used
to select all columns from sales where the price is greater than 90.00, you must call this sub-query special_sales.

departments table schema
    id
    name

sales table schema
    id
    department_id (department foreign key)
    name
    price
    card_name
    card_number
    transaction_date

resultant table schema
    id
    name

 */
--To complete the task, create a temporary table departments, sales ----------------------------------------------------
CREATE TEMPORARY TABLE departments
    (
    id int NOT NULL,
    name varchar(40) NOT NULL
    );

CREATE TEMPORARY TABLE sales
    (
    id int,
    department_id int,
    name varchar(40) NOT NULL,
    price float,
    card_name varchar(40),
    card_number varchar(40),
    transaction_date varchar(40)
    );

-- Now let''s fill them with records -----------------------------------------------------------------------------------
INSERT INTO departments (id, name) VALUES
(1,	'Shoes'),
(2,	'Clothing'),
(3,	'Jewelry'),
(4,	'Tools'),
(5,	'Home');

INSERT INTO sales (id, department_id, name, price, card_name, card_number, transaction_date) VALUES
(1, 3, 'Awesome Concrete Coat', 11.38, 'Larry Weber', '1211-1221-1234-2201', '2010-06-19'),
(2, 5, 'Durable Linen Knife', 49.07, 'Adalberto Pacocha', '1234-2121-1221-1211', '2016-11-30'),
(3, 3, 'Durable Bronze Gloves', 24.99, 'Theron Toy', '1228-1221-1221-1431', '2019-02-20'),
(4, 4, 'Heavy Duty Concrete Coat', 77.2, 'Preston Wiegand', '1228-1221-1221-1431', '2016-02-17'),
(5, 1, 'Incredible Copper Keyboard', 10.4, 'Miss Alivia Stracke', '1228-1221-1221-1431', '2021-06-25'),
(6, 1, 'Sleek Plastic Car', 77.05, 'Chauncey Ondricka', '1211-1221-1234-2201', '2020-05-14'),
(7, 2, 'Gorgeous Leather Bottle', 86.94, 'Josiah Metz', '1228-1221-1221-1431', '2015-02-25'),
(8, 4, 'Sleek Cotton Bottle', 40.73, 'Allie Nitzsche', '1234-2121-1221-1211', '2017-11-26'),
(9, 1, 'Awesome Marble Shoes', 31.78, 'Trystan Hayes', '1212-1221-1121-1234', '2016-06-09'),
(10, 4, 'Fantastic Wooden Pants', 99.21, 'Trinity Turner II', '1212-1221-1121-1234', '2013-07-09'),
(11, 2, 'Mediocre Granite Table', 74.02, 'Dr. Ernesto Gorczany', '1234-2121-1221-1211', '2015-11-07'),
(12, 1, 'Gorgeous Concrete Chair', 1.04, 'Stephania Cummings', '1234-2121-1221-1211', '2018-08-21'),
(13, 5, 'Awesome Linen Shirt', 89.93, 'Shawn Bruen', '1228-1221-1221-1431', '2010-09-26'),
(14, 3, 'Aerodynamic Silk Chair', 49.86, 'Gussie Walker', '1234-2121-1221-1211', '2016-07-23'),
(15, 5, 'Small Steel Knife', 13.5, 'Dillon Pouros DVM', '1211-1221-1234-2201', '2010-12-29'),
(16, 5, 'Heavy Duty Iron Keyboard', 35.6, 'Frank Mayert', '1228-1221-1221-1431', '2020-08-11'),
(17, 1, 'Durable Copper Lamp', 22.62, 'Rocky Schuster', '1234-2121-1221-1211', '2014-07-13'),
(18, 1, 'Intelligent Aluminum Shirt', 84.87, 'Isidro Wehner', '1212-1221-1121-1234', '2018-02-15'),
(19, 1, 'Mediocre Silk Watch', 45.55, 'Mr. Aleen Schuster', '1211-1221-1234-2201', '2014-12-15'),
(20, 3, 'Aerodynamic Marble Coat', 90.87, 'Ari Schneider', '1212-1221-1121-1234', '2010-04-28'),
(21, 2, 'Gorgeous Iron Watch', 19.72, 'Ms. Broderick Hammes', '1228-1221-1221-1431', '2016-10-07'),
(22, 1, 'Fantastic Silk Lamp', 13.39, 'Ruthe Gorczany III', '1228-1221-1221-1431', '2012-02-15'),
(23, 2, 'Intelligent Plastic Shoes', 56.26, 'Ciara O Connell', '1228-1221-1221-1431', '2021-03-28'),
(24, 2, 'Enormous Cotton Bag', 82.9, 'Kole Flatley', '1228-1221-1221-1431', '2016-09-11'),
(25, 1, 'Practical Plastic Hat', 25.16, 'Miss Giles Balistreri', '1212-1221-1121-1234', '2014-09-02'),
(26, 3, 'Rustic Copper Knife', 57.6, 'Cortez Boehm', '1211-1221-1234-2201', '2019-05-28'),
(27, 1, 'Synergistic Bronze Watch', 42.34, 'Treva Erdman', '1228-1221-1221-1431', '2012-06-03'),
(28, 2, 'Fantastic Copper Bench', 41.08, 'Mrs. Brenden Ullrich', '1211-1221-1234-2201', '2022-10-13'),
(29, 3, 'Rustic Concrete Gloves', 43.31, 'Dahlia Herzog', '1211-1221-1234-2201', '2015-04-16'),
(30, 3, 'Incredible Granite Hat', 7.3, 'Lemuel Haag Sr.', '1228-1221-1221-1431', '2016-09-07'),
(31, 1, 'Sleek Linen Chair', 89.49, 'Miss Earnest Bednar', '1234-2121-1221-1211', '2012-11-21'),
(32, 5, 'Fantastic Silk Shirt', 92.38, 'Ahmed Schultz', '1211-1221-1234-2201', '2020-11-06'),
(33, 3, 'Gorgeous Copper Shirt', 17.29, 'Serena Mayer', '1234-2121-1221-1211', '2020-08-25'),
(34, 1, 'Rustic Granite Clock', 15.85, 'Dr. Brain Williamson', '1234-2121-1221-1211', '2011-07-04'),
(35, 4, 'Fantastic Wooden Shoes', 56.05, 'Dr. Nicholas Beahan', '1212-1221-1121-1234', '2017-05-16'),
(36, 3, 'Mediocre Iron Watch', 12.97, 'Hellen Corkery', '1234-2121-1221-1211', '2021-10-06'),
(37, 3, 'Durable Linen Lamp', 63.53, 'Eusebio Herzog', '1234-2121-1221-1211', '2014-02-22'),
(38, 4, 'Gorgeous Leather Shirt', 56.68, 'Flavie Cormier', '1212-1221-1121-1234', '2013-04-09'),
(39, 3, 'Heavy Duty Leather Lamp', 16.17, 'Letitia Rogahn', '1234-2121-1221-1211', '2014-02-19'),
(40, 3, 'Durable Rubber Pants', 34.28, 'Salma Stark', '1234-2121-1221-1211', '2011-08-11'),
(41, 4, 'Practical Granite Lamp', 66.9, 'Noble Wehner DDS', '1212-1221-1121-1234', '2012-06-10'),
(42, 3, 'Lightweight Wool Computer', 98.46, 'Agustina Ullrich', '1211-1221-1234-2201', '2022-02-07'),
(43, 4, 'Durable Granite Bottle', 69.28, 'Sydney Terry', '1212-1221-1121-1234', '2015-09-22'),
(44, 2, 'Practical Copper Gloves', 85.09, 'Kasey McLaughlin', '1234-2121-1221-1211', '2019-06-05'),
(45, 2, 'Gorgeous Linen Clock', 20.65, 'Kayla Collier', '1228-1221-1221-1431', '2014-08-09'),
(46, 2, 'Mediocre Rubber Table', 53.56, 'Elisha Nader', '1234-2121-1221-1211', '2010-03-30'),
(47, 1, 'Aerodynamic Wooden Table', 53.78, 'Edison Fahey DVM', '1234-2121-1221-1211', '2016-01-23'),
(48, 1, 'Aerodynamic Silk Plate', 40.72, 'Teresa Daugherty Jr.', '1211-1221-1234-2201', '2016-10-29'),
(49, 1, 'Rustic Concrete Gloves', 85.85, 'Johann Smith', '1228-1221-1221-1431', '2021-01-21'),
(50, 3, 'Sleek Wool Bag', 74.55, 'Edyth Pouros', '1211-1221-1234-2201', '2017-11-23'),
(51, 1, 'Mediocre Rubber Bench', 23.03, 'Stone Kassulke', '1212-1221-1121-1234', '2011-12-12'),
(52, 5, 'Ergonomic Iron Keyboard', 45.38, 'Charlie Ledner', '1212-1221-1121-1234', '2019-04-07'),
(53, 1, 'Intelligent Aluminum Computer', 41.36, 'Jettie McGlynn', '1234-2121-1221-1211', '2021-03-03'),
(54, 1, 'Ergonomic Copper Wallet', 3.12, 'Kolby Yost', '1228-1221-1221-1431', '2015-07-17'),
(55, 5, 'Fantastic Rubber Coat', 1.21, 'Zack Zemlak', '1228-1221-1221-1431', '2012-07-19'),
(56, 3, 'Sleek Silk Shirt', 71.29, 'Scarlett Runolfsson', '1211-1221-1234-2201', '2013-12-15'),
(57, 1, 'Heavy Duty Linen Shirt', 56.66, 'Johnny McGlynn', '1234-2121-1221-1211', '2015-10-24'),
(58, 1, 'Small Copper Lamp', 57.93, 'Jake Predovic', '1212-1221-1121-1234', '2014-10-17'),
(59, 1, 'Small Bronze Shirt', 4.11, 'Desiree Rogahn', '1212-1221-1121-1234', '2016-08-15'),
(60, 5, 'Durable Iron Keyboard', 74.28, 'Heidi Labadie', '1211-1221-1234-2201', '2015-03-23'),
(61, 1, 'Gorgeous Bronze Lamp', 64.96, 'Jerald Robel MD', '1234-2121-1221-1211', '2016-12-02'),
(62, 4, 'Lightweight Paper Hat', 8.77, 'Stacey Crona', '1234-2121-1221-1211', '2019-01-25'),
(63, 3, 'Incredible Aluminum Watch', 98.07, 'Savannah Ruecker', '1211-1221-1234-2201', '2014-04-08'),
(64, 2, 'Intelligent Leather Hat', 90.88, 'Mr. Marcus Predovic', '1228-1221-1221-1431', '2010-09-09'),
(65, 1, 'Lightweight Wool Hat', 31.77, 'Harvey Lubowitz', '1228-1221-1221-1431', '2019-08-08'),
(66, 5, 'Practical Rubber Knife', 89, 'Tess Gleichner DDS', '1212-1221-1121-1234', '2010-06-09'),
(67, 5, 'Mediocre Granite Chair', 12.69, 'Thurman Pouros', '1228-1221-1221-1431', '2021-03-08'),
(68, 1, 'Heavy Duty Paper Lamp', 60.41, 'Mrs. Berniece Vandervort', '1234-2121-1221-1211', '2010-12-16'),
(69, 2, 'Aerodynamic Marble Car', 0.45, 'Lexus Quigley', '1234-2121-1221-1211', '2012-10-11'),
(70, 2, 'Awesome Aluminum Gloves', 58.23, 'Ellsworth Hilll', '1228-1221-1221-1431', '2020-01-01'),
(71, 2, 'Heavy Duty Rubber Lamp', 53.52, 'Chasity Muller', '1212-1221-1121-1234', '2019-05-24'),
(72, 2, 'Incredible Copper Computer', 57.95, 'Claude Cruickshank', '1212-1221-1121-1234', '2020-01-13'),
(73, 5, 'Enormous Wooden Pants', 64.43, 'Korey Bahringer', '1234-2121-1221-1211', '2011-09-11'),
(74, 3, 'Intelligent Wool Gloves', 67.24, 'Icie Carter', '1228-1221-1221-1431', '2012-03-24'),
(75, 3, 'Gorgeous Paper Pants', 24.79, 'Austen Bradtke', '1228-1221-1221-1431', '2021-06-10'),
(76, 1, 'Practical Wool Plate', 63.87, 'Noel O Conner', '1228-1221-1221-1431', '2013-03-17'),
(77, 5, 'Enormous Granite Shirt', 48.96, 'Ms. Elinore Kozey', '1228-1221-1221-1431', '2014-05-01'),
(78, 3, 'Rustic Rubber Bottle', 74.6, 'Jerrell Reinger', '1234-2121-1221-1211', '2021-06-02'),
(79, 1, 'Durable Leather Plate', 81.22, 'Elenora Schultz', '1228-1221-1221-1431', '2015-04-12'),
(80, 5, 'Awesome Rubber Lamp', 94.33, 'Gideon Stamm', '1211-1221-1234-2201', '2020-06-13'),
(81, 5, 'Fantastic Linen Wallet', 27.27, 'Zion Hyatt IV', '1211-1221-1234-2201', '2015-03-11'),
(82, 3, 'Intelligent Marble Bottle', 36.91, 'Ms. Jailyn Johns', '1228-1221-1221-1431', '2011-12-31'),
(83, 1, 'Awesome Plastic Gloves', 99.13, 'Estrella Little', '1234-2121-1221-1211', '2021-01-27'),
(84, 3, 'Mediocre Linen Wallet', 59.35, 'Cruz Stracke', '1228-1221-1221-1431', '2011-07-05'),
(85, 3, 'Durable Iron Chair', 5.23, 'Dr. Hulda Goyette', '1234-2121-1221-1211', '2018-06-22'),
(86, 3, 'Rustic Aluminum Shoes', 96.77, 'Freddie Thiel', '1211-1221-1234-2201', '2016-11-08'),
(87, 1, 'Ergonomic Linen Gloves', 21.52, 'Myrl Boyle V', '1234-2121-1221-1211', '2019-07-30'),
(88, 3, 'Fantastic Cotton Car', 8.06, 'Lindsey Brekke Jr.', '1234-2121-1221-1211', '2013-03-17'),
(89, 4, 'Practical Copper Keyboard', 40.96, 'Mrs. Lilly Spinka', '1234-2121-1221-1211', '2019-03-21'),
(90, 5, 'Small Paper Wallet', 64.18, 'Alice Walker', '1212-1221-1121-1234', '2017-12-22'),
(91, 3, 'Rustic Copper Bench', 67.68, 'Ms. Jaiden Stiedemann', '1228-1221-1221-1431', '2020-09-30'),
(92, 2, 'Incredible Marble Keyboard', 97.61, 'Eula Lueilwitz', '1234-2121-1221-1211', '2018-11-22'),
(93, 2, 'Ergonomic Paper Bottle', 73.76, 'Jamie Renner', '1228-1221-1221-1431', '2014-03-23'),
(94, 4, 'Mediocre Paper Hat', 42.97, 'Conner Huel', '1234-2121-1221-1211', '2022-01-12'),
(95, 4, 'Heavy Duty Wool Car', 11.86, 'Ms. Madie Monahan', '1228-1221-1221-1431', '2018-03-31'),
(96, 3, 'Ergonomic Steel Bench', 83.15, 'Wendy Olson', '1211-1221-1234-2201', '2015-12-13'),
(97, 4, 'Heavy Duty Rubber Wallet', 12.27, 'Arlo Kuhn', '1228-1221-1221-1431', '2014-03-08'),
(98, 2, 'Practical Bronze Watch', 86.34, 'Flavio Heller', '1212-1221-1121-1234', '2012-03-06'),
(99, 2, 'Awesome Marble Keyboard', 15.39, 'Miss Casimir Hessel', '1211-1221-1234-2201', '2020-10-24'),
(100, 2, 'Awesome Wool Bench', 18.69, 'Michaela Smitham', '1212-1221-1121-1234', '2010-05-20');

-- The requirement to complete the task in a certain way is fulfilled. But I don't understand why for such a simple-----
-- task to complicate the query so much.
WITH special_sales (id, department_id, name, price, card_name, card_number, transaction_date)
    AS (SELECT * FROM sales WHERE sales.price > 90)
SELECT id, name
    FROM departments
WHERE id IN (SELECT department_id FROM special_sales);

--Result, solution -----------------------------------------------------------------------------------------------------
/*
+--+--------+
|id|name    |
+--+--------+
|1 |Shoes   |
|2 |Clothing|
|3 |Jewelry |
|4 |Tools   |
|5 |Home    |
+--+--------+
 */

--This is a simpler solution for this task, and in order to use the WITH construction, you can come up with a more------
--complex task.
SELECT id, name FROM departments
WHERE id IN (SELECT department_id FROM sales WHERE price < 90);
--The result of executing the SQL script is the same as above
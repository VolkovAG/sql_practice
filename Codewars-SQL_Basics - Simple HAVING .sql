/* #SQL #Fundamentals

    <6 kyu> SQL Basics: Simple HAVING

    Description:
For this challenge you need to create a simple HAVING statement, you want to count how many people have the same age
and return the groups with 10 or more people who have that age.

people table schema
    id
    name
    age

return table schema
    age
    total_people

*/
--To complete the task, create a temporary people table ----------------------------------------------------------------
CREATE TEMPORARY TABLE people (
    id      int NOT NULL,
    name    varchar(40),
    age     int);

-- Now let''s fill them with records -----------------------------------------------------------------------------------
INSERT INTO people (id, name, age) VALUES
(1, 'Kamille Green', 63),
(2, 'Katrina Tremblay', 87),
(3, 'Joyce Parker', 98),
(4, 'Jerry Purdy', 67),
(5, 'Name Raynor', 40),
(6, 'Miss Brisa Waters', 57),
(7, 'Maxime Yundt Jr.', 78),
(8, 'Adrian Zieme V', 28),
(9, 'Dell Runolfsson', 78),
(10, 'Vickie Harvey', 59),
(11, 'Mr. Sedrick Pfeffer', 54),
(12, 'Keon Bernhard', 71),
(13, 'Rodrigo Zboncak DDS', 65),
(14, 'Keenan Dickens DVM', 14),
(15, 'Zita Cole Sr.', 71),
(16, 'Shanon Hegmann MD', 82),
(17, 'Elinor Zemlak', 57),
(18, 'Monty Prosacco', 28),
(19, 'Van Hettinger', 71),
(20, 'Eddie Muller', 94),
(21, 'Enid Brown Jr.', 68),
(22, 'Pearlie Sanford', 71),
(23, 'Madalyn Crist', 46),
(24, 'Carroll McLaughlin', 84),
(25, 'Louvenia Mertz III', 59),
(26, 'Mrs. Marlin Schiller', 80),
(27, 'Horacio Kirlin', 41),
(28, 'Retta Botsford', 79),
(29, 'Zella Towne', 71),
(30, 'Crystal Boyer', 85),
(31, 'Elta O Conner', 45),
(32, 'Vicente Rogahn', 71),
(33, 'Roma Bernhard', 71),
(34, 'Genoveva Rogahn', 12),
(35, 'Agustina O Kon', 37),
(36, 'Jevon Conn', 42),
(37, 'Mr. Aracely Tillman', 25),
(38, 'Miss Jacey Macejkovic', 32),
(39, 'Mr. Alta Mraz', 85),
(40, 'Gloria Hegmann', 95),
(41, 'Rosa Franecki', 54),
(42, 'Melyna Brakus', 28),
(43, 'Ana Hauck', 65),
(44, 'Mr. Jovany Macejkovic', 42),
(45, 'Ramiro Bahringer', 59),
(46, 'Mireya Langworth', 62),
(47, 'Elta Romaguera', 35),
(48, 'Caroline McKenzie', 62),
(49, 'Kiel Ryan', 81),
(50, 'Jules Hettinger IV', 30),
(51, 'Lesley Rutherford Sr.', 28),
(52, 'Dr. Maryjane Pouros', 95),
(53, 'Darlene Gleichner DVM', 85),
(54, 'Sonya Jenkins', 84),
(55, 'Dr. Conor Block', 54),
(56, 'Miss Vincenzo Bartell', 22),
(57, 'Santina Bartoletti', 27),
(58, 'Dianna Johnston', 90),
(59, 'Kirk Brakus', 51),
(60, 'Porter Howe', 71),
(61, 'Cordia Kovacek', 31),
(62, 'Cecilia Stark', 29),
(63, 'Mr. Lyda Wiza', 71),
(64, 'Taryn Walker', 28),
(65, 'Quincy Lakin', 21),
(66, 'Van Boyle', 28),
(67, 'Raphael Boehm', 14),
(68, 'Ms. Fiona Kuhn', 28),
(69, 'Austen Kutch MD', 44),
(70, 'Laisha Nienow III', 38),
(71, 'Kaylin Feeney Jr.', 28),
(72, 'Jarod Jakubowski MD', 31),
(73, 'Madyson Abbott', 71),
(74, 'Dr. Daryl Kihn', 78),
(75, 'Eloise Lang', 71),
(76, 'Leone Pagac III', 75),
(77, 'Floyd Luettgen', 87),
(78, 'Forrest Leuschke', 28),
(79, 'Sean Altenwerth III', 71),
(80, 'Roman Schamberger', 86),
(81, 'Mrs. Corene Beier', 71),
(82, 'Jennings Hegmann DVM', 84),
(83, 'Darrel Medhurst', 93),
(84, 'Nina Sporer', 82),
(85, 'Myles Douglas', 11),
(86, 'Ross Volkman', 63),
(87, 'Sabina Little', 24),
(88, 'Myriam MacGyver', 79),
(89, 'Lenore Kutch', 63),
(90, 'Ms. Kenya Toy', 19),
(91, 'Destiney Ondricka', 49),
(92, 'Edwardo Yundt', 90),
(93, 'Piper Romaguera', 29),
(94, 'Aurore McLaughlin', 76),
(95, 'Walton Haag', 57),
(96, 'Kylee Beer', 28),
(97, 'Destinee McDermott', 73),
(98, 'Ms. Else Moore', 15),
(99, 'Gaetano Borer DVM', 31),
(100, 'Elvie Bogisich', 59);

--Now let's write and execute the required query -----------------------------------------------------------------------
SELECT age, COUNT(age) AS total_people
  FROM people
  GROUP BY age
  HAVING COUNT(age) >= 10;

--Result, solution -----------------------------------------------------------------------------------------------------
/*
+---+------------+
|age|total_people|
+---+------------+
|71 |13          |
|28 |10          |
+---+------------+
*/
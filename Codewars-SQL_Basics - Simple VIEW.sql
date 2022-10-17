/* #SQL #Fundamentals

    <5 kyu> SQL Basics: Simple VIEW

    Description:
For this challenge you need to create a VIEW. This VIEW is used by a sales store to give out vouches to members who
have spent over $1000 in departments that have brought in more than $10000 total ordered by the members id.
The VIEW must be called members_approved_for_voucher then you must create a SELECT query using the view.

Tables and relationship below: https://imgur.com/hkEkGg1

resultant table schema
    id
    name
    email
    total_spending
*/

--To complete the task, create a temporary people table ----------------------------------------------------------------
CREATE TEMPORARY TABLE departments (
    id BIGSERIAL,
    name varchar(40));

CREATE TEMPORARY TABLE products (
    id BIGSERIAL,
    name varchar(40),
    price decimal(10,2));

CREATE TEMPORARY TABLE members (
    id BIGSERIAL,
    name varchar(40),
    number int,
    email varchar(40),
    city varchar(40),
    street_name varchar(40),
    street_address varchar(40));

CREATE TEMPORARY TABLE sales (
    id BIGSERIAL,
    department_id int,
    product_id int,
    member_id int,
    transaction_date timestamp);

-- Now let's fill them with records -----------------------------------------------------------------------------------
INSERT INTO departments (name) VALUES
    ('Shoes'),
    ('Clothing'),
    ('Jewelry'),
    ('Tools');

INSERT INTO products (id, name, price) VALUES
(1, 'Intelligent Plastic Table', 72.57),
(2, 'Aerodynamic Leather Shirt', 74.21),
(3, 'Durable Rubber Bag', 47.46),
(4, 'Heavy Duty Leather Plate', 87.01),
(5, 'Heavy Duty Linen Bottle', 7.17),
(6, 'Lightweight Bronze Coat', 19.13),
(7, 'Durable Steel Chair', 83.59),
(8, 'Ergonomic Aluminum Gloves', 11.01),
(9, 'Gorgeous Leather Clock', 17.62),
(10, 'Sleek Leather Lamp', 25.12),
(11, 'Small Linen Lamp', 18.56),
(12, 'Rustic Bronze Car', 86.72),
(13, 'Fantastic Wool Shoes', 75.5),
(14, 'Awesome Granite Keyboard', 14.32),
(15, 'Aerodynamic Linen Wallet', 37.79),
(16, 'Lightweight Plastic Chair', 27.88),
(17, 'Small Concrete Hat', 91.9),
(18, 'Mediocre Copper Coat', 22.77),
(19, 'Aerodynamic Plastic Hat', 83.16),
(20, 'Synergistic Cotton Lamp', 60.51),
(21, 'Heavy Duty Steel Car', 20.15),
(22, 'Awesome Aluminum Coat', 82.91),
(23, 'Heavy Duty Granite Keyboard', 97.4),
(24, 'Practical Steel Watch', 61.42),
(25, 'Rustic Rubber Car', 44.65),
(26, 'Mediocre Leather Computer', 53.17),
(27, 'Fantastic Silk Shoes', 22.74),
(28, 'Rustic Leather Coat', 93.29),
(29, 'Heavy Duty Rubber Plate', 75.89),
(30, 'Heavy Duty Rubber Watch', 15.52),
(31, 'Lightweight Paper Hat', 87.06),
(32, 'Aerodynamic Silk Watch', 04.01),
(33, 'Rustic Copper Car', 56.44),
(34, 'Practical Granite Shoes', 75.07),
(35, 'Rustic Wool Bottle', 17.58),
(36, 'Sleek Wool Coat', 86.77),
(37, 'Enormous Linen Bench', 41.66),
(38, 'Practical Rubber Table', 85.58),
(39, 'Intelligent Rubber Knife', 84.95),
(40, 'Lightweight Linen Hat', 33.88),
(41, 'Intelligent Marble Table', 18.93),
(42, 'Sleek Iron Watch', 77.46),
(43, 'Intelligent Marble Watch', 77.85),
(44, 'Fantastic Wool Computer', 12.72),
(45, 'Fantastic Aluminum Wallet', 22.59),
(46, 'Aerodynamic Linen Watch', 1.21),
(47, 'Synergistic Granite Table', 62.31),
(48, 'Awesome Marble Wallet', 0.12),
(49, 'Incredible Cotton Lamp', 26.66),
(50, 'Sleek Rubber Coat', 12.98),
(51, 'Sleek Copper Knife', 49.61),
(52, 'Enormous Bronze Bottle', 8.25),
(53, 'Incredible Wooden Bag', 53.03),
(54, 'Rustic Cotton Lamp', 44.21),
(55, 'Lightweight Wool Bottle', 73.69),
(56, 'Fantastic Linen Bag', 67.76),
(57, 'Practical Aluminum Wallet', 74.81),
(58, 'Durable Granite Watch', 41.95),
(59, 'Durable Linen Wallet', 44.77),
(60, 'Awesome Cotton Keyboard', 55.66),
(61, 'Intelligent Aluminum Keyboard', 69.62),
(62, 'Small Wooden Computer', 57.85),
(63, 'Synergistic Paper Computer', 1.97),
(64, 'Aerodynamic Wool Watch', 42.03),
(65, 'Lightweight Wooden Pants', 0.68),
(66, 'Gorgeous Marble Car', 99.29),
(67, 'Small Marble Lamp', 86.32),
(68, 'Heavy Duty Copper Clock', 26.73),
(69, 'Awesome Marble Lamp', 34.63),
(70, 'Small Leather Car', 90.82),
(71, 'Incredible Paper Table', 63.1),
(72, 'Enormous Leather Bottle', 36.61),
(73, 'Durable Iron Watch', 42.02),
(74, 'Ergonomic Plastic Bottle', 90.96),
(75, 'Synergistic Linen Computer', 62.43),
(76, 'Ergonomic Linen Clock', 72.91),
(77, 'Enormous Paper Keyboard', 93.09),
(78, 'Fantastic Rubber Computer', 65.45),
(79, 'Small Rubber Car', 22.24),
(80, 'Durable Copper Watch', 64.26),
(81, 'Aerodynamic Iron Bottle', 47.28),
(82, 'Heavy Duty Cotton Coat', 19),
(83, 'Practical Leather Pants', 89.44),
(84, 'Ergonomic Marble Knife', 68.76),
(85, 'Fantastic Linen Bench', 32.61),
(86, 'Sleek Copper Bag', 41.77),
(87, 'Small Wooden Clock', 92.84),
(88, 'Heavy Duty Leather Shirt', 32.46),
(89, 'Small Marble Bag', 88.14),
(90, 'Lightweight Linen Bag', 99.67),
(91, 'Mediocre Silk Hat', 58.37),
(92, 'Sleek Concrete Lamp', 96.43),
(93, 'Lightweight Wool Clock', 27.66),
(94, 'Gorgeous Copper Computer', 98.21),
(95, 'Aerodynamic Wooden Pants', 79.71),
(96, 'Mediocre Granite Chair', 80.2),
(97, 'Synergistic Silk Shoes', 23.81),
(98, 'Small Paper Bottle', 73.57),
(99, 'Incredible Cotton Chair', 70.59),
(100, 'Practical Paper Bottle', 17.86);

INSERT INTO members (id, name, number, email, city, street_name, street_address) VALUES
(1, 'Eusebio Schuppe I', 1769906, 'aida@mante.com', 'Lake Luluside', 'Glover Plains', '922 Malachi Pine'),
(2, 'Daija Koss', 6783899, 'john.hammes@hermiston.name', 'Port Devan', 'Sherwood Divide', '9352 Rath Port'),
(3, 'Bianka Lind', 7297303, 'rowan@hintzkohler.biz', 'New Ellenmouth', 'Marques Run', '42459 Donnell Inlet'),
(4, 'Loraine Mueller', 8358688, 'harrison_will@price.info', 'South Nayelifort', 'Schamberger Trafficway', '23635 Evalyn Estates'),
(5, 'Andre Predovic', 9327094, 'kobe@stracke.co', 'Rutherfordport', 'Lind Trafficway', '7357 Russel Via'),
(6, 'Richie Stehr', 1842366, 'jey.blick@schuppe.com', 'New Josuefort', 'Balistreri Neck', '5670 Terry Corner'),
(7, 'Mr. Theresia Cremin', 6075767, 'pearlie@boehm.com', 'New Freidamouth', 'Nya Stravenue', '488 Lavern Tunnel'),
(8, 'Kellen Padberg IV', 7228346, 'buster@cronaberge.io', 'Gorczanymouth', 'Houston Loop', '25897 Lueilwitz Shores'),
(9, 'Aaliyah Armstrong', 4190788, 'alicia@powlowski.com', 'North Gino', 'Abshire Walk', '926 Friesen Lights'),
(10, 'Barrett Gleichner', 5246075, 'colt.kuhic@schinner.net', 'North Elda', 'Gladyce Wells', '2424 Cathryn Circle'),
(11, 'Dr. Emery Kovacek', 7410144, 'benton_hansen@sporer.org', 'Karianeton', 'Blanda Drives', '411 Hermiston Estate'),
(12, 'Humberto Becker', 2072730, 'laurie@cronin.com', 'Christiansenhaven', 'Littel Locks', '600 McDermott Passage'),
(13, 'Winnifred Stracke', 4636115, 'irma@kuphalparisian.com', 'Lindgrenfurt', 'Reilly Rue', '52675 Hyatt Summit'),
(14, 'Pat Hoppe', 9019653, 'gunnar_schowalter@spencerwatsica.io', 'Port Kane', 'Klein Road', '9142 Kuphal Lock'),
(15, 'Norval Turner', 3525381, 'taryn_collier@moore.com', 'Baumbachberg', 'Steuber Ranch', '576 Godfrey Locks'),
(16, 'Marie Deckow Jr.', 3301740, 'estel@cummings.net', 'New Jett', 'Johns Extension', '20516 Katlyn Plains'),
(17, 'Miss Kendra Collins', 5705005, 'hettie@medhurst.io', 'New Christa', 'Bechtelar Mission', '61968 Sylvester Crossroad'),
(18, 'Tia O Reilly', 8821025, 'althea.towne@hane.io', 'Littelbury', 'Johnson Mill', '3854 Towne Squares'),
(19, 'Bryce Crooks', 7578875, 'bethel.medhurst@littel.biz', 'New Audreanne', 'Enrique Tunnel', '386 Williamson Highway'),
(20, 'Tyrique West', 8550809, 'guadalupe.roberts@metz.org', 'South Hobart', 'Abdiel Ferry', '460 Littel Pike'),
(21, 'Cyril Johnston', 2494555, 'boyd_stehr@cormier.info', 'West Sierra', 'Medhurst Squares', '40742 Schulist Bridge'),
(22, 'Arne Hammes IV', 9279772, 'elouise@hane.name', 'Kadenville', 'Delbert Ranch', '944 Renner Inlet'),
(23, 'Rae Mann', 8317411, 'tate.considine@kuhlman.biz', 'Bartolettimouth', 'Macey Junctions', '212 Marvin Drive'),
(24, 'Trudie Jast', 5736398, 'earlene_stamm@smitham.com', 'Muellerfurt', 'Kihn Oval', '4065 Gulgowski Parks'),
(25, 'Bradley Lemke', 8612328, 'eldred_lehner@harberschumm.biz', 'Port Jazmyn', 'Barney Place', '53433 Lehner Summit'),
(26, 'Magali Pfannerstill', 7863635, 'ransom.blick@oreilly.net', 'Lilianaton', 'Bailey Trafficway', '87849 Joshuah Court'),
(27, 'Gerda Smith', 7276755, 'lucas@mosciski.org', 'New Joel', 'Shemar Lock', '5137 Khalid Station'),
(28, 'Daniella Doyle', 4361593, 'marina@green.name', 'New Makenzie', 'Harber Mountains', '54302 Zemlak Vista'),
(29, 'Gerhard Schinner Jr.', 2697966, 'christiana@lueilwitz.biz', 'East Wilmerville', 'Dorothea Port', '2258 Hilpert Throughway'),
(30, 'Dulce Hoppe', 9540258, 'santos@hoegergrady.biz', 'South Summermouth', 'Tromp Freeway', '734 Rosina Views'),
(31, 'Mrs. Clemmie Macejkovic', 6316765, 'rod@greenholt.org', 'Lennaborough', 'Sister Point', '398 Jany Trafficway'),
(32, 'Norma O Kon', 1731002, 'jannie@gaylord.org', 'North Stevie', 'Stevie Harbors', '847 Green Island'),
(33, 'Dallin Weissnat I', 8192416, 'zachery@hanebernier.com', 'Haagland', 'Kassulke Forge', '89841 Durgan Tunnel'),
(34, 'Mrs. Elliott Schulist', 4710211, 'darien@lesch.biz', 'Lake Eduardo', 'Dawn Lodge', '88527 Donnelly Light'),
(35, 'Bobbie Schaden', 2674110, 'everardo@mclaughlincrona.io', 'Nedtown', 'Schmitt Squares', '95778 Lynch Meadows'),
(36, 'Maegan Spinka MD', 6441415, 'emily@oconnell.org', 'East Eldridge', 'Beer Alley', '90386 Reagan Villages'),
(37, 'Coy Gorczany', 5044526, 'keegan.kunze@flatleyhintz.info', 'Hayleefurt', 'Zackary Meadows', '5231 Homenick Coves'),
(38, 'Dimitri Zieme', 1996272, 'providenci@dickenskoepp.biz', 'Port Selena', 'Nelle Corners', '71201 Veum Extensions'),
(39, 'Elza Rohan V', 8687525, 'ava@huels.name', 'Wolffborough', 'Jake Overpass', '8841 Bernhard Forge'),
(40, 'Margret Stanton IV', 1819848, 'frederick@lesch.biz', 'Schowalterchester', 'Keagan Streets', '80066 Corene Mews'),
(41, 'Rebekah Kuvalis', 8595252, 'jarrell_hickle@frami.io', 'Opheliaton', 'Lind Run', '92178 Fadel Drive'),
(42, 'Eunice Waelchi', 5900169, 'brayan.emmerich@huelsgoodwin.biz', 'North Minamouth', 'Nola Trail', '29553 Hank Knolls'),
(43, 'Kristina Langosh', 6999584, 'adell_sipes@effertz.net', 'North Nicolebury', 'Germaine Spur', '3215 Wilfrid Burgs'),
(44, 'Dr. Bernardo Friesen', 2551007, 'bella.mcclure@quitzonabshire.info', 'West Clarabellefurt', 'Robel Avenue', '37459 Reichert Garden'),
(45, 'Leora Hoppe', 6951214, 'anjali_dicki@heel.io', 'Oberbrunnerburgh', 'Liliana Square', '20694 Ian Manors'),
(46, 'Daisy Muller', 6771095, 'maribel.nolan@kerluke.io', 'Lake Kayleyland', 'George Route', '2745 Skiles Viaduct'),
(47, 'Lindsey Dooley', 9633075, 'arnoldo.bailey@jacobs.biz', 'Port Lina', 'Mary Island', '9687 Aleen Plain'),
(48, 'Otha Nitzsche', 6103040, 'kaia@koelpin.io', 'Keeblermouth', 'Monahan Dam', '8405 Koelpin Motorway'),
(49, 'Johnson Turcotte', 2562948, 'bennie@aufderhar.net', 'New Ashlynnburgh', 'Alana Roads', '405 Caesar Islands'),
(50, 'Marilou Bechtelar', 2832421, 'mack@mills.net', 'Port Horacio', 'Bogan Row', '25553 Hank Knolls');

-- let's create generated records for this table sales -----------------------------------------------------------------
INSERT INTO sales (department_id, product_id, member_id, transaction_date)
    SELECT  trunc(random() * 4 + 1),
            trunc(random() * 100 + 1),
            trunc(random() * 50 + 1),
            (select '2022-01-01'::timestamp + make_interval(0, 0, 0, i) as gs)
            FROM generate_series(0, 1000, 1) as i;

--Now let's write and execute the required query -----------------------------------------------------------------------
CREATE VIEW members_approved_for_voucher AS
  SELECT id, name, email, SUM(price) AS total_spending
  FROM (
      SELECT
        departments.id AS dep_id,
        SUM(price) OVER (PARTITION BY department_id ORDER BY department_id) AS sum_dep,
        members.id,
        members.name,
        members.email,
        products.price
      FROM sales
            INNER JOIN products ON products.id = sales.product_id
            INNER JOIN members ON members.id = sales.member_id
            INNER JOIN departments ON departments.id = sales.department_id
      ORDER BY department_id, member_id) AS query1
    WHERE sum_dep >10000
    GROUP BY id, name, email
    HAVING SUM(price) > 1000
    ORDER BY id;

SELECT * FROM members_approved_for_voucher;

--Result, solution -----------------------------------------------------------------------------------------------------
/*
+--+-------------------+--------------------------+--------------+
|id|name               |email                     |total_spending|
+--+-------------------+--------------------------+--------------+
|1 |Eusebio Schuppe I  |aida@mante.com            |1713.97       |
|3 |Bianka Lind        |rowan@hintzkohler.biz     |1787.62       |
|4 |Loraine Mueller    |harrison_will@price.info  |1041.77       |
|7 |Mr. Theresia Cremin|pearlie@boehm.com         |1444.94       |
|8 |Kellen Padberg IV  |buster@cronaberge.io      |1224.52       |
|9 |Aaliyah Armstrong  |alicia@powlowski.com      |1319.82       |
|12|Humberto Becker    |laurie@cronin.com         |1315.44       |
|15|Norval Turner      |taryn_collier@moore.com   |1101.8        |
|19|Bryce Crooks       |bethel.medhurst@littel.biz|1327.49       |
|20|Tyrique West       |guadalupe.roberts@metz.org|1341.3        |
|..|...                |...                       |...           |
+--+-------------------+--------------------------+--------------+
*/
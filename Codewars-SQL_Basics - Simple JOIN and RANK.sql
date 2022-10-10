/* #SQL #Fundamentals
For this challenge you need to create a simple SELECT statement that will return all columns from the people table,
and join to the sales table so that you can return the COUNT of all sales and RANK each person by their sale_count.

people table schema
    id
    name

sales table schema
    id
    people_id
    sale
    price

You should return all people fields as well as the sale count as "sale_count" and the rank as "sale_rank".*/

--To complete the task, create temporary tables people and sales -------------------------------------------------------
CREATE TEMPORARY TABLE people (
    id      int NOT NULL,
    name    varchar(40));

CREATE TEMPORARY TABLE sales (
    id  int NOT NULL,
    people_id   int NOT NULL,
    sale    varchar(40) NOT NULL,
    price int NOT NULL);

-- Now let''s fill them with records -----------------------------------------------------------------------------------
INSERT INTO people (id, name) VALUES
    (1, 'Clinton Botsford'),
    (2, 'Granville Ruecker PhD'),
    (3, 'Emery Leannon'),
    (4, 'Mrs. Gerardo Gaylord'),
    (5, 'Dr. Susie Barton'),
    (6, 'Mrs. Freddie Bogisich'),
    (7, 'Bertram Eichmann'),
    (8, 'Miss Camylle Gulgowski'),
    (9, 'Miss Dario Goodwin'),
    (10,'Devan Beatty');

INSERT INTO sales (id, people_id, sale, price) VALUES
(1,	4,	'Rustic Marble Coat',	5831),
(2,	10,	'Aerodynamic Granite Shoes',	8227),
(3,	2,	'Sleek Plastic Bottle',	1292),
(4,	3,	'Lightweight Aluminum Bench',	5563),
(5,	8,	'Enormous Granite Pants',	8052),
(6,	5,	'Lightweight Plastic Hat',	7483),
(7,	4,	'Rustic Marble Gloves',	3964),
(8,	1,	'Aerodynamic Iron Watch',	8260),
(9,	10,	'Enormous Wool Lamp',	1760),
(10,	6,	'Sleek Marble Chair',	2022),
(11,	4,	'Aerodynamic Marble Gloves',	8518),
(12,	10,	'Ergonomic Paper Shoes',	2651),
(13,	9,	'Gorgeous Copper Keyboard',	5424),
(14,	3,	'Intelligent Granite Computer',	2938),
(15,	5,	'Practical Plastic Shoes',	3466),
(16,	9,	'Practical Leather Bottle',	3712),
(17,	9,	'Awesome Copper Bag',	2613),
(18,	4,	'Practical Marble Computer',	5823),
(19,	1,	'Incredible Bronze Pants',	2967),
(20,	1,	'Lightweight Marble Coat',	9796),
(21,	10,	'Heavy Duty Rubber Plate',	6923),
(22,	3,	'Synergistic Paper Lamp',	6747),
(23,	3,	'Intelligent Iron Watch',	7908),
(24,	3,	'Incredible Copper Gloves',	3085),
(25,	1,	'Sleek Iron Shirt',	1988),
(26,	5,	'Heavy Duty Leather Keyboard',	5630),
(27,	4,	'Small Linen Bottle',	4897),
(28,	7,	'Intelligent Marble Table',	7886),
(29,	6,	'Awesome Silk Keyboard',	1807),
(30,	7,	'Rustic Iron Bench',	8521),
(31,	3,	'Fantastic Marble Wallet',	9448),
(32,	9,	'Rustic Paper Keyboard',	7233),
(33,	6,	'Incredible Rubber Watch',	2179),
(34,	2,	'Enormous Silk Watch',	1930),
(35,	7,	'Incredible Leather Watch',	9598),
(36,	10,	'Enormous Linen Knife',	1917),
(37,	8,	'Small Bronze Pants',	7108),
(38,	4,	'Mediocre Plastic Computer',	9121),
(39,	10,	'Mediocre Wool Wallet',	9199),
(40,	10,	'Durable Rubber Bag',	5191),
(41,	5,	'Gorgeous Leather Shoes',	9747),
(42,	4,	'Small Linen Coat',	2673),
(43,	2,	'Gorgeous Steel Car',	2762),
(44,	10,	'Heavy Duty Paper Chair',	9205),
(45,	6,	'Rustic Aluminum Shoes',	3240),
(46,	5,	'Small Steel Gloves',	9960),
(47,	8,	'Rustic Rubber Keyboard',	7724),
(48,	6,	'Small Copper Table',	6228),
(49,	10,	'Aerodynamic Steel Car',	7084),
(50,	7,	'Aerodynamic Paper Wallet',	9162),
(51,	4,	'Heavy Duty Linen Bottle',	3576),
(52,	3,	'Incredible Iron Table',	6801),
(53,	2,	'Intelligent Steel Pants',	8355),
(54,	4,	'Heavy Duty Paper Bag',	5398),
(55,	4,	'Aerodynamic Aluminum Computer',	4148),
(56,	8,	'Lightweight Bronze Hat',	1682),
(57,	5,	'Rustic Wool Keyboard',	5403),
(58,	10,	'Gorgeous Marble Bench',	8125),
(59,	10,	'Intelligent Concrete Coat',	7079),
(60,	4,	'Synergistic Linen Knife',	5909),
(61,	4,	'Aerodynamic Leather Watch',	8360),
(62,	7,	'Rustic Bronze Gloves',	2895),
(63,	8,	'Intelligent Leather Shirt',	9927),
(64,	9,	'Lightweight Steel Car',	8252),
(65,	4,	'Gorgeous Plastic Chair',	4557),
(66,	1,	'Durable Aluminum Lamp',	7965),
(67,	2,	'Incredible Paper Table',	2667),
(68,	7,	'Small Plastic Table',	5649),
(69,	6,	'Lightweight Wool Bottle',	1911),
(70,	6,	'Durable Aluminum Knife',	7912),
(71,	4,	'Gorgeous Marble Lamp',	1899),
(72,	3,	'Heavy Duty Cotton Knife',	9019),
(73,	6,	'Fantastic Rubber Clock',	6457),
(74,	2,	'Intelligent Copper Wallet',	2908),
(75,	8,	'Mediocre Bronze Car',	9398),
(76,	10,	'Incredible Silk Clock',	8760),
(77,	8,	'Gorgeous Marble Knife',	1827),
(78,	8,	'Practical Plastic Shoes',	7003),
(79,	5,	'Heavy Duty Paper Watch',   7748),
(80,	7,	'Rustic Granite Pants',	3438),
(81,	1,	'Ergonomic Marble Bag',	6473),
(82,	8,	'Lightweight Plastic Keyboard', 8251),
(83,	2,	'Enormous Marble Pants',	3851),
(84,	2,	'Enormous Rubber Computer',	3663),
(85,	5,	'Fantastic Bronze Coat',	1862),
(86,	4,	'Intelligent Granite Car',	3578),
(87,	10,	'Mediocre Aluminum Table',	4994),
(88,	10,	'Incredible Steel Gloves',	7075),
(89,	8,	'Enormous Concrete Bag',	2103),
(90,	5,	'Gorgeous Aluminum Keyboard',	3278),
(91,	2,	'Fantastic Steel Lamp',	4417),
(92,	4,	'Lightweight Bronze Watch',	6633),
(93,	9,	'Practical Iron Computer',	8991),
(94,	10,	'Durable Cotton Bottle',	2009),
(95,	2,	'Ergonomic Plastic Watch',	3594),
(96,	6,	'Rustic Silk Pants',	5043),
(97,	4,	'Synergistic Rubber Shoes',	1695),
(98,	9,	'Durable Granite Clock',	7541),
(99,	10,	'Heavy Duty Aluminum Lamp',	3602),
(100,	3,	'Intelligent Granite Plate',	2565);

--Now let's write and execute the required query -----------------------------------------------------------------------
SELECT
  p.id,
  p.name,
  COUNT(s.people_id) AS sale_count,
  RANK() OVER (ORDER BY count(s.people_id) DESC) AS sale_rank
  FROM people p
    INNER JOIN sales s ON p.id = s.people_id
  GROUP BY p.id, p.name;


--Result, solution -----------------------------------------------------------------------------------------------------
/*
+--+----------------------+----------+---------+
|id|name                  |sale_count|sale_rank|
+--+----------------------+----------+---------+
|4 |Mrs. Gerardo Gaylord  |17        |1        |
|10|Devan Beatty          |16        |2        |
|8 |Miss Camylle Gulgowski|10        |3        |
|2 |Granville Ruecker PhD |10        |3        |
|6 |Mrs. Freddie Bogisich |9         |5        |
|5 |Dr. Susie Barton      |9         |5        |
|3 |Emery Leannon         |9         |5        |
|9 |Miss Dario Goodwin    |7         |8        |
|7 |Bertram Eichmann      |7         |8        |
|1 |Clinton Botsford      |6         |10       |
+--+----------------------+----------+---------+
*/
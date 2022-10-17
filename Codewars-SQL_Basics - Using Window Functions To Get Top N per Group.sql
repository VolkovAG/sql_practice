/* #SQL #Fundamentals #Databases

    <5 kyu> Using Window Functions To Get Top N per Group

    Description:
Given the schema presented below write a query, which uses a window function, that returns two most viewed posts for
every category.

Order the result set by:
    1. category name alphabetically
    2. number of post views largest to lowest
    3. post id lowest to largest

Note:
    - Some categories may have less than two or no posts at all.
    - Two or more posts within the category can be tied by (have the same) the number of views. Use post id as a tie
    breaker - a post with a lower id gets a higher rank.

Schema:
categories
Column      | Type                   | Modifiers
------------+------------------------+----------
id          | integer                | not null
category    | character varying(255) | not null

posts
Column      | Type                   | Modifiers
------------+------------------------+----------
id          | integer                | not null
category_id | integer                | not null
title       | character varying(255) | not null
views       | integer                | not null

Desired Output
The desired output should look like this:
category_id | category | title                             | views | post_id
------------+----------+-----------------------------------+-------+--------
5           | art      | Most viewed post about Art        | 9234  | 234
5           | art      | Second most viewed post about Art | 9234  | 712
2           | business | NULL                              | NULL  | NULL
7           | sport    | Most viewed post about Sport      | 10    | 126
...
*/
--To complete the task, create a temporary table categories, posts------------------------------------------------------
CREATE TEMPORARY TABLE categories (
    id BIGSERIAL NOT NULL ,
    category varchar(255) NOT NULL );

CREATE TEMPORARY TABLE posts (
    id BIGSERIAL NOT NULL ,
    title varchar(255) NOT NULL ,
    category_id int NOT NULL ,
    views int NOT NULL );

-- Now let's fill them with records -----------------------------------------------------------------------------------
INSERT INTO categories (category) VALUES
('qui'),
('fugiat'),
('quidem'),
('voluptate'),
('aut'),
('perspiciatis'),
('facilis'),
('ipsum'),
('deserunt'),
('soluta');

INSERT INTO posts (id, title, category_id, views) VALUES
(1, 'In porro rerum deleniti.', 7, 92),
(2, 'Error mollitia dolor eligendi.', 1, 753),
(3, 'Et reiciendis vitae ad.', 4, 900),
(4, 'Omnis quidem voluptatem voluptatum.', 6, 843),
(5, 'Quo minima explicabo non.', 4, 235),
(6, 'Ullam id et rerum.', 8, 630),
(7, 'Assumenda labore voluptatem voluptatibus.', 7, 15),
(8, 'Rerum ut id sed.', 4, 195),
(9, 'Ut et quos nam.', 6, 52),
(10, 'Dolores aut sed numquam.', 5, 368),
(11, 'Libero et corrupti accusamus.', 2, 669),
(12, 'Blanditiis voluptas molestiae consequatur.', 5, 980),
(13, 'Et quia quaerat omnis.', 8, 751),
(14, 'Corrupti impedit sunt neque.', 1, 640),
(15, 'Illum facilis nostrum et.', 1, 758),
(16, 'Totam sint et odio.', 10, 479),
(17, 'Natus consectetur rerum voluptas.', 7, 364),
(18, 'Non saepe nam ea.', 6, 445),
(19, 'Amet dolor vitae libero.', 6, 334),
(20, 'Nam est adipisci est.', 10, 321),
(21, 'Reprehenderit doloremque veritatis optio.', 10, 159),
(22, 'Esse dolores omnis et.', 10, 180),
(23, 'Ipsa et asperiores quod.', 4, 314),
(24, 'Eos veritatis cupiditate eum.', 4, 265),
(25, 'Veniam nesciunt velit quia.', 4, 502),
(26, 'Libero nesciunt dignissimos quo.', 8, 479),
(27, 'Ullam non ut aut.', 7, 833),
(28, 'Architecto perspiciatis alias ipsam.', 2, 258),
(29, 'Eos qui aliquid distinctio.', 5, 98),
(30, 'Maxime veritatis nihil cumque.', 5, 68),
(31, 'Ea porro ea incidunt.', 5, 957),
(32, 'Beatae natus eveniet atque.', 10, 404),
(33, 'Quia vero qui culpa.', 6, 932),
(34, 'Doloribus alias aperiam dolores.', 5, 446),
(35, 'Voluptatem aspernatur iusto porro.', 6, 629),
(36, 'Eligendi nulla dolorem quo.', 4, 820),
(37, 'Iure voluptatem quia optio.', 10, 799),
(38, 'Sequi rem dolor dolorem.', 1, 638),
(39, 'Eum modi fugit et.', 6, 244),
(40, 'Qui exercitationem non laboriosam.', 4, 836),
(41, 'Alias aut voluptas iure.', 5, 683),
(42, 'Deserunt tenetur nesciunt ducimus.', 10, 220),
(43, 'Id architecto inventore facere.', 5, 647),
(44, 'Sit unde alias est.', 2, 615),
(45, 'Dicta ut quod non.', 6, 938),
(46, 'Enim esse voluptas numquam.', 2, 741),
(47, 'Eveniet excepturi natus quia.', 1, 947),
(48, 'Ipsam aut quis facilis.', 2, 22),
(49, 'Accusantium ut quo quisquam.', 5, 877),
(50, 'Iure itaque aut sint.', 7, 775),
(51, 'Omnis debitis atque aut.', 1, 956),
(52, 'Enim dolores fugiat earum.', 10, 650),
(53, 'Et velit provident rerum.', 8, 314),
(54, 'Et dolorum veritatis dolorem.', 1, 607),
(55, 'Necessitatibus vitae quo dolorum.', 5, 183),
(56, 'Et quas est voluptatem.', 1, 380),
(57, 'Tenetur explicabo vero ipsum.', 10, 419),
(58, 'Fugit quisquam corrupti consequatur.', 8, 749),
(59, 'Suscipit culpa ipsa nobis.', 1, 997),
(60, 'Magni expedita et magnam.', 1, 759),
(61, 'Quia nesciunt sit aliquam.', 4, 345),
(62, 'Est mollitia et voluptas.', 4, 145),
(63, 'Dolor qui sit deserunt.', 8, 765),
(64, 'Voluptatem qui sit deserunt.', 10, 826),
(65, 'Et corporis vel qui.', 7, 942),
(66, 'Veritatis totam laborum eos.', 1, 100),
(67, 'Eveniet nisi voluptate possimus.', 6, 556),
(68, 'Quam consequatur odio pariatur.', 1, 42),
(69, 'A architecto itaque voluptas.', 10, 695),
(70, 'Quo et quia commodi.', 10, 930),
(71, 'Nemo suscipit et ipsa.', 2, 832),
(72, 'Optio molestiae omnis itaque.', 5, 192),
(73, 'Aut earum et nisi.', 2, 137),
(74, 'Temporibus excepturi dignissimos accusantium.', 7, 851),
(75, 'Nihil soluta inventore accusantium.', 4, 781),
(76, 'Repellendus nostrum molestiae dolorem.', 10, 326),
(77, 'Nulla numquam sint consectetur.', 8, 116),
(78, 'Nihil et eveniet tempora.', 1, 830),
(79, 'Quia tempora vitae suscipit.', 4, 664),
(80, 'Sunt quos maiores dolores.', 10, 175),
(81, 'Adipisci non enim quo.', 7, 225),
(82, 'Mollitia quia est perspiciatis.', 7, 137),
(83, 'Molestiae et eaque doloremque.', 10, 330),
(84, 'Suscipit aut provident adipisci.', 6, 15),
(85, 'Eligendi culpa quos dolore.', 5, 737),
(86, 'Quos qui natus voluptates.', 8, 508),
(87, 'Asperiores amet consequatur est.', 5, 559),
(88, 'Amet unde velit sed.', 6, 224),
(89, 'Repellendus commodi odio in.', 5, 637),
(90, 'Aut recusandae quia ea.', 2, 966),
(91, 'Voluptatibus quia dolorem perferendis.', 6, 735),
(92, 'Nisi quod velit dolores.', 5, 828),
(93, 'Quam aut et eos.', 7, 108),
(94, 'Aut voluptate nihil fugiat.', 1, 271),
(95, 'Neque recusandae sed sint.', 4, 192),
(96, 'Et deserunt in similique.', 2, 60),
(97, 'Sed quis est ut.', 8, 315),
(98, 'Dignissimos qui quae quod.', 1, 994),
(99, 'Dolor cumque blanditiis est.', 4, 135),
(100, 'Voluptatum molestiae reiciendis optio.', 2, 9),
(101, 'Dolorum velit rerum ex.', 2, 838),
(102, 'Ratione dolor optio est.', 5, 200),
(103, 'Culpa provident itaque veritatis.', 2, 112),
(104, 'Molestias officiis id incidunt.', 6, 53),
(105, 'Qui voluptatum fuga impedit.', 10, 454),
(106, 'Voluptatem et sint cupiditate.', 2, 366),
(107, 'Est soluta quas distinctio.', 8, 255),
(108, 'Quis ex totam occaecati.', 1, 267),
(109, 'Sunt mollitia nihil repellendus.', 4, 411),
(110, 'Et est similique occaecati.', 1, 441),
(111, 'Et in accusantium ea.', 8, 216),
(112, 'Dignissimos consectetur est fugit.', 5, 693),
(113, 'Tempore ducimus rerum et.', 6, 953),
(114, 'Quia dolorum ipsa quis.', 4, 75),
(115, 'Repellat et molestiae molestias.', 4, 59),
(116, 'Animi quasi esse sunt.', 10, 580),
(117, 'Incidunt laboriosam iure ullam.', 1, 920),
(118, 'Asperiores rerum explicabo unde.', 10, 402),
(119, 'Numquam magnam autem odit.', 4, 676),
(120, 'Quo a suscipit qui.', 10, 255),
(121, 'Vel aut nihil neque.', 1, 649),
(122, 'Eius laboriosam nulla architecto.', 6, 352),
(123, 'Sint quis dolorem a.', 10, 979),
(124, 'Culpa dolor nisi rem.', 10, 678),
(125, 'Voluptatem ut natus neque.', 7, 814),
(126, 'Reprehenderit amet velit deleniti.', 8, 981),
(127, 'Architecto officia at in.', 7, 283),
(128, 'Nemo molestiae minus expedita.', 8, 917),
(129, 'Quasi enim quisquam impedit.', 2, 823),
(130, 'Magni nemo laborum illo.', 4, 355),
(131, 'Aut enim ut sed.', 2, 536),
(132, 'Nihil distinctio eius accusamus.', 6, 233),
(133, 'Consequatur nihil odit iste.', 4, 165),
(134, 'Qui quae provident quia.', 1, 231),
(135, 'Magnam dolorem rem veniam.', 4, 442),
(136, 'Soluta vitae aperiam non.', 7, 995),
(137, 'Aut doloribus fugiat consequuntur.', 5, 148),
(138, 'Quisquam iusto minus sit.', 7, 27),
(139, 'Beatae commodi et harum.', 10, 216),
(140, 'Dolorum deserunt dolorem beatae.', 8, 179),
(141, 'Possimus incidunt et eius.', 2, 833),
(142, 'Amet assumenda voluptatem libero.', 1, 662),
(143, 'Consequatur voluptatem sint autem.', 5, 324),
(144, 'Eos itaque non ea.', 2, 738),
(145, 'Et impedit aut in.', 7, 68),
(146, 'Repellat distinctio laboriosam deserunt.', 7, 6),
(147, 'Blanditiis iste qui eaque.', 10, 321),
(148, 'Eaque ut voluptates est.', 4, 413),
(149, 'Quaerat est sapiente accusamus.', 8, 811),
(150, 'A dolor voluptatem pariatur.', 2, 691),
(151, 'Magnam repudiandae dolorum sunt.', 4, 409),
(152, 'Cumque occaecati amet quia.', 1, 243),
(153, 'Nihil sint quo quisquam.', 1, 825),
(154, 'Sunt quas quos dolores.', 5, 483),
(155, 'Itaque consequatur officia minima.', 10, 198),
(156, 'Tempora molestiae velit inventore.', 1, 891),
(157, 'Et magnam voluptate quas.', 8, 515),
(158, 'Et nostrum doloribus eligendi.', 2, 534),
(159, 'Quos sit modi voluptatem.', 4, 871),
(160, 'Ut nostrum quia et.', 2, 337),
(161, 'Et labore minima assumenda.', 8, 598),
(162, 'Magnam quo rerum quasi.', 10, 527),
(163, 'Dolor aperiam qui est.', 2, 690),
(164, 'Incidunt eos quas voluptate.', 4, 428),
(165, 'Repudiandae nulla voluptatem et.', 9, 387),
(166, 'Tenetur sed eveniet animi.', 9, 394),
(167, 'Et eos rerum et.', 9, 394),
(168, 'Reiciendis velit consectetur ab.', 9, 387),
(169, 'Adipisci distinctio culpa quam.', 9, 394),
(170, 'Illum et accusantium similique.', 9, 387);

--Now let's write and execute the required query -----------------------------------------------------------------------
SELECT category_id, category, title, views, post_id FROM
    (SELECT
        categories.id AS category_id,
        categories.category,
        posts.title,
        posts.views,
        posts.id AS post_id,
        RANK() OVER (PARTITION BY category_id ORDER BY views DESC, posts.id) AS r_num
    FROM categories
        LEFT JOIN posts ON categories.id = posts.category_id
    ORDER BY categories.category, posts.views DESC) AS t1
    WHERE t1.r_num <= 2;

--Result, solution -----------------------------------------------------------------------------------------------------
/*
+-----------+------------+------------------------------------------+-----+-------+
|category_id|category    |title                                     |views|post_id|
+-----------+------------+------------------------------------------+-----+-------+
|5          |aut         |Blanditiis voluptas molestiae consequatur.|980  |12     |
|5          |aut         |Ea porro ea incidunt.                     |957  |31     |
|9          |deserunt    |Tenetur sed eveniet animi.                |394  |166    |
|9          |deserunt    |Et eos rerum et.                          |394  |167    |
|7          |facilis     |Soluta vitae aperiam non.                 |995  |136    |
|7          |facilis     |Et corporis vel qui.                      |942  |65     |
|2          |fugiat      |Aut recusandae quia ea.                   |966  |90     |
|2          |fugiat      |Dolorum velit rerum ex.                   |838  |101    |
|8          |ipsum       |Reprehenderit amet velit deleniti.        |981  |126    |
|8          |ipsum       |Nemo molestiae minus expedita.            |917  |128    |
|6          |perspiciatis|Tempore ducimus rerum et.                 |953  |113    |
|6          |perspiciatis|Dicta ut quod non.                        |938  |45     |
|1          |qui         |Suscipit culpa ipsa nobis.                |997  |59     |
|1          |qui         |Dignissimos qui quae quod.                |994  |98     |
|3          |quidem      |null                                      |null |null   |
|10         |soluta      |Sint quis dolorem a.                      |979  |123    |
|10         |soluta      |Quo et quia commodi.                      |930  |70     |
|4          |voluptate   |Et reiciendis vitae ad.                   |900  |3      |
|4          |voluptate   |Quos sit modi voluptatem.                 |871  |159    |
+-----------+------------+------------------------------------------+-----+-------+
 */
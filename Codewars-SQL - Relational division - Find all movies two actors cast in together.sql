/* #SQL #Fundamentals #Databases

    <5 kyu> Relational division: Find all movies two actors cast in together

    Description:
Given [film_actor] and [film] tables from the DVD Rental sample database find all movies both Sidney Crowe (actor_id = 105)
and Salma Nolte (actor_id = 122) cast in together and order the result set alphabetically.

    film schema -------------------------------------
 Column     | Type                        | Modifiers
------------+-----------------------------+----------
title       | character varying(255)      | not null
film_id     | smallint                    | not null

    film_actor schema -------------------------------
 Column     | Type                        | Modifiers
------------+-----------------------------+----------
actor_id    | smallint                    | not null
film_id     | smallint                    | not null
last_update | timestamp without time zone | not null

    actor schema ------------------------------------
 Column     | Type                        | Modifiers
------------+-----------------------------+----------
actor_id    | integer                     | not null
first_name  | character varying(45)       | not null
last_name   | character varying(45)       | not null
last_update | timestamp without time zone | not null

The desired output:
title
-------------
Film Title 1
Film Title 2
...

title - Film title
*/

--To complete the task, create a temporary table film, film_actor actor ------------------------------------------------
CREATE TEMPORARY TABLE film
    (
    film_id smallint NOT NULL,
    title varchar(255) NOT NULL
    );

CREATE TEMPORARY TABLE film_actor
    (
    actor_id smallint NOT NULL, -- 200 in 14 to 42
    film_id smallint NOT NULL, -- 1-15
    last_update timestamp without time zone NOT NULL -- 2006-02-15 10:05:03 +0000	5462
    );

CREATE TEMPORARY TABLE actor
    (
    actor_id smallint NOT NULL,
    first_name varchar(45),
    last_name varchar(45),
    last_update timestamp without time zone NOT NULL
    );
DROP TABLE film;
--To check our code, we will fill the table with a part of the data ----------------------------------------------------
INSERT INTO film (film_id, title) VALUES
(3, 'Adaptation Holes'),
(12, 'Alaska Phantom'),
(15, 'Alien Center'),
(21, 'American Circus'),
(22, 'Amistad Midsummer'),
(29, 'Antitrust Tomatoes'),
(42, 'Artist Coldblooded'),
(43, 'Atlantis Cause'),
(67, 'Berets Agent'),
(76, 'Birdcage Casper'),
(83, 'Blues Instinct'),
(105, 'Bull Shawshank'),
(116, 'Candidate Perdition'),
(141, 'Chicago North'),
(148, 'Chocolate Duck'),
(151, 'Cincinatti Whisperer'),
(154, 'Clash Freddy'),
(157, 'Clockwork Paradise'),
(158, 'Clones Pinocchio'),
(161, 'Clue Grail'),
(166, 'Color Philadelphia'),
(170, 'Command Darling'),
(185, 'Cowboy Doom'),
(186, 'Craft Outfield'),
(198, 'Crystal Breaking'),
(220, 'Deer Virginian'),
(222, 'Desert Poseidon'),
(223, 'Desire Alien'),
(227, 'Details Packer'),
(234, 'Disturbing Scarface'),
(238, 'Doctor Grail'),
(239, 'Dogma Family'),
(245, 'Double Wrath'),
(246, 'Doubtfire Labyrinth'),
(266, 'Dynamite Tarzan'),
(280, 'Empire Malkovich'),
(283, 'Ending Crowds'),
(284, 'Enemy Odds'),
(286, 'Enough Raging'),
(297, 'Extraordinary Conquerer'),
(300, 'Falcon Volume'),
(307, 'Fellowship Autumn'),
(315, 'Finding Anaconda'),
(333, 'Freaky Pocus'),
(338, 'Frisco Forrest'),
(353, 'Gentlemen Stage'),
(363, 'Go Purple'),
(372, 'Graceland Dynamite'),
(377, 'Grease Youth'),
(429, 'Honey Ties'),
(442, 'Hunting Musketeers'),
(446, 'Hysterical Grail'),
(449, 'Identity Lover'),
(470, 'Ishtar Rocketeer'),
(479, 'Jedi Beneath'),
(480, 'Jeepers Wedding'),
(489, 'Juggler Hardly'),
(491, 'Jumping Wrath'),
(494, 'Karate Moon'),
(503, 'Kramer Chocolate'),
(517, 'Lesson Cleopatra'),
(530, 'Lord Arizona'),
(542, 'Lust Lock'),
(558, 'Mannequin Worst'),
(561, 'Mask Peach'),
(576, 'Mighty Luck'),
(577, 'Mile Mulan'),
(589, 'Modern Dorado'),
(593, 'Monterey Labyrinth'),
(606, 'Mummy Creatures'),
(620, 'Nemo Campus'),
(633, 'October Submarine'),
(649, 'Oz Liaisons'),
(654, 'Panky Submarine'),
(658, 'Paris Weekend'),
(666, 'Paycheck Wait'),
(673, 'Personal Ladybugs'),
(686, 'Pluto Oleander'),
(718, 'Rebel Airport'),
(725, 'Requiem Tycoon'),
(730, 'Ridgemont Submarine'),
(750, 'Run Pacific'),
(771, 'Scorpion Apollo'),
(780, 'Sensibility Rear'),
(786, 'Shepherd Midsummer'),
(795, 'Siege Madre'),
(831, 'Spirited Casualties'),
(835, 'Spy Mile'),
(847, 'Stock Glass'),
(858, 'Submarine Bed'),
(860, 'Suicides Silence'),
(864, 'Sundance Invasion'),
(884, 'Terminator Club'),
(885, 'Texas Watch'),
(892, 'Titanic Boondock'),
(893, 'Titans Jerk'),
(906, 'Tramp Others'),
(910, 'Treatment Jekyll'),
(915, 'Truman Crazy'),
(926, 'Untouchables Sunrise'),
(954, 'Wake Jaws'),
(957, 'War Notting'),
(961, 'Wash Heavenly'),
(966, 'Wedding Apollo'),
(988, 'Worker Tarzan'),
(990, 'World Leathernecks'),
(993, 'Wrong Behavior'),
(994, 'Wyoming Storm'),
(998, 'Zhivago Core');

-- We will also fill in the table actor with incomplete data -----------------------------------------------------------------
INSERT INTO actor (actor_id, first_name, last_name, last_update) VALUES
(105, 'Sidney', 'Crowe', '2013-05-26 14:47:57 +0000'),
(121, 'Liza', 'Bergman', '2013-05-26 14:47:57 +0000'),
(122, 'Salma', 'Nolte', '2013-05-26 14:47:57 +0000'),
(123, 'Julianne', 'Dench', '2013-05-26 14:47:57 +0000');

-- Let's add a set of data so that the two actors match ----------------------------------------------------------------
INSERT INTO film_actor (actor_id, film_id, last_update) VALUES
(123, 3, '2006-02-15 10:05:03 +0000'),
(105, 12, '2006-02-15 10:05:03 +0000'),
(105, 15, '2006-02-15 10:05:03 +0000'),
(105, 21, '2006-02-15 10:05:03 +0000'),
(122, 22, '2006-02-15 10:05:03 +0000'),
(105, 29, '2006-02-15 10:05:03 +0000'),
(122, 29, '2006-02-15 10:05:03 +0000'),
(105, 42, '2006-02-15 10:05:03 +0000'),
(123, 43, '2006-02-15 10:05:03 +0000'),
(123, 67, '2006-02-15 10:05:03 +0000'),
(122, 76, '2006-02-15 10:05:03 +0000'),
(122, 83, '2006-02-15 10:05:03 +0000'),
(123, 105, '2006-02-15 10:05:03 +0000'),
(105, 116, '2006-02-15 10:05:03 +0000'),
(121, 141, '2006-02-15 10:05:03 +0000'),
(123, 148, '2006-02-15 10:05:03 +0000'),
(123, 151, '2006-02-15 10:05:03 +0000'),
(121, 154, '2006-02-15 10:05:03 +0000'),
(122, 157, '2006-02-15 10:05:03 +0000'),
(105, 158, '2006-02-15 10:05:03 +0000'),
(122, 158, '2006-02-15 10:05:03 +0000'),
(121, 161, '2006-02-15 10:05:03 +0000'),
(122, 166, '2006-02-15 10:05:03 +0000'),
(121, 170, '2006-02-15 10:05:03 +0000'),
(123, 185, '2006-02-15 10:05:03 +0000'),
(121, 186, '2006-02-15 10:05:03 +0000'),
(121, 198, '2006-02-15 10:05:03 +0000'),
(121, 220, '2006-02-15 10:05:03 +0000'),
(121, 222, '2006-02-15 10:05:03 +0000'),
(123, 223, '2006-02-15 10:05:03 +0000'),
(122, 227, '2006-02-15 10:05:03 +0000'),
(123, 234, '2006-02-15 10:05:03 +0000'),
(122, 238, '2006-02-15 10:05:03 +0000'),
(105, 239, '2006-02-15 10:05:03 +0000'),
(123, 245, '2006-02-15 10:05:03 +0000'),
(123, 246, '2006-02-15 10:05:03 +0000'),
(123, 266, '2006-02-15 10:05:03 +0000'),
(105, 280, '2006-02-15 10:05:03 +0000'),
(105, 283, '2006-02-15 10:05:03 +0000'),
(121, 284, '2006-02-15 10:05:03 +0000'),
(123, 286, '2006-02-15 10:05:03 +0000'),
(121, 297, '2006-02-15 10:05:03 +0000'),
(122, 300, '2006-02-15 10:05:03 +0000'),
(122, 307, '2006-02-15 10:05:03 +0000'),
(105, 315, '2006-02-15 10:05:03 +0000'),
(105, 333, '2006-02-15 10:05:03 +0000'),
(121, 338, '2006-02-15 10:05:03 +0000'),
(121, 353, '2006-02-15 10:05:03 +0000'),
(122, 363, '2006-02-15 10:05:03 +0000'),
(105, 372, '2006-02-15 10:05:03 +0000'),
(105, 377, '2006-02-15 10:05:03 +0000'),
(123, 429, '2006-02-15 10:05:03 +0000'),
(123, 442, '2006-02-15 10:05:03 +0000'),
(123, 446, '2006-02-15 10:05:03 +0000'),
(121, 449, '2006-02-15 10:05:03 +0000'),
(122, 470, '2006-02-15 10:05:03 +0000'),
(121, 479, '2006-02-15 10:05:03 +0000'),
(123, 479, '2006-02-15 10:05:03 +0000'),
(123, 480, '2006-02-15 10:05:03 +0000'),
(122, 489, '2006-02-15 10:05:03 +0000'),
(122, 491, '2006-02-15 10:05:03 +0000'),
(123, 494, '2006-02-15 10:05:03 +0000'),
(123, 503, '2006-02-15 10:05:03 +0000'),
(121, 517, '2006-02-15 10:05:03 +0000'),
(105, 530, '2006-02-15 10:05:03 +0000'),
(123, 530, '2006-02-15 10:05:03 +0000'),
(122, 542, '2006-02-15 10:05:03 +0000'),
(105, 558, '2006-02-15 10:05:03 +0000'),
(105, 561, '2006-02-15 10:05:03 +0000'),
(123, 576, '2006-02-15 10:05:03 +0000'),
(123, 577, '2006-02-15 10:05:03 +0000'),
(123, 589, '2006-02-15 10:05:03 +0000'),
(123, 593, '2006-02-15 10:05:03 +0000'),
(105, 606, '2006-02-15 10:05:03 +0000'),
(122, 620, '2006-02-15 10:05:03 +0000'),
(121, 633, '2006-02-15 10:05:03 +0000'),
(105, 649, '2006-02-15 10:05:03 +0000'),
(122, 649, '2006-02-15 10:05:03 +0000'),
(121, 654, '2006-02-15 10:05:03 +0000'),
(122, 654, '2006-02-15 10:05:03 +0000'),
(121, 658, '2006-02-15 10:05:03 +0000'),
(121, 666, '2006-02-15 10:05:03 +0000'),
(122, 673, '2006-02-15 10:05:03 +0000'),
(105, 686, '2006-02-15 10:05:03 +0000'),
(122, 718, '2006-02-15 10:05:03 +0000'),
(123, 725, '2006-02-15 10:05:03 +0000'),
(123, 730, '2006-02-15 10:05:03 +0000'),
(105, 750, '2006-02-15 10:05:03 +0000'),
(121, 771, '2006-02-15 10:05:03 +0000'),
(121, 780, '2006-02-15 10:05:03 +0000'),
(123, 786, '2006-02-15 10:05:03 +0000'),
(105, 795, '2006-02-15 10:05:03 +0000'),
(122, 795, '2006-02-15 10:05:03 +0000'),
(105, 831, '2006-02-15 10:05:03 +0000'),
(105, 835, '2006-02-15 10:05:03 +0000'),
(121, 847, '2006-02-15 10:05:03 +0000'),
(105, 858, '2006-02-15 10:05:03 +0000'),
(123, 860, '2006-02-15 10:05:03 +0000'),
(105, 864, '2006-02-15 10:05:03 +0000'),
(121, 884, '2006-02-15 10:05:03 +0000'),
(121, 885, '2006-02-15 10:05:03 +0000'),
(123, 892, '2006-02-15 10:05:03 +0000'),
(105, 893, '2006-02-15 10:05:03 +0000'),
(105, 906, '2006-02-15 10:05:03 +0000'),
(105, 910, '2006-02-15 10:05:03 +0000'),
(105, 915, '2006-02-15 10:05:03 +0000'),
(123, 926, '2006-02-15 10:05:03 +0000'),
(105, 954, '2006-02-15 10:05:03 +0000'),
(122, 957, '2006-02-15 10:05:03 +0000'),
(122, 961, '2006-02-15 10:05:03 +0000'),
(121, 966, '2006-02-15 10:05:03 +0000'),
(123, 988, '2006-02-15 10:05:03 +0000'),
(105, 990, '2006-02-15 10:05:03 +0000'),
(105, 993, '2006-02-15 10:05:03 +0000'),
(105, 994, '2006-02-15 10:05:03 +0000'),
(122, 998, '2006-02-15 10:05:03 +0000');

--Now let's write and execute the required query -----------------------------------------------------------------------
SELECT fm.title AS title
  FROM film AS fm
    INNER JOIN film_actor AS fa ON fm.film_id = fa.film_id
    INNER JOIN actor AS ac ON ac.actor_id = fa.actor_id
WHERE ac.actor_id = 105 OR ac.actor_id = 122
GROUP BY fm.title
HAVING COUNT(fm.title) > 1
ORDER BY fm.title;

--Result, solution -----------------------------------------------------------------------------------------------------
/*
+------------------+
|title             |
+------------------+
|Antitrust Tomatoes|
|Clones Pinocchio  |
|Oz Liaisons       |
|Siege Madre       |
+------------------+
*/

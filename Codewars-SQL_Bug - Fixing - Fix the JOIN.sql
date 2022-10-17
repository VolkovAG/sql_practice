/* #SQL #Fundamentals

    <6 kyu> SQL Bug Fixing: Fix the JOIN

    Description:
Oh no! Timmys been moved into the database divison of his software company but as we know
Timmy loves making mistakes. Help Timmy keep his job by fixing his query...

Timmy works for a statistical analysis company and has been given a task of calculating the
highest average salary for a given job, the sample is compiled of 100 applicants each with a
job and a salary. Timmy must display each unique job, the total average salary, the total people
and the total salary and order by highest average salary. Timmy has some bugs in his query, help
Timmy fix his query so he can keep his job!

  people table schema
    id
    name

job table schema
    id
    people_id
    job_title
    salary

resultant table schema
    job_title (unique)
    average_salary (float, 2 dp)
    total_people (int)
    total_salary (float, 2 dp)

Timmy solution:
  SELECT
  j.jobs_title,
  SUM(j.salary) / COUNT(p) as average_salarys,
  COUNT(p.id) as total_peoples,
  SUM(j.salary),2 as total_salarys
  FROM people p
    JOIN job j
  GROUP BY j.job_title
  ORDER BY total_salarys
*/

--To complete the task, create a temporary table people, job------------------------------------------------------------
CREATE TEMPORARY TABLE people (
    id int NOT NULL,
    name varchar(40));

CREATE TEMPORARY TABLE job (
    id int NOT NULL ,
    people_id int NOT NULL ,
    job_title varchar(40),
    salary int);

-- Now let's fill them with records ------------------------------------------------------------------------------------
INSERT INTO people (id, name) VALUES
(1, 'Alanna Satterfield'),
(2, 'Markus Reynolds'),
(3, 'Prof. Lewis Upton'),
(4, 'Clint Harvey'),
(5, 'Adriene Kovacek'),
(6, 'Pinkie Herman'),
(7, 'Deana Jenkins'),
(8, 'Lela Feest'),
(9, 'Rufus Kunze'),
(10, 'Dimple Macejkovic'),
(11, 'Dwight Thiel'),
(12, 'The Hon. Jasper Lindgren'),
(13, 'Waldo Rau'),
(14, 'Rudy Bernier'),
(15, 'Mickey Labadie'),
(16, 'Libby Nitzsche'),
(17, 'Curtis Davis'),
(18, 'Chester Lindgren'),
(19, 'Thurman Waelchi'),
(20, 'Carrol Champlin PhD'),
(21, 'Mr. Sung Murray'),
(22, 'Asia Schuster'),
(23, 'Msgr. Nelia Collier'),
(24, 'Augustus O Reilly'),
(25, 'Kasey Heathcote'),
(26, 'Mervin Jast'),
(27, 'Miss Blondell Wehner'),
(28, 'Mr. Bernarda Dicki'),
(29, 'The Hon. Clare Brakus'),
(30, 'Keisha Schmidt'),
(31, 'Sherryl Stoltenberg'),
(32, 'Lane Christiansen'),
(33, 'Shela Strosin'),
(34, 'Megan Murazik'),
(35, 'Mafalda Gerlach'),
(36, 'Zetta Roberts'),
(37, 'Rhett Rogahn'),
(38, 'Margurite Moore'),
(39, 'Kristyn Stamm'),
(40, 'Marin Emmerich'),
(41, 'Billy Zulauf V'),
(42, 'Paris Hilpert PhD'),
(43, 'Erwin VonRueden'),
(44, 'The Hon. Xavier Schuster'),
(45, 'Louis Flatley'),
(46, 'Forest Kihn'),
(47, 'Oswaldo Corkery'),
(48, 'Sherika Spencer'),
(49, 'Isreal Zulauf I'),
(50, 'Ms. Honey Schneider'),
(51, 'Jonnie Dare DO'),
(52, 'Prof. Ricardo Cronin'),
(53, 'Prof. Enoch Paucek'),
(54, 'Kellie Bradtke'),
(55, 'Prof. Marlin Haley'),
(56, 'Korey Hirthe'),
(57, 'Damion Kemmer'),
(58, 'Dennis Ryan'),
(59, 'Florencio Buckridge'),
(60, 'Kellie Doyle'),
(61, 'Prof. Seth Hackett'),
(62, 'The Hon. Linnea Weimann'),
(63, 'Lorraine White'),
(64, 'Brady Dietrich'),
(65, 'Maxwell Kemmer'),
(66, 'Kia Ortiz'),
(67, 'Kimi Lynch'),
(68, 'Keven Collier'),
(69, 'Adrian Runolfsdottir'),
(70, 'Lucila Homenick'),
(71, 'Danielle Botsford'),
(72, 'Margie Hudson'),
(73, 'Napoleon Rutherford Esq.'),
(74, 'Fe Hudson'),
(75, 'Lucio Windler'),
(76, 'Pres. Sammie Boyer'),
(77, 'Rep. Jordon Kerluke'),
(78, 'Lea Schaden'),
(79, 'Mariam Walter'),
(80, 'Alvin Bayer Ret.'),
(81, 'Loren Gulgowski'),
(82, 'Darius Labadie VM'),
(83, 'Steven Skiles PhD'),
(84, 'Stacy Nader'),
(85, 'Marlana Conroy V'),
(86, 'Mr. Marissa Vandervort'),
(87, 'Alison Satterfield'),
(88, 'Rodger Fisher'),
(89, 'The Hon. Tyisha Wunsch'),
(90, 'Chester West'),
(91, 'Wilhemina Hahn'),
(92, 'Lavelle Welch'),
(93, 'Earlean Muller'),
(94, 'Miss Marquis Hermann'),
(95, 'Miss Sergio Beahan'),
(96, 'Lincoln Champlin'),
(97, 'Enola Bergstrom'),
(98, 'Martin Schiller'),
(99, 'Kris Spinka'),
(100, 'Julian MacGyver');

INSERT INTO job (id, people_id, job_title, salary) VALUES
(1, 1, 'designer', 0.16969939e5),
(2, 2, 'painter', 0.14733491e5),
(3, 3, 'scientist', 0.49595416e5),
(4, 4, 'web developer', 0.99440862e5),
(5, 5, 'waiter', 0.11505039e5),
(6, 6, 'banker', 0.88815727e5),
(7, 7, 'traffic warden', 0.67398356e5),
(8, 8, 'doctor', 0.68412222e5),
(9, 9, 'bartender', 0.18041271e5),
(10, 10, 'newsreader', 0.72703568e5),
(11, 11, 'dietician', 0.34817697e5),
(12, 12, 'barber', 0.32227887e5),
(13, 13, 'coach', 0.63002369e5),
(14, 14, 'physicist', 0.70061972e5),
(15, 15, 'engineer', 0.91243502e5),
(16, 16, 'factory worker', 0.65000211e5),
(17, 17, 'shop assistant', 0.80008198e5),
(18, 18, 'mechanic', 0.19179411e5),
(19, 19, 'newsreader', 0.63248408e5),
(20, 20, 'chef', 0.18247941e5),
(21, 21, 'human resources', 0.24141714e5),
(22, 22, 'actress', 0.90840088e5),
(23, 23, 'judge', 0.37226083e5),
(24, 24, 'accountant', 0.48046164e5),
(25, 25, 'doctor', 0.11931379e5),
(26, 26, 'veterinary doctor', 0.80747298e5),
(27, 27, 'postman', 0.28155682e5),
(28, 28, 'secretary', 0.28335228e5),
(29, 29, 'engineer', 0.36050518e5),
(30, 30, 'pharmacist', 0.41960287e5),
(31, 31, 'barber', 0.66928636e5),
(32, 32, 'judge', 0.19696759e5),
(33, 33, 'editor', 0.75571624e5),
(34, 34, 'judge', 0.38418312e5),
(35, 35, 'hairdresser', 0.94583853e5),
(36, 36, 'businessman', 0.24713356e5),
(37, 37, 'interpreter', 0.53685115e5),
(38, 38, 'secretary', 0.64404143e5),
(39, 39, 'librarian', 0.33784474e5),
(40, 40, 'teacher', 0.53038067e5),
(41, 41, 'butcher', 0.87889718e5),
(42, 42, 'politician', 0.88218763e5),
(43, 43, 'chef', 0.67887054e5),
(44, 44, 'accountant', 0.16847764e5),
(45, 45, 'carpenter', 0.28116433e5),
(46, 46, 'politician', 0.42651816e5),
(47, 47, 'editor', 0.16250449e5),
(48, 48, 'shop assistant', 0.77744508e5),
(49, 49, 'lawyer', 0.36027136e5),
(50, 50, 'actor', 0.10976762e5),
(51, 51, 'barber', 0.96983107e5),
(52, 52, 'secretary', 0.76355394e5),
(53, 53, 'carpenter', 0.39833055e5),
(54, 54, 'journalist', 0.83162961e5),
(55, 55, 'librarian', 0.64474513e5),
(56, 56, 'mechanic', 0.93823074e5),
(57, 57, 'editor', 0.15416383e5),
(58, 58, 'fisherman', 0.86251991e5),
(59, 59, 'shop assistant', 0.96352101e5),
(60, 60, 'translator', 0.56786259e5),
(61, 61, 'economist', 0.12234521e5),
(62, 62, 'gardener', 0.15707778e5),
(63, 63, 'builder', 0.36972692e5),
(64, 64, 'biologist', 0.96530737e5),
(65, 65, 'farmer', 0.52485383e5),
(66, 66, 'photographer', 0.14969799e5),
(67, 67, 'photographer', 0.63382013e5),
(68, 68, 'newsreader', 0.99312319e5),
(69, 69, 'chemist', 0.81375771e5),
(70, 70, 'editor', 0.32431106e5),
(71, 71, 'actress', 0.23917762e5),
(72, 72, 'photographer', 0.15992913e5),
(73, 73, 'bartender', 0.93277068e5),
(74, 74, 'accountant', 0.95848642e5),
(75, 75, 'pharmacist', 0.91429188e5),
(76, 76, 'shop assistant', 0.42455294e5),
(77, 77, 'electrician', 0.53571477e5),
(78, 78, 'economist', 0.96083743e5),
(79, 79, 'teacher', 0.14544213e5),
(80, 80, 'photographer', 0.94331299e5),
(81, 81, 'developer', 0.63445969e5),
(82, 82, 'banker', 0.48487655e5),
(83, 83, 'physicist', 0.34692745e5),
(84, 84, 'nurse', 0.51016041e5),
(85, 85, 'librarian', 0.13766267e5),
(86, 86, 'builder', 0.80094161e5),
(87, 87, 'bartender', 0.49225022e5),
(88, 88, 'air traffic controller', 0.36079946e5),
(89, 89, 'lawyer', 0.44318741e5),
(90, 90, 'actress', 0.45175141e5),
(91, 91, 'pharmacist', 0.35772383e5),
(92, 92, 'web developer', 0.93135549e5),
(93, 93, 'agriculturist', 0.36259753e5),
(94, 94, 'model', 0.39119354e5),
(95, 95, 'coach', 0.84884666e5),
(96, 96, 'newsreader', 0.16086496e5),
(97, 97, 'attorney at law', 0.94862275e5),
(98, 98, 'artist', 0.50694088e5),
(99, 99, 'gardener', 0.17988467e5),
(100, 100, 'developer', 0.88200185e5);

--Now let's write and execute the required query -----------------------------------------------------------------------
SELECT
    j.job_title,
    ROUND(AVG(j.salary), 2)::float as average_salary,
    COUNT(p.id) as total_people,
    ROUND(SUM(j.salary), 2)::float as total_salary
    FROM people p
        INNER JOIN job j ON p.id = j.people_id
    GROUP BY j.job_title
    ORDER BY average_salary DESC;

--Result, solution -----------------------------------------------------------------------------------------------------
/*
+-----------------+--------------+------------+------------+
|job_title        |average_salary|total_people|total_salary|
+-----------------+--------------+------------+------------+
|biologist        |96531         |1           |96531       |
|web developer    |96288.5       |2           |192577      |
|attorney at law  |94862         |1           |94862       |
|hairdresser      |94584         |1           |94584       |
|butcher          |87890         |1           |87890       |
|fisherman        |86252         |1           |86252       |
|journalist       |83163         |1           |83163       |
|chemist          |81376         |1           |81376       |
|veterinary doctor|80747         |1           |80747       |
|developer        |75823         |2           |151646      |
|...              |...           |...         |...         |
+-----------------+--------------+------------+------------+
*/
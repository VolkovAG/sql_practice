/* #SQL #Algorithms (WITH/UNION/JOIN)
    <4 kyu> Total items belonging to the categories on all tree levels
    Description:

For each category in the tree-like categories table, calculate how many records in the items table belong to it and its
parent categories across all the tree levels.

Notes
    Items can only belong to the leaves of the category tree
    There will be multiple roots for separate category trees
    Order the result by the id column

Input tables
-----------------------------------
|   Table    |   Column    | Type |
|------------+-------------+------|
| categories | id          | int  |
|            | parent      | int  |
|------------+-------------+------|
| items      | id          | int  |
|            | category_id | int  |
-----------------------------------

Output table
------------------
| Column | Type  |
|--------+-------|
| id     | int   |
| total  | int   |
------------------

Example
Category tree:
---(1)             [(3 + 6) items]
    |
    |---(2)        [3 items]
    |
    |---(3)        [(5 + 1 + 0) items]
         |
         |---(4)   [5 items]
         |
         |---(5)   [1 item]
         |
         |---(6)   [0 items]

Resulting table:
  id   | total
-------+-------
   1   |   9
   2   |   3
   3   |   6
   4   |   5
   5   |   1
   6   |   0
 */

--To complete the task, create a temporary table categories, items -----------------------------------------------------
CREATE TEMPORARY TABLE categories (
    id int,
    parent int);

CREATE TEMPORARY TABLE items (
    id int,
    category_id int);

-- Now let's fill them with records -----------------------------------------------------------------------------------
INSERT INTO categories (id, parent) VALUES
(1, NULL),
(2, 1),
(3, 1),
(4, 2),
(5, 2),
(6, 3),
(7, 3),
(8, 3),
(9, 4),
(10, 4),
(11, 4),
(12, 4),
(13, 6),
(14, 6),
(15, 8),
(16, 8),
(17, 8),
(18, 8),
(19, 8),
(20, 17),
(21, 17),
(22, 20),
(23, 20),
(24, NULL),
(25, 24),
(26, 24);

INSERT INTO items (id, category_id) VALUES
(1, 5),
(2, 5),
(3, 5),
(4, 5),
(5, 5),
(6, 5),
(7, 7),
(8, 7),
(9, 9),
(10, 9),
(11, 9),
(12, 9),
(13, 9),
(14, 10),
(15, 10),
(16, 10),
(17, 10),
(18, 11),
(19, 11),
(20, 11),
(21, 11),
(22, 13),
(23, 14),
(24, 16),
(25, 16),
(26, 18),
(27, 18),
(28, 18),
(29, 21),
(30, 21),
(31, 21),
(32, 21),
(33, 21),
(34, 22),
(35, 22),
(36, 22),
(37, 22),
(38, 25),
(39, 25),
(40, 25),
(41, 25),
(42, 25),
(43, 25),
(44, 25),
(45, 25),
(46, 25),
(47, 25),
(48, 25),
(49, 25),
(50, 25),
(51, 25),
(52, 25),
(53, 25),
(54, 25),
(55, 25),
(56, 25),
(57, 25),
(58, 26),
(59, 26),
(60, 26),
(61, 26),
(62, 26);

--Now let's write and execute the required query -----------------------------------------------------------------------
WITH RECURSIVE temp (id, parent, count)
    AS (
        SELECT
            t1.id,
            t1.parent,
            (SELECT COUNT(i.id) FROM items AS i WHERE i.category_id = t1.id) AS count
        FROM categories AS t1
        ), t2
    AS (
        SELECT
            id,
            parent,
            count
        FROM temp
        WHERE id NOT IN (SELECT parent FROM categories WHERE parent IS NOT NULL)
        UNION ALL
        SELECT
            temp.id,
            temp.parent,
            temp.count + t2.count AS count
        FROM t2
            INNER JOIN temp ON t2.parent = temp.id
        )
    SELECT
        id,
        SUM(count) AS total
    FROM t2
    GROUP BY id
    ORDER BY id;

--Result, solution -----------------------------------------------------------------------------------------------------
/*
 +--+-----+
|id|total|
+--+-----+
|1 |37   |
|2 |19   |
|3 |18   |
|4 |13   |
|5 |6    |
|6 |2    |
|7 |2    |
|8 |14   |
|9 |5    |
|10|4    |
|11|4    |
|12|0    |
|13|1    |
|14|1    |
|15|0    |
|16|2    |
|17|9    |
|18|3    |
|19|0    |
|20|4    |
|21|5    |
|22|4    |
|23|0    |
|24|25   |
|25|20   |
|26|5    |
+--+-----+
 */
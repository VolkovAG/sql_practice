/*Task

Given the database where users are stored in JSON format, fetch the records splitting the data into separate columns.

Notes
    The private field determines whether the user's email address should be publicly visible
    If the profile is private, email_address should equal "Hidden"
    The users may have multiple email addresses
    If no email addresses are provided, email_address should equal "None"
    If there're multiple email addresses, the first one should be shown
    The date_of_birth is in the yyyy-mm-dd format
    The age fields represents the user's age in years
    Order the result by the first_name, and last_name columns

Input table
-------------------------
| Table | Column | Type |
|-------+--------+------|
| users | id     | int  |
|       | data   | json |
-------------------------

JSON object format
--------------------------------------
|     Field       |       Type       |
|-----------------+------------------|
| first_name      | string           |
| last_name       | string           |
| date_of_birth   | string           |
| email_addresses | array of strings |
| private         | boolean          |
--------------------------------------

Output table
------------------------
|    Column     | Type |
|---------------+------|
| first_name    | text |
| last_name     | text |
| age           | int  |
| email_address | text |
------------------------
 */

--To complete the task, create a temporary table users -----------------------------------------------------------------
CREATE TEMPORARY TABLE users (
    id int NOT NULL,
    data json NOT NULL);

-- Now let's fill them with json data ----------------------------------------------------------------------------------
INSERT INTO users (id, data) VALUES
    (1, '{"first_name":"Ben","last_name":"Williams","date_of_birth":"1997-08-04","email_addresses":["ben.williams14825@domain.com"],"private":false}'),
    (2, '{"first_name":"John","last_name":"Doe","date_of_birth":"1995-06-17","email_addresses":["john-doe-68245@domain.com"],"private":true}'),
    (3, '{"first_name":"Nathan","last_name":"Smith","date_of_birth":"1993-12-20","email_addresses":["nathan_smith@domain.com","nathan_smith_1993@domain.com"],"private":false}'),
    (4, '{"first_name":"Stewart","last_name":"Brown","date_of_birth":"1999-02-28","email_addresses":[],"private":false}');

--Now let's write and execute the required query -----------------------------------------------------------------------
SELECT
  data->>'first_name' AS first_name,
  data->>'last_name' AS last_name,
  date_part('year', AGE(now(), (data->>'date_of_birth')::date))::integer AS age,
  CASE
    WHEN data->>'private' = 'true' THEN 'Hidden'
    WHEN data->>'private' = 'false' AND data#>>'{email_addresses, 0}' IS NULL THEN 'None'
    ELSE data#>>'{email_addresses, 0}'
  END AS email_address
FROM users
ORDER BY first_name, last_name;

--Result, solution -----------------------------------------------------------------------------------------------------
/*
+----------+---------+---+----------------------------+
|first_name|last_name|age|email_address               |
+----------+---------+---+----------------------------+
|Ben       |Williams |25 |ben.williams14825@domain.com|
|John      |Doe      |27 |Hidden                      |
|Nathan    |Smith    |28 |nathan_smith@domain.com     |
|Stewart   |Brown    |23 |None                        |
+----------+---------+---+----------------------------+
*/
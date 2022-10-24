/* #SQL #Fundamentals

    <7 kyu> SQL Basics: Up and Down

    Description:
Given a table of random numbers as follows:

numbers table schema
    id
    number1
    number2

Your job is to return table with similar structure and headings, where if the sum of a column is odd, the column shows
the minimum value for that column, and when the sum is even, it shows the max value. You must use a case statement.

output table schema
    number1
    number2

*/
--To complete the task, create a temporary people table ----------------------------------------------------------------
CREATE TEMPORARY TABLE numbers
    (
    id SERIAL,
    number1 int,
    number2 int
    );

-- Now let''s fill them with records -----------------------------------------------------------------------------------
INSERT INTO numbers (number1, number2)
    SELECT
        trunc(random()*100000+1),
        trunc(random()*900000+1)
    FROM generate_series(0,50,1) as i;

--Now let's write and execute the required query -----------------------------------------------------------------------
SELECT number1, number2 FROM
    (SELECT
        CASE
            WHEN mod(SUM(number1) OVER (),2) = 0 THEN MAX(number1) OVER () ELSE MIN(number1) OVER ()
        END AS number1,
        CASE
            WHEN mod(SUM(number2) OVER (),2) = 0 THEN MAX(number2) OVER () ELSE MIN(number2) OVER ()
        END AS number2
    FROM numbers
    ORDER BY number1) t1
GROUP BY number1, number2;

--Result, solution -----------------------------------------------------------------------------------------------------
/*
+-------+-------+
|number1|number2|
+-------+-------+
|95211  |893654 |
+-------+-------+
*/
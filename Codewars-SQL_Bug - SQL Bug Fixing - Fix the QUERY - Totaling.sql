/* Task - SQL Bug Fixing: Fix the QUERY - Totaling / #SQL #Fundamentals #Data Science

Oh no! Timmys been moved into the database divison of his software company but as we know Timmy loves making mistakes.
Help Timmy keep his job by fixing his query...

Timmy works for a statistical analysis company and has been given a task of totaling the number of sales on a given day
grouped by each department name and then each day.

Resultant table:
    day (type: date) {group by} [order by asc]
    department (type: text) {group by} [In a real world situation it is bad practice to name a column after a table]
    sale_count (type: int)

Tables and relationship below: https://imgur.com/kBkwsbi
*/

--To complete the task, we will create a temporary table department, sale-----------------------------------------------
CREATE TEMPORARY TABLE department (
    id int NOT NULL,
    name varchar(40));

CREATE TEMPORARY TABLE sale (
    id BIGSERIAL,
    department_id int,
    product_id int,
    employee_id int,
    transaction_date timestamp);

-- Now let''s fill them with records -----------------------------------------------------------------------------------
INSERT INTO department (id, name) VALUES
    (1, 'Shoes'),
    (2, 'Clothing'),
    (3, 'Jewelry'),
    (4, 'Tools'),
    (5, 'Home');

-- let's create generated records for this table -----------------------------------------------------------------------
INSERT INTO sale (department_id, product_id, employee_id, transaction_date)
    SELECT  trunc(random() * 5 + 1),
            generate_series(1, 50, 1),
            trunc(random() * 10 + 1),
            (select '2022-01-01'::timestamp + make_interval(0, 0, 0, i) as gs) -- генерируем дату транзакций чтобы была больше месяца
            FROM generate_series(0, 100, 1) as i;

--Now let's write and execute the required query -----------------------------------------------------------------------
    SELECT
    s.transaction_date::date AS day,
    d.name AS department,
    COUNT(s.id) AS sale_count
    FROM sale s
      INNER JOIN department d ON d.id = s.department_id
    GROUP BY day, department
    ORDER BY day, department;

--Result, solution -----------------------------------------------------------------------------------------------------
/*
+----------+----------+----------+
|day       |department|sale_count|
+----------+----------+----------+
|2022-01-01|Clothing  |11        |
|2022-01-01|Home      |14        |
|2022-01-01|Jewelry   |9         |
|2022-01-01|Shoes     |10        |
|2022-01-01|Tools     |6         |
|2022-01-02|Clothing  |10        |
|2022-01-02|Home      |10        |
|2022-01-02|Jewelry   |17        |
|2022-01-02|Shoes     |6         |
|2022-01-02|Tools     |7         |
+----------+----------+----------+
*/
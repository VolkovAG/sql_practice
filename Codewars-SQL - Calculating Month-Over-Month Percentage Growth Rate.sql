/* #SQL #Databases

    <4 kyu> Calculating Month-Over-Month Percentage Growth Rate

    Description:
Given a posts table that contains a created_at timestamp column write a query that returns a first date of the month,
a number of posts created in a given month and a month-over-month growth rate.

The resulting set should be ordered chronologically by date.

Note:
    percent growth rate can be negative
    percent growth rate should be rounded to one digit after the decimal point and immediately followed by a percent
symbol "%". See the desired output below for the reference.

Desired Output

The resulting set should look similar to the following:
date       | count | percent_growth
-----------+-------+---------------
2016-02-01 |   175 |           null
2016-03-01 |   338 |          93.1%
2016-04-01 |   345 |           2.1%
2016-05-01 |   295 |         -14.5%
2016-06-01 |   330 |          11.9%
...

date - (DATE) a first date of the month
count - (INT) a number of posts in a given month
percent_growth - (TEXT) a month-over-month growth rate expressed in percents
*/

--To complete the task, create a temporary people table ----------------------------------------------------------------
CREATE TEMPORARY TABLE posts (
    id BIGSERIAL,
    created_at timestamp,
    posts_id int);

-- let's create generated >14'000 records for this table posts ---------------------------------------------------------
INSERT INTO posts (created_at, posts_id)
    SELECT  (select '2021-01-01 00:00:00 +0000'::timestamp + make_interval(0, 0, trunc(random()*25+1)::int, i) as gs),
            generate_series(1, trunc(random()*50+5)::int, 1)
    FROM generate_series(0, 500, 1) as i;

--Now let's write and execute the required query -----------------------------------------------------------------------
SELECT date, count,
    ((count::decimal(10,1) / (lag(count) OVER()) - 1) * 100)::decimal(10,1)::varchar || '%' AS percent_growth
    FROM
       (SELECT
            to_char(created_at::date, 'yyyy-mm-01')::date AS date,
            COUNT(created_at::date) AS count
        FROM posts GROUP BY date ORDER BY date) AS t1;
;

--Result, solution -----------------------------------------------------------------------------------------------------
/*
+----------+-----+--------------+
|date      |count|percent_growth|
+----------+-----+--------------+
|2021-01-01|75   |null          |
|2021-02-01|183  |144.0%        |
|2021-03-01|381  |108.2%        |
|2021-04-01|461  |21.0%         |
|2021-05-01|676  |46.6%         |
|2021-06-01|771  |14.1%         |
|2021-07-01|868  |12.6%         |
|2021-08-01|866  |-0.2%         |
|2021-09-01|881  |1.7%          |
|2021-10-01|956  |8.5%          |
|2021-11-01|931  |-2.6%         |
|2021-12-01|952  |2.3%          |
|2022-01-01|908  |-4.6%         |
|2022-02-01|808  |-11.0%        |
|2022-03-01|955  |18.2%         |
|2022-04-01|886  |-7.2%         |
|2022-05-01|914  |3.2%          |
|2022-06-01|739  |-19.1%        |
|2022-07-01|644  |-12.9%        |
|2022-08-01|409  |-36.5%        |
|2022-09-01|299  |-26.9%        |
|2022-10-01|137  |-54.2%        |
|2022-11-01|7    |-94.9%        |
+----------+-----+--------------+
*/
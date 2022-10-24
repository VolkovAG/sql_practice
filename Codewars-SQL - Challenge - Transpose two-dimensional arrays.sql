/* #Puzzles #SQL #Databases

    <3 kyu> Challenge: Transpose two-dimensional arrays

    Description:
Given a table with a following schema
   Table "public.matrices"
 Column |  Type  | Modifiers
--------+--------+-----------
 matrix | text[] | not null

which holds a set of two-dimensional text arrays i.e.
      matrix
-------------------
 {{1,2,3},{4,5,6}}
 {{a,b,c},{d,e,f}}
 (2 rows)

your goal is to wite a [SELECT] statement or a CTE that returns array data in a transposed form
       matrix
---------------------
 {{1,4},{2,5},{3,6}}
 {{a,d},{b,e},{c,f}}
 (2 rows)

You can't use / create user definded functions and resort to procedural PL/pgSQL.
 */

--To complete the task, create a temporary table matrices --------------------------------------------------------------
CREATE TEMPORARY TABLE matrices
    (
    matrix text[] NOT NULL
    );
-- Now let''s fill them with records -----------------------------------------------------------------------------------
INSERT INTO matrices VALUES
    (ARRAY[['1', '2', '3'], ['4', '5', '6']]),
    (ARRAY[['a', 'b', 'c'], ['d', 'e', 'f']]),
    (ARRAY[['419', '289', '242', '388'], ['326', '170', '251', '541']]);

--DELETE FROM matrices;
--SELECT * FROM matrices;

--[ [ "1", "4" ], [ "2", "5" ], [ "3", "6" ] ]
--[ [ "a", "d" ], [ "b", "e" ], [ "c", "f" ] ]
--[ [ "419", "326" ], [ "289", "170" ], [ "242", "251" ], [ "388", "541" ] ]

--[1:3][1:2]
--[1:3][1:2]
--[1:5][1:4]

--[1:2][1:3], 2, 3
--[1:2][1:3], 2, 3
--[1:2][1:4], 2, 4
/*
SELECT * FROM matrices;
SELECT array_dims(matrix) FROM matrices;
SELECT array_dims(matrix), array_upper(matrix,1), array_upper(matrix,2) FROM matrices;
SELECT array_dims(matrix), array_lower(matrix,1), array_lower(matrix,2) FROM matrices;

SELECT matrix[1:2][1:4],
       matrix[1:1][1:1]||matrix[1:1][1:1] FROM matrices;
*/
SELECT
    matrix[1:array_upper(matrix,1)::int][1:1],
    matrix[1:array_upper(matrix,1)::int][2:2],
    matrix[1:array_upper(matrix,1)::int][3:3],
    matrix[1:array_upper(matrix,1)::int][1:1],
    matrix[1:array_upper(matrix,1)::int][2:2],
    matrix[1:array_upper(matrix,1)::int][3:3],
    matrix[1:array_upper(matrix,1)::int][4:4]
FROM matrices;
/*
SELECT f1[1][-2][3] AS e1, f1[1][-1][5] AS e2
FROM (SELECT '[1:1][-2:-1][3:5]={{{1,2,3},{4,5,6}}}'::int[] AS f1) AS ss;

SELECT '[1:1][-2:-1][3:5]={{{1,2,3},{4,5,6}}}'::int[] AS f1
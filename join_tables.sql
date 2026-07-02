--SELECT * 
--FROM table_a JOIN table_b
--ON table_a.keycolumn = table_b.foreignkey

CREATE TABLE departments (
    dept_id integer,
    dept text,
    city text,
    CONSTRAINT dept_key PRIMARY KEY (dept_id), --PRIMARY KEY is a column or a collection of col whose value uniquely identifies a row. It has only unique values.
    CONSTRAINT dept_city_unique UNIQUE (dept, city)
);

CREATE TABLE employees (
    emp_id integer,
    first_name text,
    last_name text,
    salary numeric(10,2),
    dept_id integer REFERENCES departments (dept_id), -- Foreign key is a col in a table whoch is referencing another col in another table. It can be empty or have duplicate values.
    CONSTRAINT emp_key PRIMARY KEY (emp_id)
);

INSERT INTO departments
VALUES
    (1, 'Tax', 'Atlanta'),
    (2, 'IT', 'Boston');

INSERT INTO employees
VALUES
    (1, 'Julia', 'Reyes', 115300, 1),
    (2, 'Janet', 'King', 98000, 1),
    (3, 'Arthur', 'Pappas', 72700, 2),
    (4, 'Michael', 'Taylor', 89500, 2);

SELECT * FROM departments;
SELECT * FROM employees;

SELECT *  
FROM employees JOIN departments -- Inner join
ON employees.dept_id = departments.dept_id
ORDER BY employees.dept_id;

-----------

CREATE TABLE district_2020 (
    id integer CONSTRAINT id_key_2020 PRIMARY KEY,
    school_2020 text
);

CREATE TABLE district_2035 (
    id integer CONSTRAINT id_key_2035 PRIMARY KEY,
    school_2035 text
);

INSERT INTO district_2020 
VALUES 
    (1, 'Oak Street School'),
    (2, 'Roosevelt High School'),
    (5, 'Dover Middle School'),
    (6, 'Webutuck High School');

INSERT INTO district_2035
VALUES 
    (1,'Oak Street School'),
    (2,'Roosevelt High School'),
    (3,'Morrison Elementary'),
    (4,'Chase Magnet Academy'),
    (6,'Webutuck High School');

SELECT * FROM district_2020;
SELECT * FROM district_2035;

SELECT * 
FROM district_2020 JOIN district_2035
--ON district_2020.id = district_2035.id
USING (id) 
ORDER BY district_2020.id;

SELECT * 
FROM district_2020 LEFT JOIN district_2035
ON district_2020.id = district_2035.id
--USING (id) 
ORDER BY district_2020.id;

SELECT * 
FROM district_2020 RIGHT JOIN district_2035
ON district_2020.id = district_2035.id
--USING (id) 
ORDER BY district_2035.id;

SELECT * 
FROM district_2020 FULL OUTER JOIN district_2035
ON district_2020.id = district_2035.id
--USING (id) 
ORDER BY district_2035.id;

SELECT * 
FROM district_2020 CROSS JOIN district_2035
ORDER BY district_2020.id ,district_2035.id;





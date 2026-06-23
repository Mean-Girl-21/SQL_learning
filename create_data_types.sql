CREATE TABLE teachers(
	id bigserial,
	first_name varchar(25),
	last_name varchar(25),
	school varchar(50),
	hire_date date,
	salary numeric
);

INSERT INTO teachers (first_name, last_name, school, hire_date, salary)
VALUES ('Janet', 'Smith', 'F.D. Roosevelt HS', '2011-10-30', 36200),
	   ('Lee', 'Reynolds', 'F.D. Roosevelt HS', '1993-05-22', 65000),
	   ('Samuel', 'Col', 'Myers Middle School', '2005-08-01', 43500),
	   ('Samantha', 'Bush', 'Myers Middle School', '2011-10-30', 36200),
	   ('Betty', 'Diaz', 'Myers Middle School', '2005-08-30', 43500),
	   ('Kathleen', 'Roush','F.D. Roosevelt HS', '2010-10-22', 38500);

SELECT * FROM teachers

TABLE teachers

SELECT first_name, last_name, salary FROM teachers

SELECT first_name, last_name, salary 
FROM teachers 
ORDER BY salary DESC

SELECT last_name, school, hire_date
FROM teachers
ORDER BY school ASC , hire_date DESC

-- DISTINCT : to show unique values in a column and removing duplicates
SELECT DISTINCT school
FROM teachers
ORDER BY school;

SELECT DISTINCT school, salary
FROM teachers
ORDER BY school, salary

-- V IMP : It sort of works like a function - for every x , what are the y values?
-- WHERE clause helps you to find 'rows' that match a specific value or a range of value or a value supplied via an operator

SELECT last_name, school, hire_date
FROM teachers
WHERE school = 'Myers Middle School'
ORDER BY hire_date;

-- PRACTICE SETS WITH OPERATORS
SELECT first_name, salary
FROM teachers
WHERE salary BETWEEN 10000 AND 60000
ORDER BY salary;

SELECT first_name, last_name, salary
FROM teachers
WHERE last_name IN ('Bush', 'Roush')
ORDER BY last_name;

SELECT first_name, last_name, salary
FROM teachers
WHERE first_name ILIKE 'sam%';

SELECT first_name, last_name, salary
FROM teachers
WHERE first_name NOT ILIKE 'sam%';

CREATE TABLE number_data_types (
	numeric_column numeric(20,5),
	real_column real,
	double_column double precision
);

INSERT INTO number_data_types
VALUES
	(.7, .7, .7),
	(2.13579, 2.13579, 2.13579),
	(2.1357987654, 2.1357987654, 2.1357987654);
	
SELECT * FROM number_data_types;

CREATE TABLE date_time_types (
	timestamp_column timestamp with time zone,
	interval_column interval
);

INSERT INTO date_time_types
VALUES
	('2018-12-31 01:00 EST','2 days'),
	('2018-12-31 01:00 -8','1 month'),
	('2018-12-31 01:00 Australia/Melbourne','1 century'),
	(now(),'1 week');
	
SELECT * FROM date_time_types;

SELECT timestamp_column, CAST(timestamp_column AS varchar(10))
FROM date_time_types;

SELECT numeric_column,
CAST(numeric_column AS integer),
CAST(numeric_column AS varchar(6))
FROM number_data_types;










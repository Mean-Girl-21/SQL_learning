CREATE TABLE supervisor_salaries(
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	town TEXT,
	county TEXT,
	supervisor TEXT,
	start_date date,
	salary numeric(10,2),
	benefits numeric(10,2)
);

--Importing a subset of columns using COPY
COPY supervisor_salaries (town, supervisor, salary) 
FROM '/Users/kanupriya/Desktop/Tanvi_SQL/CSV/supervisor_salaries.csv' 
WITH (FORMAT CSV, HEADER);

--Importing a subset of rows using COPY
COPY supervisor_salaries (town,supervisor,salary)
FROM '/Users/kanupriya/Desktop/Tanvi_SQL/CSV/supervisor_salaries.csv'
WITH (FORMAT CSV, HEADER)
WHERE town = 'New Brilling';

--Adding a value to a column by making a temporary table and using the COPY command
CREATE TEMPORARY TABLE supervisor_salaries_temp
(LIKE supervisor_salaries INCLUDING ALL);

COPY supervisor_salaries_temp(town,supervisor,salary)
FROM '/Users/kanupriya/Desktop/Tanvi_SQL/CSV/supervisor_salaries.csv'
WITH (FORMAT CSV, HEADER);

INSERT INTO supervisor_salaries(town,county,supervisor,salary)
SELECT town, 'Mills', supervisor, salary
FROM supervisor_salaries_temp;

DROP table supervisor_salaries_temp;

SELECT * FROM supervisor_salaries;


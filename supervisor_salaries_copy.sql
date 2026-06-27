--IMPORTING A SUBSET OF COLUMNS

CREATE TABLE supervisor_salaries(
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	town TEXT,
	county TEXT,
	supervisor TEXT,
	start_date date,
	salary numeric(10,2),
	benefits numeric(10,2)
);

COPY supervisor_salaries (town, supervisor, salary) 
FROM '/Users/kanupriya/Desktop/Tanvi_SQL/CSV/supervisor_salaries.csv' 
WITH (FORMAT CSV, HEADER);

COPY supervisor_salaries (town,supervisor,salary)
FROM '/Users/kanupriya/Desktop/Tanvi_SQL/CSV/supervisor_salaries.csv'
WITH (FORMAT CSV, HEADER)
WHERE town = 'New Brilling';

SELECT * FROM supervisor_salaries;

CREATE TEMPORARY TABLE supervisor_salaries_temp (LIKE supervisor_salaries INCLUDING ALL);

SELECT * FROM supervisor_salaries_temp;

DROP TABLE supervisor_salaries_temp;

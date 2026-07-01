--COPY command is specific to postgres; "" text qualifier encloses a column that includes a delimited character

--COPY table_name 
--FROM 'path_to_csv'
--WITH (FORMAT CSV, HEADER)

CREATE TABLE us_counties_pop_est_2019 (
    state_fips text,                         -- State FIPS code
    county_fips text,                        -- County FIPS code
    region smallint,                         -- Region
    state_name text,                         -- State name    
    county_name text,                        -- County name
    area_land bigint,                        -- Area (Land) in square meters
    area_water bigint,                       -- Area (Water) in square meters
    internal_point_lat numeric(10,7),        -- Internal point (latitude)
    internal_point_lon numeric(10,7),        -- Internal point (longitude)
    pop_est_2018 integer,                    -- 2018-07-01 resident total population estimate
    pop_est_2019 integer,                    -- 2019-07-01 resident total population estimate
    births_2019 integer,                     -- Births from 2018-07-01 to 2019-06-30
    deaths_2019 integer,                     -- Deaths from 2018-07-01 to 2019-06-30
    international_migr_2019 integer,         -- Net international migration from 2018-07-01 to 2019-06-30
    domestic_migr_2019 integer,              -- Net domestic migration from 2018-07-01 to 2019-06-30
    residual_2019 integer,                   -- Residual for 2018-07-01 to 2019-06-30
    CONSTRAINT counties_2019_key PRIMARY KEY (state_fips, county_fips)    
);

select * from us_counties_pop_est_2019;

COPY us_counties_pop_est_2019
FROM '/Users/kanupriya/Desktop/Tanvi_SQL/CSV/us_counties_pop_est_2019.csv'
WITH (FORMAT CSV, HEADER)

--Calculating the natural increase in population in the year 2019
SELECT * FROM us_counties_pop_est_2019 ;
SELECT county_name AS county,
	   state_name AS state,
	   births_2019 AS births,
	   deaths_2019 AS deaths,
	   births_2019-deaths_2019 AS natural_increase
FROM us_counties_pop_est_2019
ORDER BY natural_increase ASC;

--Validating the population estimates for the year 2019 
SELECT county_name AS county,
	   state_name AS state,
	   pop_est_2019 AS pop, 
	   pop_est_2018 + births_2019 + international_migr_2019 + domestic_migr_2019 + 
	   residual_2019 - deaths_2019 AS components_total,
	   pop_est_2019 - (pop_est_2018 + births_2019 + international_migr_2019 + domestic_migr_2019 + 
	   residual_2019 - deaths_2019) AS difference
FROM us_counties_pop_est_2019
ORDER BY difference;

--Calculating the percentage of county area covered by water 
SELECT state_name AS state,
	   county_name AS county,
	   area_land,
	   area_water,
	   area_water:: numeric/(area_land + area_water)*100 AS pct_of_water
FROM us_counties_pop_est_2019
ORDER BY pct_of_water DESC;

-- Tracking percent change 
CREATE TABLE percent_change (
	department text,
	spend_2019 numeric(10,2),
	spend_2022 numeric(10,2)
);
INSERT INTO percent_change 
VALUES ('Assessor' , 178556 , 179500), 
	   ('Building' , 250000 , 289000),
	   ('Clerk' , 451980 , 650000),
	   ('Library' , 87777 , 90001),
	   ('Parks' , 250000 , 223000),
	   ('Water' , 199000 , 195000);

SELECT * FROM percent_change; 

SELECT  department, 
		spend_2019, 
		spend_2022,
		round(((spend_2022 - spend_2019)/spend_2019)*100, 1) AS pct_change --ROUND function is used to remove all but one decimal space
FROM percent_change
ORDER BY pct_change DESC;

--Aggregate functions are used to calculate multiple results from the same set of values in a column
SELECT sum(pop_est_2019) AS county_sum,
	   round(avg(pop_est_2019),1) AS county_avg
FROM us_counties_pop_est_2019;

----Percentiles indicate the point in an ordered set of data below which a certain percentage of data are found
--Using percentile_cont() and percentile_disc() to find median
CREATE TABLE percentile_test (numbers integer);

INSERT INTO percentile_test 
VALUES (1),(2),(3),(4),(5),(6);

SELECT 
	percentile_cont(0.5)
	WITHIN GROUP (ORDER BY numbers),
	percentile_disc(0.5)
	WITHIN GROUP (ORDER BY numbers)
FROM percentile_test; 

--Finding other quantiles with percentile_cont() and percentile_disc()
SELECT unnest(
		percentile_cont(ARRAY[0.25, 0.5, 0.75])
		WITHIN GROUP (ORDER BY pop_est_2019)
		) AS quartiles
FROM us_counties_pop_est_2019;  

--Finding mode using mode() function
SELECT mode() WITHIN GROUP (ORDER BY births_2019)
FROM us_counties_pop_est_2019;

SELECT county_name , births_2019
FROM us_counties_pop_est_2019
WHERE births_2019 = (SELECT 
	mode() WITHIN GROUP (ORDER BY births_2019) 
FROM us_counties_pop_est_2019);

		







	   
	   


	   






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





	   
	   


	   






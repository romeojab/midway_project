USE midway_project
;
-- Check to see if the data has been transferred correctly
SELECT *
FROM midway_project.bike_df
;

-- Lets see how many accidents occured by year
SELECT	DATE_FORMAT(date,'%Y') AS year_date
		, COUNT(*) AS accidents
FROM midway_project.bike_df
GROUP BY year_date
ORDER BY accidents DESC
; -- we see that 2020 was the year with the most accidents. Of course, we don't have all the data for 2022 yet

-- Lets see if month is a factor
SELECT	DATE_FORMAT(date,'%M') AS month_date
		, COUNT(*) AS accidents
FROM midway_project.bike_df
GROUP BY month_date
ORDER BY accidents DESC
; -- the top 3 months with the most accidents are May, June and October

-- Now lets drill down to see which year are the months with the most accidents
SELECT	DATE_FORMAT(date,'%Y') AS year_date
		, DATE_FORMAT(date,'%M') AS month_date
		, COUNT(*) AS accidents
FROM midway_project.bike_df
GROUP BY	year_date
			, month_date
ORDER BY accidents DESC
; -- We see that 2020 not only had the most accidents but also the months, May July and June

-- Lets do the same but only for 2022
SELECT	DATE_FORMAT(date,'%Y') AS year_date
		, DATE_FORMAT(date,'%M') AS month_date
		, COUNT(*) AS accidents
FROM midway_project.bike_df
WHERE DATE_FORMAT(date,'%Y') = '2022'
GROUP BY	year_date
			, month_date
ORDER BY accidents DESC
; -- March has the highest number of accidents so far in 2022

-- Fetching the last entry
SELECT *
FROM midway_project.bike_df
WHERE datetime = (	SELECT MAX(datetime) AS datetime
				FROM midway_project.bike_df
				)
; -- Here we see we only have records until the end of the first quarter in 2022

-- Lets see the distribution of accidents by gender
SELECT	sex
        , COUNT(*) AS accidents
FROM midway_project.bike_df
GROUP BY sex
ORDER BY accidents DESC
; -- Males seem to have more accidents than females. 73% of the accidents in fact

-- Lets see the distribution of accidents by gender and year
SELECT	sex
		, DATE_FORMAT(date,'%Y') AS year_date
        , COUNT(*) AS accidents
FROM midway_project.bike_df
GROUP BY	sex
			, year_date
ORDER BY accidents DESC
; -- We see that males have more accidents in all 3 years than females with the highest in 2020

-- Lets do the same but only for 2022
SELECT	sex
		, DATE_FORMAT(date,'%Y') AS year_date
        , COUNT(*) AS accidents
FROM midway_project.bike_df
WHERE DATE_FORMAT(date,'%Y') = '2022'
GROUP BY	sex
			, year_date
ORDER BY accidents DESC
; -- Males are still on top for the number of accidents

-- What time of the day have the most accidents
SELECT	time
        , COUNT(*) AS accidents
FROM midway_project.bike_df
GROUP BY time
ORDER BY accidents DESC
; -- It seems that the most accidents occur in the evenings between 20:00 and 21:00

-- Now lets see if this is still the case if we look at time and years
SELECT	time
		, DATE_FORMAT(date,'%Y') AS year_date
        , COUNT(*) AS accidents
FROM midway_project.bike_df
GROUP BY time, year_date
ORDER BY accidents DESC
; -- Interestingly we see that both 21:30 in 2020 and 11:30 in 2021 have the most accidents, closely followed by 21:00 in 2020 and 14:30 in 2020

-- Now lets see the distribution by district
SELECT	district
        , COUNT(*) AS accidents
FROM midway_project.bike_df
GROUP BY district
ORDER BY accidents DESC
; -- The city center seems to have the most accidents

-- Lets see the distribution by district and year
SELECT	district
		, DATE_FORMAT(date,"%Y") AS year_date
        , COUNT(*) AS accidents
FROM midway_project.bike_df
GROUP BY	district
			, year_date
ORDER BY accidents DESC
; -- Indeed, the city center has the highest accidents recorded for each year 

-- Finally, Lets do the same but only for 2022
SELECT	district
		, DATE_FORMAT(date,"%Y") AS year_date
        , COUNT(*) AS accidents
FROM midway_project.bike_df
WHERE DATE_FORMAT(date,'%Y') = '2022'
GROUP BY	district
			, year_date
ORDER BY accidents DESC
; -- The city center is still on top for the most accidents in 2022

-- query to import to python
SELECT	district
        , accident_type
        , weather_state
        , vehicle_type
        , age_range
        , sex
        , injury_type
        , COUNT(*) AS accidents
FROM midway_project.bike_df
GROUP BY	district
			, accident_type
			, weather_state
			, vehicle_type
			, age_range
			, sex
			, injury_type
ORDER BY accidents DESC
;
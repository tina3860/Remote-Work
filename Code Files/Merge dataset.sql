select *
from nsw_2020_clean

select COUNT(*)
from nsw_2020_clean

SELECT *
FROM nsw_2021_clean

select COUNT(*)
from nsw_2021_clean

--merging data sets--
select response_ID, birth_year,gender,industry,occupation,current_employment_num,manager,household_descrip,current_job_length,metro_regional,time_preferred_covid,agr_dis_covid_encouraged,agr_dis_covid_changes,agr_dis_covid_choice,productivity_hour,workplace_activity_prep,workplace_activity_working,workplace_activity_personaltime,workplace_activity_responsibilities,remote_activity_prep,remote_activity_working,remote_activity_personaltime,remote_activity_responsibilities  
From nsw_2020_clean
union all 
select response_ID, birth_year,gender,industry,occupation,current_employment_num,manager,household_descrip,current_job_length,metro_regional,time_preferred_covid,agr_dis_covid_encouraged,agr_dis_covid_changes,agr_dis_covid_choice,productivity_hour,workplace_activity_prep,workplace_activity_working,workplace_activity_personaltime,workplace_activity_responsibilities,remote_activity_prep,remote_activity_working,remote_activity_personaltime,remote_activity_responsibilities 
from nsw_2021_clean


-- industry --

select distinct industry
from merge_clean
order by industry 


select COUNT(industry) as frequency, industry
from merge_clean
group by industry
order by frequency desc

--top 5 industries--
select top 5 industry, COUNT(industry) as frequency
from merge_clean
group by industry
ORDER by COUNT(industry) DESC

--table that shows how company size based off of industry--
select distinct industry, COUNT(industry) as freq_indus, current_employment_num as current_empoyment_num_category
from merge_clean
GROUP by current_employment_num, industry
order by COUNT(industry) desc

-- cleans industry column --
UPDATE merge_clean
SET industry = 
    CASE 
        WHEN industry = 'Accommodation and Food Services' THEN 'Accommodation and Food'
        WHEN industry = 'Administrative and Support Services' THEN 'Administrative and Support'
        WHEN industry = 'Arts and Recreation Services' THEN 'Arts and Recreation'
        WHEN industry = 'Electricity, Gas, Water and Waste Services' THEN 'Electricity, Gas, Water and Waste'
        WHEN industry = 'Financial and Insurance Services' THEN 'Financial and Insurance'
        WHEN industry =  'Professional, Scientific and Technical Services' THEN 'Professional, Scientific and Technical'
        WHEN industry = 'Rental, Hiring and Real Estate Services' THEN 'Rental, Hiring and Real Estate'
        -- Add more WHEN conditions for other similar categories and their common value--
        ELSE industry  -- Keep the category unchanged if it doesn't match any condition--
    END;


-- new response id --


-- Find the maximum response_ID value in nsw_2020_clean
SELECT MAX(response_ID) AS max_id_2020
FROM nsw_2020_clean;

-- Find the maximum response_ID value in nsw_2021_clean
SELECT MAX(response_ID) AS max_id_2021
FROM nsw_2021_clean;

-- Update response_ID values in nsw_2021_clean by adding the maximum response_ID value from nsw_2020_clean
UPDATE nsw_2021_clean
SET response_ID = response_ID + (SELECT max_id_2020 FROM (SELECT MAX(response_ID) AS max_id_2020 FROM nsw_2020_clean) AS max_2020);

-- Merge nsw_2020_clean and nsw_2021_clean based on the updated response_ID values
SELECT *
FROM nsw_2020_clean
UNION ALL
SELECT *
FROM nsw_2021_clean;




-- fix response id--

CREATE SEQUENCE seq_2020
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 1507
NO CYCLE

UPDATE nsw_2020_clean SET response_ID = NEXT VALUE FOR seq_2020

select *
from nsw_2020_clean


CREATE SEQUENCE seq_2021
START WITH 1508
INCREMENT BY 1
MINVALUE 1508
MAXVALUE 3019
NO CYCLE

UPDATE nsw_2021_clean SET response_ID = NEXT VALUE FOR seq_2021

select*
from nsw_2021_clean


select response_ID, birth_year,gender,industry,occupation,current_employment_num,manager,household_descrip,current_job_length,metro_regional,time_preferred_covid,agr_dis_covid_encouraged,agr_dis_covid_changes,agr_dis_covid_choice,productivity_hour,workplace_activity_prep,workplace_activity_working,workplace_activity_personaltime,workplace_activity_responsibilities,remote_activity_prep,remote_activity_working,remote_activity_personaltime,remote_activity_responsibilities  
From nsw_2020_clean
union all 
select response_ID, birth_year,gender,industry,occupation,current_employment_num,manager,household_descrip,current_job_length,metro_regional,time_preferred_covid,agr_dis_covid_encouraged,agr_dis_covid_changes,agr_dis_covid_choice,productivity_hour,workplace_activity_prep,workplace_activity_working,workplace_activity_personaltime,workplace_activity_responsibilities,remote_activity_prep,remote_activity_working,remote_activity_personaltime,remote_activity_responsibilities 
from nsw_2021_clean

select COUNT(*)
from merge_clean


SELECT remote_time_2020_Q3
FROM nsw_2021_clean


select *
from merge_clean



select*
from nsw_2020_clean
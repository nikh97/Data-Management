-- write your queries underneath each number:
 
-- 1. the total number of rows in the database

SELECT COUNT(*)
FROM city_payroll;

-- 2. show the first 15 rows, but only display 3 columns (your choice)

SELECT employee_id, agency_name, hourly_pay

FROM city_payroll

LIMIT 15;

-- 3. do the same as above, but chose a column to sort on, and sort in descending order

SELECT employee_id, agency_name, hourly_pay

FROM city_payroll

ORDER BY hourly_pay DESC

LIMIT 15;


-- 4. add a new column without a default value

ALTER TABLE city_payroll

ADD total_gross NUMERIC;

-- 5. set the value of that new column

UPDATE city_payroll

SET total_gross = regular_gross + total_ot_paid + total_other_pay;

-- 6. show only the unique (non duplicates) of a column of your choice

SELECT DISTINCT location

FROM city_payroll;

-- 7.group rows together by a column value (your choice) and use an aggregate function to calculate something about that group 

SELECT agency_name, AVG(hourly_pay::NUMERIC) as average_hourly_pay

FROM city_payroll

GROUP BY agency_name;

-- 8. now, using the same grouping query or creating another one, find a way to filter the query results based on the values for the groups 

SELECT agency_name, AVG(hourly_pay::NUMERIC) as average_hourly_pay

FROM city_payroll

GROUP BY agency_name

HAVING AVG(hourly_pay::NUMERIC) > 60;


-- 9. Count how many employees are in each location, and then order them in a descending fashion

SELECT location, COUNT(*) as num_employees

FROM city_payroll

GROUP BY location

ORDER BY num_employees DESC;


-- 10. Get the depts with the top 10 most average total hours worked during the FY 2018

SELECT agency_name, ROUND(AVG(total_hours), 2) as average_hours

FROM city_payroll

GROUP BY agency_name

ORDER BY average_hours DESC

LIMIT 10;


-- 11. Get the top 10 departments with the most total gross payroll (not base)

SELECT agency_name, SUM(total_gross) as total_payroll

FROM city_payroll

GROUP BY agency_name

ORDER BY total_payroll DESC

LIMIT 10;

-- 12. How many unique job titles are there

SELECT COUNT(DISTINCT title_description) as num_job_titles

FROM city_payroll;












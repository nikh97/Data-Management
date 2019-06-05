-- 1. Get the number of employees in the Police Dept

SELECT COUNT(*)
FROM employee e
INNER JOIN Department d
ON e.agency_name = d.dept_id
WHERE d.dept_name = 'POLICE DEPARTMENT';

-- 2. Get all the employees who have location missing from thier profile

SELECT employee_id, last_name, first_name 
FROM employee e
LEFT JOIN location l
ON e.location = l.loc_id
WHERE l.loc_name is null;

-- 3. Get number of employees in each department but only for those with more than 15000 employees

SELECT d.dept_name, COUNT(*) AS num_employees
FROM employee e
JOIN department d 
ON d.dept_id = e.agency_name
GROUP BY d.dept_name
HAVING COUNT(*) > 15000;
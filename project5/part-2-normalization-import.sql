-- create schema staging;

-- CREATE TABLE staging.payroll(

-- 	employee_id serial PRIMARY KEY,
-- 	agency_name text NOT NULL,
-- 	last_name varchar(255) DEFAULT 'Not Specified',
-- 	first_name varchar(255) DEFAULT 'Not Specified',
-- 	location varchar(255) DEFAULT 'Not Specified',
-- 	title_description text DEFAULT 'Not Specified',
-- 	leave_status varchar(255),
-- 	base_salary money,
-- 	pay_basis varchar(255),
-- 	regular_hours numeric DEFAULT 2087.0,
-- 	regular_gross money,
-- 	ot_hours numeric,
-- 	total_ot_paid money,
-- 	total_other_pay money,
-- 	hourly_pay money,
-- 	total_hours numeric
-- );

-- COPY staging.payroll (agency_name, last_name, first_name, location, title_description, leave_status, base_salary, pay_basis, regular_hours, regular_gross, ot_hours, total_ot_paid, total_other_pay, hourly_pay, total_hours)
-- FROM '/Users/nikhilgosike/Documents/DataManagement/nikh97-homework05/clean_city_payroll_data.csv'
-- csv HEADER;

-- insert into location (loc_name)
--     (select distinct location from staging.payroll);

-- insert into department (dept_name)
--     (select distinct agency_name from staging.payroll);

-- insert into employee(last_name, first_name, title_description)
--     (select last_name, first_name, title_description from staging.payroll);

-- insert into leave_status(status)
-- 	VALUES
-- 			('ACTIVE'),
-- 			('SUSPENDED'),
-- 			('ON LEAVE'),
-- 			('CEASED'),
-- 			('ON SEPERATION LEAVE'),
-- 			('SEASONAL');

-- insert into pay_basis(basis)
-- 	VALUES
-- 			('per Annum'),
-- 			('per Day'),
-- 			('per Hour'),
-- 			('Prorated Annual');

-- insert into payroll(base_salary, regular_hours, regular_gross, ot_hours, total_ot_paid, total_other_pay, hourly_pay, total_hours)
-- 	(SELECT base_salary, regular_hours, regular_gross, ot_hours, total_ot_paid, total_other_pay, hourly_pay, total_hours 
-- 		FROM staging.payroll);

-- update public.employee set agency_name = department.dept_id
-- from staging.payroll
-- inner join department
--     on department.dept_name = staging.payroll.agency_name
-- where public.employee.employee_id = staging.payroll.employee_id;

-- update public.employee set location = location.loc_id
-- from staging.payroll
-- inner join location
--     on location.loc_name = staging.payroll.location
-- where public.employee.employee_id = staging.payroll.employee_id;

-- update public.employee set leave_status = leave_status.status_id
-- from staging.payroll
-- inner join leave_status
--     on leave_status.status = staging.payroll.leave_status
-- where public.employee.employee_id = staging.payroll.employee_id;

update public.payroll set pay_basis = pay_basis.basis_id
from staging.payroll
inner join pay_basis
    on pay_basis.basis = staging.payroll.pay_basis
where public.payroll.payroll_id = staging.payroll.employee_id;







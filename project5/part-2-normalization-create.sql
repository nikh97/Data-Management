-- DROP TABLE IF EXISTS location;
-- CREATE TABLE location(
-- 	loc_id SERIAL,
-- 	loc_name varchar(25),
-- 	PRIMARY KEY(loc_id)
-- );

-- DROP TABLE IF EXISTS department;
-- CREATE TABLE department(
-- 	dept_id SERIAL,
-- 	dept_name varchar(100),
-- 	PRIMARY KEY(dept_id)
-- );

-- DROP TABLE IF EXISTS leave_status;
-- CREATE TABLE leave_status(
-- 	status_id SERIAL,
-- 	status varchar(100),
-- 	PRIMARY KEY(status_id)
-- );

-- DROP TABLE IF EXISTS pay_basis;
-- CREATE TABLE pay_basis(
-- 	basis_id SERIAL,
-- 	basis varchar(100),
-- 	PRIMARY KEY(basis_id)
-- );

DROP TABLE IF EXISTS employee;
CREATE TABLE employee(
	employee_id SERIAL PRIMARY KEY,
	last_name varchar(255),
	first_name varchar(255),
	title_description text,
	agency_name INTEGER references department(dept_id),
	location INTEGER references location(loc_id),
	leave_status INTEGER references leave_status(status_id)

);

DROP TABLE IF EXISTS payroll;
CREATE TABLE payroll(
	payroll_id SERIAL PRIMARY KEY,
	base_salary money,
	pay_basis INTEGER references pay_basis(basis_id),
	regular_hours numeric DEFAULT 2087.0,
	regular_gross money,
	ot_hours numeric,
	total_ot_paid money,
	total_other_pay money,
	hourly_pay money,
	total_hours numeric

);



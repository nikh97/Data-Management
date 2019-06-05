-- write your table creation sql here!

DROP TABLE IF EXISTS city_payroll;

CREATE TABLE city_payroll(

	employee_id serial PRIMARY KEY,
	agency_name text NOT NULL,
	last_name varchar(255) DEFAULT 'Not Specified',
	first_name varchar(255) DEFAULT 'Not Specified',
	location varchar(255) DEFAULT 'Not Specified',
	title_description text DEFAULT 'Not Specified',
	leave_status varchar(255),
	base_salary money,
	pay_basis varchar(255),
	regular_hours numeric DEFAULT 2087.0,
	regular_gross money,
	ot_hours numeric,
	total_ot_paid money,
	total_other_pay money,
	hourly_pay money,
	total_hours numeric


);
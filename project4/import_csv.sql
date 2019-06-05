-- write your COPY statement to import a csv here


COPY city_payroll (agency_name, last_name, first_name, location, title_description, leave_status, base_salary, pay_basis, regular_hours, regular_gross, ot_hours, total_ot_paid, total_other_pay, hourly_pay, total_hours)
FROM '/Users/nikhilgosike/Documents/DataManagement/nikh97-homework04/clean_city_payroll_data.csv'
csv HEADER;
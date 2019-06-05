-- 1. Count how many scooter types there are for each company by showing the company id and the number of scooter types associated with that company id

	Select company_id, count(scooter_type_id)
	from scooter_type
	Group by company_id;


-- 2. Show the scooter id, company name, when the company was founded, scooter model, weight, max speed, acquired_date, and retired fields for the first 10 scooters in the inventory.

	Select s1.scooter_id, c.name, c.founded, s2.model, s2.weight, s2.max_speed, s1.acquired_date, s1.retired
	from scooter s1
	join scooter_type s2
	on s1.scooter_type_id = s2.scooter_type_id
	join company c
	on s2.company_id = c.company_id
	order by s1.scooter_id
	limit 10;


-- 3. Show the total number of retired scooters as well as the total number of non-retired scooters.

	Select 

		Sum(Case When retired = 'f' then 1 else 0 end) as non_retired,
		sum(case when retired = 't' then 1 else 0 end) as retired

	from scooter;

-- 4. show the company name, model and max speed of the model of scooter with the highest max speed for every company

	Select c.name, s.model, s.max_speed
	from scooter_type s
	join company c
	on c.company_id = s.company_id
	where (s.company_id, s.max_speed) in
	(Select company_id, max(max_speed)
	from scooter_type
	group by company_id);

-- 5.

-- 6.

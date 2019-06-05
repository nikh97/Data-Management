-- 1. List all people (names are adequate) that have flags in any order
SELECT first_name, last_name
FROM person p
JOIN customer c
ON p.email_address = c.email_address
WHERE flag = False;

-- 2. List all available scooters in any order

SELECT * 
FROM scooters
WHERE status_code = 'a';

-- 3. List all scooters (scooter model and manufacturer, along with person's name… and when they're due back) that are being borrowed in order of when they're due back ordered by when whey were due increasing (that is, earlier ones appear first, and more recent ones appear later)

SELECT s.*, m2.man_name, b.return_by AS due_back, p.first_name, p.last_name
FROM scooters s
JOIN models m1 ON s.model_number = m1.model_number
JOIN manufacturers m2 ON m1.manufacturer_id = m2.manufacturer_id
JOIN borrow b ON s.scooter_id = b.scooter_id
JOIN person p ON b.email_address = p.email_address
WHERE p.status_code = 'b';

-- 4. List all scooters (scooter model and manufacturer, along with person's name) that are being borrowed and that are late in any order

SELECT s.*, m2.man_name, b.return_by AS due_back, p.first_name, p.last_name
FROM scooters s
JOIN models m1 ON s.model_number = m1.model_number
JOIN manufacturer m2 ON m1.manufacturer_id = m2.manufacturer_id
JOIN borrow b ON s.scooter_id = b.scooter_id
JOIN return r ON r.return_id = b.return_id
JOIN person p ON b.email_address = p.email_address
WHERE r.late_status = True;

-- 5. List the top 5 people (names and number of referrals) that have the most referrals sorted by most referrals descending

SELECT distinct first_name, last_name, COUNT(referrer) AS num_referrals
FROM referrals r
JOIN person p 
ON r.email_address = p.email_address
GROUP BY referrer
ORDER BY num_referrals
LIMIT 5;

-- 6. Given a unique identifier for a person, show all of the times that person has borrowed a scooter in chronological order (from the first time they borrowed a scooter to the most recent)

-- Assume given email address of person
SELECT * 
FROM borrow
WHERE email_address = [put identifier here]
ORDER BY datetime_bor;

-- 7. Given a unique identifier for a particular instance of a person borrowing a scooter, show all of the damage / late related fees

-- Assume given transaction number (ie borrow_id)
SELECT additional_fees
FROM borrow
JOIN return 
ON borrow.return_id = return.return_id
WHERE borrow_id = [put identifier here];

-- 8. List all of the manufacturers of scooters in your database, even if you don't currently have any of their scooters in your inventory

SELECT *
FROM manufacturers;













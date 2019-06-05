DROP TABLE IF EXISTS zipcodes;
CREATE TABLE zipcodes (
	zipcode INTEGER,
	city varchar(50) NOT NULL,
	state varchar(3) NOT NULL, -- assume using abbreviations
	PRIMARY KEY(zipcode)
);

DROP TABLE IF EXISTS addresses;
CREATE TABLE addresses (
	address_id SERIAL,
	postal_code INTEGER references zipcodes(zipcode) not null,
	num INTEGER,
	street varchar(50),
	PRIMARY KEY(address_id)
);

DROP TABLE IF EXISTS person;
CREATE TABLE person(
	email_address varchar(50),
	address_id INTEGER references addresses(address_id) not null,
	first_name varchar(50),
	last_name varchar(50),
	cellphone INTEGER,
	date_first_entered DATE,
	referral_id INTEGER references referrals(referral_id),
	flag BOOLEAN DEFAULT False,
	PRIMARY KEY(email_address)
);

DROP TABLE IF EXISTS referrals;
CREATE TABLE referrals (
	referral_id SERIAL,
	referrer varchar(50) references person(email_address) not null;
	PRIMARY KEY(referral_id)
);

DROP TABLE IF EXISTS manufacturers;
CREATE TABLE manufacturers (
	manufacturer_id SERIAL,
	man_name varchar(50),
	man_country varchar(50)
	PRIMARY KEY(manufacturer_id)
);

DROP TABLE IF EXISTS models;
CREATE TABLE models (
	model_number INTEGER,
	manufacturer_id INTEGER references manufacturers(manufacturer_id) not null,
	range NUMERIC,
	weight NUMERIC,
	topspeed NUMERIC,
	PRIMARY KEY(model_number)
);

DROP TABLE IF EXISTS scooters;
CREATE TABLE scooters (
	scooter_id SERIAL,
	model_number INTEGER references models(model_number) not null,
	condition varchar(10),
	status_code CHAR, -- 'a' for avaliable and 'b' for borrowed
	PRIMARY KEY(scooter_id)
);

DROP TABLE IF EXISTS borrow;
CREATE TABLE borrow(
	borrow_id SERIAL,
	customer_id INTEGER references customers(customer_id) not null,
	scooter_id INTEGER references scooters(scooter_id) not null,
	return_id INTEGER references return(return_id) not null,
	return_status BOOLEAN DEFAULT False,
	datetime_bor DATETIME,
	prepay_amount MONEY DEFAULT 0,
	hours_booked NUMERIC DEFAULT 0,
	return_by TIMESTAMPTZ,
	note_id INTEGER references note(note_id),
	PRIMARY KEY(borrow_id)
);

DROP TABLE IF EXISTS note;
CREATE TABLE note(
	note_id SERIAL,
	note_category varchar(50) DEFAULT 'OTHER',
	note description TEXT,
	PRIMARY KEY(note_id)
);

DROP TABLE IF EXISTS return;
CREATE TABLE return(
	return_id SERIAL,
	datetime_return TIMESTAMPTZ DEFAULT NOW(),
	late_status BOOLEAN,
	damage_status BOOLEAN,
	additional_fees MONEY,
	PRIMARY KEY(return_id)
);













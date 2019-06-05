# Overview

Link to data: https://data.cityofnewyork.us/City-Government/Citywide-Payroll-Data-Fiscal-Year-/k397-673e

This is a dataset containing a cleaned and transformed data on the payroll data for city employees for NYC. Sourced from NYC Open Data, this data is originally from the Office of Payroll Administration (OPA), which handles the payroll for all city employees across every department. This data is as of fiscal year 2018 and was last updated on 9/28/18.

The following are the headers or fields included in the csv file:

	Agency name: the department for the individual employee
	Last Name
	First Name
	Location - where does the employee work
	Title Description - what is the employees job
	Leave Status - is the employee still working there
	Base Salary
	Pay Basis - is the base salary per hour, per year, etc.
	Regular Hours - hours before overtime accounted for
	Regular Gross Paid - actual amount paid
	OT Hours - overtime hours for employee
	Total OT Paid - amount for overtime paid, which surprisingly can be negative
	Total Other Pay
	Hourly Pay
	Total Hours


# Table Design

employee_id serial PRIMARY KEY - there was no real unique identifier, so a serial type was used to create this
agency_name text NOT NULL - Each employee must be assigned to a department or else they cannot be included in the database for futher analysis, hence the NOT NULL constraint
last_name varchar(255) DEFAULT 'Not Specified' - This is a text based column, however limited to 255 characters (I'm sure most names will fit that length), however sometimes this can be missing, hence the default to 'Not Specified'
first_name varchar(255) DEFAULT 'Not Specified' - same as last name
location varchar(255) DEFAULT 'Not Specified' - same as above
title_description text DEFAULT 'Not Specified' - same as above, however the titles can be very long, so I used a text type
leave_status varchar(255) - same as above, however a varchar was used since this value can only really take on 3 or 4 values (ACTIVE, SUSPENDED, etc.)
base_salary money - a money type was used since this was salary, i did not leave any constraint here since values could be missing and because we cannot really assume any values here
pay_basis varchar(255) - same as leave_status
regular_hours numeric DEFAULT 2087.0 - sometimes these hours can be negative or zero, based on a Google search this an approx. value for hours worked on a yearly basis assuming a regular 40 hour week
regular_gross money - same as base_salary
ot_hours numeric - hours could be non-whole numbers, also employees may not have worked ot_hours, hence no constraints
total_ot_paid money - same as base_salary
total_other_pay money - same as base_salary
hourly_pay money - same as base_salary
total_hours numeric - same as ot_hours


# Import

The main errors for the import were centered around syntax and accounting for the header within the cleaned csv file. These were easy to fix by looking at the documentation for the COPY command for PostgreSQL. Something that wasn't accounted for at first was how to account for the first column in my table, which is of type SERIAL, meaning it is self-incrementing to create a unique private key for each data point. To fix this, I had to specify the column names in the statement. At first, I had the name of employees as NOT NULL, however, I found that some names were missing (these were mainly special investigators, so this may be so due to security measures). Because of this, I changed the constraints. 


# Database Information

'''

###

postgres=# \l
                                        List of databases
    Name    |    Owner     | Encoding |   Collate   |    Ctype    |       Access privileges       
------------+--------------+----------+-------------+-------------+-------------------------------
 demo       | nikhilgosike | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 homework04 | nikhilgosike | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 postgres   | nikhilgosike | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 template0  | nikhilgosike | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/nikhilgosike              +
            |              |          |             |             | nikhilgosike=CTc/nikhilgosike
 template1  | nikhilgosike | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/nikhilgosike              +
            |              |          |             |             | nikhilgosike=CTc/nikhilgosike
(5 rows)

postgres=# \c homework04
You are now connected to database "homework04" as user "nikhilgosike".
homework04=# \dt
              List of relations
 Schema |     Name     | Type  |    Owner     
--------+--------------+-------+--------------
 public | city_payroll | table | nikhilgosike
(1 row)

homework04=# \d city_payroll
                                              Table "public.city_payroll"
      Column       |          Type          | Collation | Nullable |                      Default                      
-------------------+------------------------+-----------+----------+---------------------------------------------------
 employee_id       | integer                |           | not null | nextval('city_payroll_employee_id_seq'::regclass)
 agency_name       | text                   |           | not null | 
 last_name         | character varying(255) |           |          | 'Not Specified'::character varying
 first_name        | character varying(255) |           |          | 'Not Specified'::character varying
 location          | character varying(255) |           |          | 'Not Specified'::character varying
 title_description | text                   |           |          | 'Not Specified'::text
 leave_status      | character varying(255) |           |          | 
 base_salary       | money                  |           |          | 
 pay_basis         | character varying(255) |           |          | 
 regular_hours     | numeric                |           |          | 2087.0
 regular_gross     | money                  |           |          | 
 ot_hours          | numeric                |           |          | 
 total_ot_paid     | money                  |           |          | 
 total_other_pay   | money                  |           |          | 
 hourly_pay        | money                  |           |          | 
 total_hours       | numeric                |           |          | 
Indexes:
    "city_payroll_pkey" PRIMARY KEY, btree (employee_id)

'''

# Query Results

```
### 1. the total number of rows in the database	
 count  
--------
 298096

```

```
### 2. show the first 15 rows, but only display 3 columns (your choice)
 employee_id |    agency_name    | hourly_pay 
-------------+-------------------+------------
           1 | POLICE DEPARTMENT |     $22.63
           2 | POLICE DEPARTMENT |     $25.48
           3 | POLICE DEPARTMENT |     $41.69
           4 | POLICE DEPARTMENT |     $48.17
           5 | POLICE DEPARTMENT |     $22.67
           6 | POLICE DEPARTMENT |     $33.65
           7 | POLICE DEPARTMENT |     $33.92
           8 | POLICE DEPARTMENT |     $15.04
           9 | POLICE DEPARTMENT |     $33.85
          10 | POLICE DEPARTMENT |     $37.93
          11 | POLICE DEPARTMENT |     $49.08
          12 | POLICE DEPARTMENT |     $32.87
          13 | POLICE DEPARTMENT |     $49.08
          14 | POLICE DEPARTMENT |     $17.38
          15 | POLICE DEPARTMENT |     $17.38

```

```
###3. do the same as above, but chose a column to sort on, and sort in descending order
 employee_id |          agency_name           | hourly_pay 
-------------+--------------------------------+------------
       86636 | DEPT OF ENVIRONMENT PROTECTION |  $8,835.20
      297683 | OFFICE OF THE MAYOR            |  $4,285.71
      276496 | FIRE DEPARTMENT                |  $3,714.29
      296981 | NYC EMPLOYEES RETIREMENT SYS   |  $3,714.29
      240678 | FINANCIAL INFO SVCS AGENCY     |  $3,714.29
      241634 | CITY COUNCIL                   |  $3,619.71
       99193 | HOUSING PRESERVATION & DVLPMNT |  $3,571.43
      297726 | OFFICE OF THE MAYOR            |  $3,571.43
       41516 | POLICE DEPARTMENT              |  $3,540.79
      226599 | DEPARTMENT OF EDUCATION ADMIN  |  $3,428.57
       88190 | DEPT OF ENVIRONMENT PROTECTION |  $3,285.71
      240535 | OFF OF PAYROLL ADMINISTRATION  |  $3,142.86
      271129 | ADMIN FOR CHILDREN'S SVCS      |  $3,142.86
       42448 | POLICE DEPARTMENT              |  $3,085.71
      101225 | DEPARTMENT OF PROBATION        |  $3,000.00



```

```
###4.add a new column without a default value
ALTER TABLE

```

```
###5.set the value of that new column
UPDATE 298096

```

```
###6. show only the unique (non duplicates) of a column of your choice
   location    
---------------
 BRONX
 WASHINGTON DC
 GREENE
 SCHOHARIE
 OTHER
 RICHMOND
 NASSAU
 PUTNAM
 SULLIVAN
 ORANGE
 MANHATTAN
 BROOKLYN
 QUEENS
 DUTCHESS
 ALBANY
 DELAWARE
 ULSTER
 WESTCHESTER

```


```
###7.group rows together by a column value (your choice) and use an aggregate function to calculate something about that group 
          agency_name           |  average_hourly_pay  
--------------------------------+----------------------
 ADMIN FOR CHILDREN'S SVCS      |  47.7466548754229468
 ADMIN TRIALS AND HEARINGS      |  51.7605633802816901
 BOARD OF CORRECTION            |  59.5692857142857143
 BOARD OF ELECTION              |  32.0948507462686567
 BOROUGH PRESIDENT-BRONX        |  48.6898000000000000
 BOROUGH PRESIDENT-BROOKLYN     |  48.2086440677966102
 BOROUGH PRESIDENT-QUEENS       |  60.4852727272727273
 BOROUGH PRESIDENT-STATEN IS    |  45.4177500000000000
 BRONX COMMUNITY BOARD #1       |  59.5950000000000000
 BRONX COMMUNITY BOARD #10      |  29.3966666666666667
 BRONX COMMUNITY BOARD #11      |  35.4750000000000000
 BRONX COMMUNITY BOARD #12      |  52.0350000000000000
 BRONX COMMUNITY BOARD #2       |  36.8800000000000000
 BRONX COMMUNITY BOARD #3       |  59.8400000000000000
 BRONX COMMUNITY BOARD #4       |  38.6133333333333333
 BRONX COMMUNITY BOARD #5       |  40.1550000000000000
 BRONX COMMUNITY BOARD #6       |  39.0000000000000000
 BRONX COMMUNITY BOARD #7       |  48.0166666666666667
 BRONX COMMUNITY BOARD #8       | 375.3300000000000000
 BRONX COMMUNITY BOARD #9       |  40.2433333333333333
 BRONX DISTRICT ATTORNEY        |  46.6437437437437437
 BROOKLYN COMMUNITY BOARD #1    |  51.0550000000000000
 BROOKLYN COMMUNITY BOARD #10   |  53.7300000000000000
 BROOKLYN COMMUNITY BOARD #11   |  44.7450000000000000
 BROOKLYN COMMUNITY BOARD #12   |  40.6850000000000000
 BROOKLYN COMMUNITY BOARD #13   |  28.4300000000000000
 BROOKLYN COMMUNITY BOARD #14   |  46.5150000000000000
 BROOKLYN COMMUNITY BOARD #15   |  28.8833333333333333
 BROOKLYN COMMUNITY BOARD #16   |  41.5950000000000000
 BROOKLYN COMMUNITY BOARD #17   |  30.1075000000000000
 BROOKLYN COMMUNITY BOARD #18   |  40.4933333333333333
 BROOKLYN COMMUNITY BOARD #2    |  28.7650000000000000
 BROOKLYN COMMUNITY BOARD #3    |  37.6033333333333333
 BROOKLYN COMMUNITY BOARD #4    |  33.3633333333333333
 BROOKLYN COMMUNITY BOARD #5    |  34.6100000000000000
 BROOKLYN COMMUNITY BOARD #6    | 138.2966666666666667
 BROOKLYN COMMUNITY BOARD #7    |  38.4766666666666667
 BROOKLYN COMMUNITY BOARD #8    |  34.7633333333333333
 BROOKLYN COMMUNITY BOARD #9    |  26.4400000000000000
 BUSINESS INTEGRITY COMMISSION  |  46.2798750000000000
 CAMPAIGN FINANCE BOARD         |  58.1144444444444444
 CITY CLERK                     |  36.9577419354838710
 CITY COUNCIL                   | 117.5808529411764706
 CIVIL SERVICE COMMISSION       |  43.0712500000000000
 CIVILIAN COMPLAINT REVIEW BD   |  95.2079651162790698
 COMMUNITY COLLEGE (BRONX)      | 156.7308108108108108
 COMMUNITY COLLEGE (HOSTOS)     | 150.9934991708126036
 COMMUNITY COLLEGE (KINGSBORO)  | 163.2892218350754936
 COMMUNITY COLLEGE (LAGUARDIA)  | 156.9612711111111111
 COMMUNITY COLLEGE (MANHATTAN)  | 179.6027029039463887
 COMMUNITY COLLEGE (QUEENSBORO) | 170.8122600619195046
 CONFLICTS OF INTEREST BOARD    |  54.5926923076923077
 CONSUMER AFFAIRS               |  50.6781585677749361
 CULTURAL AFFAIRS               |  47.2184000000000000
 CUNY CENTRAL OFFICE            |  67.4792857142857143
 DEPARTMENT FOR THE AGING       |  51.4283728813559322
 DEPARTMENT OF BUILDINGS        |  47.7157478772044415
 DEPARTMENT OF BUSINESS SERV.   |  73.7706692913385827
 DEPARTMENT OF CITY PLANNING    |  75.9738983050847458
 DEPARTMENT OF CORRECTION       |  38.8347952577146220
 DEPARTMENT OF EDUCATION ADMIN  |  49.8302817772281601
 DEPARTMENT OF FINANCE          |  47.2557027463651050
 DEPARTMENT OF INVESTIGATION    |  63.2342265193370166
 DEPARTMENT OF PROBATION        |  41.0238981390793340
 DEPARTMENT OF SANITATION       |  37.6445678454411931
 DEPARTMENT OF TRANSPORTATION   |  48.7515439757375241
 DEPT OF CITYWIDE ADMIN SVCS    |  49.0809018143009605
 DEPT OF ED PARA PROFESSIONALS  |  17.3666920046165479
 DEPT OF ED PEDAGOGICAL         |  43.6022304247724056
 DEPT OF ENVIRONMENT PROTECTION |  51.2464109916367981
 DEPT OF HEALTH/MENTAL HYGIENE  |  51.6690856177243710
 DEPT OF INFO TECH & TELECOMM   |  70.1515881561238223
 DEPT OF PARKS & RECREATION     |  39.5411555791147628
 DEPT OF RECORDS & INFO SERVICE |  97.5628333333333333
 DEPT OF YOUTH & COMM DEV SRVS  |  48.6939539748953975
 DEPT. OF DESIGN & CONSTRUCTION |  56.5106485671191554
 DEPT. OF HOMELESS SERVICES     |  40.1919820627802691
 DISTRICT ATTORNEY KINGS COUNTY |  46.1443575418994413
 DISTRICT ATTORNEY QNS COUNTY   |  48.3220326409495549
 DISTRICT ATTORNEY RICHMOND COU |  60.1021052631578947
 DISTRICT ATTORNEY-MANHATTAN    |  61.3899432624113475
 DISTRICT ATTORNEY-SPECIAL NARC |  65.3231162790697674
 EQUAL EMPLOY PRACTICES COMM    |  67.6281818181818182
 FINANCIAL INFO SVCS AGENCY     |  76.1491100702576112
 FIRE DEPARTMENT                |  42.8957896621702280
 GUTTMAN COMMUNITY COLLEGE      | 153.1756886227544910
 HOUSING PRESERVATION & DVLPMNT |  56.9599378606302708
 HRA/DEPT OF SOCIAL SERVICES    |  36.3936006240249610
 HUMAN RIGHTS COMMISSION        |  67.4304347826086957
 HUNTER COLLEGE HIGH SCHOOL     |  57.7179428571428571
 INDEPENDENT BUDGET OFFICE      |  78.3200000000000000
 LANDMARKS PRESERVATION COMM    |  44.8392537313432836
 LAW DEPARTMENT                 |  64.9458913738019169
 MANHATTAN COMMUNITY BOARD #1   |  60.8700000000000000
 MANHATTAN COMMUNITY BOARD #10  |  51.0900000000000000
 MANHATTAN COMMUNITY BOARD #11  |  36.4400000000000000
 MANHATTAN COMMUNITY BOARD #12  |  31.9200000000000000
 MANHATTAN COMMUNITY BOARD #2   |  30.8325000000000000
 MANHATTAN COMMUNITY BOARD #3   |  30.9866666666666667
 MANHATTAN COMMUNITY BOARD #4   |  36.0533333333333333
 MANHATTAN COMMUNITY BOARD #5   |  46.0700000000000000
 MANHATTAN COMMUNITY BOARD #6   |  45.9733333333333333
 MANHATTAN COMMUNITY BOARD #7   |  39.4866666666666667
 MANHATTAN COMMUNITY BOARD #8   |  77.0100000000000000
 MANHATTAN COMMUNITY BOARD #9   |  36.7350000000000000
 MAYORS OFFICE OF CONTRACT SVCS | 114.8834210526315789
 MUNICIPAL WATER FIN AUTHORITY  |  57.0107692307692308
 NYC DEPT OF VETERANS' SERVICES |  60.4508823529411765
 NYC EMPLOYEES RETIREMENT SYS   |  51.1957881773399015
 NYC FIRE PENSION FUND          |  91.9441935483870968
 NYC HOUSING AUTHORITY          |  32.8713589743589744
 NYC POLICE PENSION FUND        |  50.7802919708029197
 OFF OF PAYROLL ADMINISTRATION  |  82.6848000000000000
 OFFICE OF COLLECTIVE BARGAININ |  67.2226666666666667
 OFFICE OF EMERGENCY MANAGEMENT |  65.3062983425414365
 OFFICE OF LABOR RELATIONS      |  65.5994736842105263
 OFFICE OF MANAGEMENT & BUDGET  |  70.8588659793814433
 OFFICE OF THE ACTUARY          |  75.5539024390243902
 OFFICE OF THE COMPTROLLER      |  66.0175067024128686
 OFFICE OF THE MAYOR            | 119.3622319474835886
 POLICE DEPARTMENT              |  39.0594406956384883
 PRESIDENT BOROUGH OF MANHATTAN | 114.5186000000000000
 PUBLIC ADMINISTRATOR-BRONX     |  54.0650000000000000
 PUBLIC ADMINISTRATOR-KINGS     |  41.4192307692307692
 PUBLIC ADMINISTRATOR-NEW YORK  |  39.4400000000000000
 PUBLIC ADMINISTRATOR-QUEENS    |  40.6825000000000000
 PUBLIC ADMINISTRATOR-RICHMOND  |  56.1380000000000000
 PUBLIC ADVOCATE                |  50.6537837837837838
 QUEENS COMMUNITY BOARD #1      |  34.4750000000000000
 QUEENS COMMUNITY BOARD #10     |  34.3733333333333333
 QUEENS COMMUNITY BOARD #11     |  39.6750000000000000
 QUEENS COMMUNITY BOARD #12     |  34.3000000000000000
 QUEENS COMMUNITY BOARD #13     |  39.8300000000000000
 QUEENS COMMUNITY BOARD #14     |  54.7600000000000000
 QUEENS COMMUNITY BOARD #2      |  36.5333333333333333
 QUEENS COMMUNITY BOARD #3      |  34.0300000000000000
 QUEENS COMMUNITY BOARD #4      |  39.1066666666666667
 QUEENS COMMUNITY BOARD #5      |  41.1650000000000000
 QUEENS COMMUNITY BOARD #6      |  45.0650000000000000
 QUEENS COMMUNITY BOARD #7      |  35.3100000000000000
 QUEENS COMMUNITY BOARD #8      |  36.2400000000000000
 QUEENS COMMUNITY BOARD #9      |  28.3200000000000000
 STATEN ISLAND COMMUNITY BD #1  |  37.9600000000000000
 STATEN ISLAND COMMUNITY BD #2  |  51.7900000000000000
 STATEN ISLAND COMMUNITY BD #3  |  41.6833333333333333
 TAX COMMISSION                 |  87.1541025641025641
 TAXI & LIMOUSINE COMMISSION    |  49.3818893129770992
 TEACHERS RETIREMENT SYSTEM     |  52.4914985590778098

```

```
###8. now, using the same grouping query or creating another one, find a way to filter the query results based on the values for the groups 

          agency_name           |  average_hourly_pay  
--------------------------------+----------------------
 BOROUGH PRESIDENT-QUEENS       |  60.4852727272727273
 BRONX COMMUNITY BOARD #8       | 375.3300000000000000
 BROOKLYN COMMUNITY BOARD #6    | 138.2966666666666667
 CITY COUNCIL                   | 117.5808529411764706
 CIVILIAN COMPLAINT REVIEW BD   |  95.2079651162790698
 COMMUNITY COLLEGE (BRONX)      | 156.7308108108108108
 COMMUNITY COLLEGE (HOSTOS)     | 150.9934991708126036
 COMMUNITY COLLEGE (KINGSBORO)  | 163.2892218350754936
 COMMUNITY COLLEGE (LAGUARDIA)  | 156.9612711111111111
 COMMUNITY COLLEGE (MANHATTAN)  | 179.6027029039463887
 COMMUNITY COLLEGE (QUEENSBORO) | 170.8122600619195046
 CUNY CENTRAL OFFICE            |  67.4792857142857143
 DEPARTMENT OF BUSINESS SERV.   |  73.7706692913385827
 DEPARTMENT OF CITY PLANNING    |  75.9738983050847458
 DEPARTMENT OF INVESTIGATION    |  63.2342265193370166
 DEPT OF INFO TECH & TELECOMM   |  70.1515881561238223
 DEPT OF RECORDS & INFO SERVICE |  97.5628333333333333
 DISTRICT ATTORNEY RICHMOND COU |  60.1021052631578947
 DISTRICT ATTORNEY-MANHATTAN    |  61.3899432624113475
 DISTRICT ATTORNEY-SPECIAL NARC |  65.3231162790697674
 EQUAL EMPLOY PRACTICES COMM    |  67.6281818181818182
 FINANCIAL INFO SVCS AGENCY     |  76.1491100702576112
 GUTTMAN COMMUNITY COLLEGE      | 153.1756886227544910
 HUMAN RIGHTS COMMISSION        |  67.4304347826086957
 INDEPENDENT BUDGET OFFICE      |  78.3200000000000000
 LAW DEPARTMENT                 |  64.9458913738019169
 MANHATTAN COMMUNITY BOARD #1   |  60.8700000000000000
 MANHATTAN COMMUNITY BOARD #8   |  77.0100000000000000
 MAYORS OFFICE OF CONTRACT SVCS | 114.8834210526315789
 NYC DEPT OF VETERANS' SERVICES |  60.4508823529411765
 NYC FIRE PENSION FUND          |  91.9441935483870968
 OFF OF PAYROLL ADMINISTRATION  |  82.6848000000000000
 OFFICE OF COLLECTIVE BARGAININ |  67.2226666666666667
 OFFICE OF EMERGENCY MANAGEMENT |  65.3062983425414365
 OFFICE OF LABOR RELATIONS      |  65.5994736842105263
 OFFICE OF MANAGEMENT & BUDGET  |  70.8588659793814433
 OFFICE OF THE ACTUARY          |  75.5539024390243902
 OFFICE OF THE COMPTROLLER      |  66.0175067024128686
 OFFICE OF THE MAYOR            | 119.3622319474835886
 PRESIDENT BOROUGH OF MANHATTAN | 114.5186000000000000
 TAX COMMISSION                 |  87.1541025641025641
```

```
###9.Count how many employees are in each location, and then order them in a descending fashion
   location    | num_employees 
---------------+---------------
 MANHATTAN     |        181399
 QUEENS        |         44015
 BROOKLYN      |         37648
 BRONX         |         20892
 OTHER         |          7521
 RICHMOND      |          5561
 WESTCHESTER   |           479
 ULSTER        |           279
 SULLIVAN      |           110
 DELAWARE      |            77
 PUTNAM        |            35
 SCHOHARIE     |            27
 NASSAU        |            18
 ALBANY        |            11
 DUTCHESS      |            10
 GREENE        |             7
 WASHINGTON DC |             6
 ORANGE        |             1

```

```
###10. Get the depts with the top 10 most average total hours worked during the FY 2018

          agency_name          | average_hours 
-------------------------------+---------------
 DEPARTMENT OF SANITATION      |       2304.93
 FIRE DEPARTMENT               |       2285.61
 DEPARTMENT OF CORRECTION      |       2210.41
 POLICE DEPARTMENT             |       2173.83
 DEPT OF ED PEDAGOGICAL        |       2087.00
 DEPT OF ED PARA PROFESSIONALS |       2087.00
 NYC HOUSING AUTHORITY         |       2004.73
 BOARD OF ELECTION             |       2000.13
 DEPARTMENT OF TRANSPORTATION  |       1937.02
 DEPT OF CITYWIDE ADMIN SVCS   |       1921.88
```


```
###11. Get the top 10 departments with the most total gross payroll (not base)
          agency_name          | total_payroll 
-------------------------------+---------------
 DEPT OF ED PEDAGOGICAL        | 8206203140.88
 POLICE DEPARTMENT             | 4764996522.17
 FIRE DEPARTMENT               | 1720228274.11
 DEPARTMENT OF CORRECTION      | 1040109328.15
 DEPT OF ED PARA PROFESSIONALS |  909034281.64
 DEPARTMENT OF SANITATION      |  855112647.97
 DEPARTMENT OF EDUCATION ADMIN |  767827800.87
 HRA/DEPT OF SOCIAL SERVICES   |  751466567.12
 ADMIN FOR CHILDREN'S SVCS     |  463052022.56
 NYC HOUSING AUTHORITY         |  461242973.82
```

```
###12. How many unique job titles are there
 num_job_titles 
----------------
           1243
```





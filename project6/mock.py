from sqlalchemy.orm import sessionmaker
import db
from model import Company, ScooterType, Scooter, Base
from datetime import datetime
import random

Session = sessionmaker(db.engine)
session = Session()

# use the session object and imported classes (Company, Scooter, etc.)
# ... to create companies, types and scooters in the database

c1 = Company()
c1.name='Super Fast Co',
c1.website='superfast.lol',
c1.founded=2017


c2 = Company(
    name='Scootz LTD',
    website='scootz.jp',
    founded=2000 
)

c3 = Company(
	name='Scooty',
	website='scooty.nyu',
	founded=1997
)

st1 = ScooterType(
    model='Scoot Lite v2',
    max_range=100,
    weight=10,
    max_speed=30,
    company=c1
)

st2 = ScooterType(
    model='Fast One v1',
    max_range=50,
    weight=15,
    max_speed=50,
    company=c1
)

st3 = ScooterType(
    model='The Crazy',
    max_range=20,
    weight=5,
    max_speed=100,
    company=c1
)

st4 = ScooterType(
    model='MF Doom v5',
    max_range=99,
    weight=20,
    max_speed=45,
    company=c2
)

st5 = ScooterType(
    model='A tribe called quest v7',
    max_range=85,
    weight=10,
    max_speed=35,
    company=c2
)

st6 = ScooterType(
    model='shaolin shadowboxer v2',
    max_range=100,
    weight=25,
    max_speed=40,
    company=c2
)

st7 = ScooterType(
    model='relaxer v8',
    max_range=150,
    weight=15,
    max_speed=25,
    company=c3
)

st8 = ScooterType(
    model='the tourist v3',
    max_range=55,
    weight=18,
    max_speed=27,
    company=c3
)

scooters = []

for i in range(70):

	s = Scooter()
	s.acquired_date = f'{random.randint(2014,2018)}-{random.randint(1, 12):02}-{random.randint(1,28):02}'
	s.retired = False
	s.scooter_type = random.choice([st1, st2, st3, st4, st5, st6, st7, st8])
	
	scooters.append(s)

# session.add_all(scooters)
# session.commit()

companies = session.query(Company)
for c in companies:
 print(f'The company, {c}, has the following scooter models:');
 for i, scooter_type in enumerate(c.scooter_types):
  print(i, scooter_type)
 print('\n')


session.close()

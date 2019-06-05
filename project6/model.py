# columns and their types, including fk relationships
from sqlalchemy import Column, Integer, String, Date, Boolean
from sqlalchemy import ForeignKey
from sqlalchemy.orm import relationship

# declarative base 
from sqlalchemy.ext.declarative import declarative_base

# create the base class (declarative base)
# call it Base!
Base = declarative_base()

# implement the following three classes...

class Scooter(Base):
	__tablename__ = 'scooter'
	scooter_id = Column('scooter_id', Integer, primary_key=True)
	acquired_date = Column('acquired_date', Date)
	retired = Column('retired', Boolean)
	scooter_type_id = Column('scooter_type_id', Integer, ForeignKey("scooter_type.scooter_type_id"))
	scooter_type = relationship('ScooterType', back_populates='scooter')

	def __str__(self):

		return f'{self.scooter_id} {self.retired} {self.scooter_type} {self.acquired_date}'

	def __repr__(self):

		return self.__str__()

	def to_dict(self):

		d = {"acquired_date": self.acquired_date.strftime('%Y-%m-%d'), "retired": self.retired, 
			"scooter_type": self.scooter_type.model, "max_speed": self.scooter_type.max_speed,
			"weight": self.scooter_type.weight, "manufacturer": self.scooter_type.company.name,
			"website": self.scooter_type.company.website}

		return d



class ScooterType(Base):
	__tablename__ = 'scooter_type'
	scooter_type_id = Column('scooter_type_id', Integer, primary_key=True)
	model = Column('model', String)
	max_range = Column('max_range', Integer)
	weight= Column('weight', Integer)
	max_speed = Column('max_speed', Integer)
	company_id = Column('company_id', Integer, ForeignKey("company.company_id"))
	company = relationship('Company', back_populates='scooter_types')
	scooter = relationship('Scooter', back_populates='scooter_type')

	def __str__(self):
		return f'{self.company} {self.model}: max speed is {self.max_speed}, weight is {self.weight}'
	
	def __repr__(self):
		return self.__str__()

class Company(Base):
	__tablename__ = 'company'
	company_id = Column('company_id', Integer, primary_key=True)
	name = Column('name', String)
	website = Column('website', String)
	founded = Column('founded', Integer)
	scooter_types = relationship('ScooterType', back_populates='company') 

	def __str__(self):
		return f'{self.name}, {self.website} ({self.founded})'

	def __repr__(self):
		return self.__str__()


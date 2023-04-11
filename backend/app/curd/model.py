from .sqlconfig import Base, SessionLocal
from sqlalchemy import Column, Integer, String, Boolean, DateTime, ForeignKey,JSON

class DataSource(Base):
    __tablename__ = "datasource"
    datasourceid = Column(Integer, primary_key=True, index=True)
    config = Column(JSON)

class Chart(Base):
    __tablename__ = "chart"
    chartid = Column(Integer, primary_key=True, index=True)
    config = Column(JSON)

class Dashboard(Base):
    __tablename__ = "dashboard"
    dashboardid = Column(Integer, primary_key=True, index=True)
    config = Column(JSON)

class DataSet(Base):
    __tablename__ = "dataset"
    datasetid = Column(Integer, primary_key=True, index=True)
    datasource_id = Column(Integer, ForeignKey("datasource.datasourceid"))
    database = Column(String)
    table = Column(String)
    query = Column(String)
    example_row = Column(JSON)
    


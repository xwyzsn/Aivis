from pydantic import BaseModel
from typing import List,Union,Dict

class DataSource(BaseModel):
    datasourceid: int
    config: dict

    class Config:
        orm_mode = True

class Chart(BaseModel):
    chartid: int
    config: dict

    class Config:
        orm_mode = True


class Dashboard(BaseModel):
    dashboardid: int
    config: dict

    class Config:
        orm_mode = True
        
class Bootstrap(BaseModel):
    datasource: List[DataSource]
    chart: List[Chart]
    dashboard: List[Dashboard]

    class Config:
        orm_mode = True

class DataSourceConfig:
    def __init__(self,config:dict):
        print(config)
        self.host = config['host']
        self.port = config['port'] 
        self.user = config['user']
        self.password = config['password']
        self.type = config['type'] 
        self.database = config['database']
        self.table = config.get('table',None)
        self.query = config.get('query',None)


class DataSetConfig:
    def __init__(self,datasource_id:int,database:str,table:str,
                 query:str,example_row: Union [Dict , None]):
        self.datasource_id = datasource_id
        self.database = database
        self.table = table
        self.query = query
        self.example_row = example_row

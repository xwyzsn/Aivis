from fastapi import APIRouter, Depends,HTTPException
import json
from ..curd.service import datasrc_meta

router = APIRouter(prefix="/datasrc", tags=["datasrc"])
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


@router.post("/meta")
def get_meta(datameta:DataSourceConfig = Depends(DataSourceConfig)):
    try:
        meta = datasrc_meta.show_meta(datameta)
        print(meta)
        return meta
    except Exception as e :
        raise HTTPException(status_code=500,detail=str(e)+'get meta failed')

@router.post("/execquery")
def exec_query(datameta:DataSourceConfig = Depends(DataSourceConfig)):
    try:
        meta = datasrc_meta.exec_sql(datameta)
        return meta
    except Exception as e :
        raise HTTPException(status_code=500,detail=str(e)+'something wrong with your sql query')
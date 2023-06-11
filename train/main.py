import uuid

import uvicorn
from fastapi import FastAPI
from typing import Dict,List
from pydantic import BaseModel
from curd.db_setting import Datasrc
from fastapi.middleware import Middleware
from fastapi.middleware.cors import CORSMiddleware
import threading
from threading import Thread
from utils import COLS, exec_cmd, MODELS
import requests

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class train_request(BaseModel):
    model_name:str
    config: Dict | None
    dataset: Dict | None
    mapping: List | None


@app.post("/train")
def train_model(request: train_request):
    dataset = request.dataset
    print(dataset,type(dataset))
    data_src = dataset['config']
    msg = {"code": 200, "data": {"host": data_src['host'], "port": data_src['port'],
                                 "user": data_src['user'], "password": data_src['password'],
                                 "database": data_src['database'], "table_name": None}}
    try:
        print("=====try segment")
        table_name = uuid.uuid4().hex
        database_connection = Datasrc(host=data_src['host'], port=int(data_src['port']),
                                      user=data_src['user'], password=data_src['password'],
                                      database=data_src['database'],
                                      table_name=table_name)
        columns = COLS[request.model_name]
        database_connection.create_table(columns)
        script = MODELS[request.model_name]
        #Thread(target=exec_cmd, args=(script,), daemon=True).start()
        msg['data']['table_name'] = table_name

    # datasets = {
    #     "query":"select * from ETTh2",
    #     "example_row":None,
    #     "config":{
    #         "host": data_src['host'],
    #         "port": data_src['port'],
    #         "user": data_src['user'],
    #         "password": data_src['password'],
    #         "database": data_src['database'],
    #         "query":"select * from ETTh2",
    #     },
    # }
        # requests.post("http://localhost:8000/dataset/save", json=msg)
    except Exception as e:
        print("err",e)
        msg['code'] = 500
        msg['data']= None
    return msg


if __name__ == '__main__':
    uvicorn.run(app, port=5678)

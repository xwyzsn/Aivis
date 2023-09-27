import json
import uuid

import uvicorn
from fastapi import FastAPI, Request
from typing import Dict, List
from pydantic import BaseModel
from curd.db_setting import Datasrc
from fastapi.middleware import Middleware
from fastapi.middleware.cors import CORSMiddleware
import threading
from threading import Thread
from utils import COLS, exec_cmd, MODELS
import requests
from Trainer import Trainer


class triformer(Trainer):
    def __init__(self, model, config):
        super().__init__(model, config)

    def start_train(self):
        print("start train")

    def get_predict(self):
        print("get predict")

    def write_to_db(self, config):
        pass


app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


class train_request(BaseModel):
    model_name: str
    config: Dict | None
    dataset: Dict | None
    mapping: List | None


"""
cnf参数如下
{"model_name":"triformer", 
“predict”：false,
"dataset": {"datasetid":10,"query":"select * from ETTh1 limit 
10;\n\n\n\n\n\n\n\n\n\n\n\n\n\n","config":{"host":"113.31.110.212","port":"3306","user":"root","password":"zzh0117.",
"type":"mysql","database":"db11","query":"select * from ETTh1 limit 10;\n\n\n\n\n\n\n\n\n\n\n\n\n\n"},
"example_row":{
"date":"2016-07-01 00:00:00","HUFL":"5.827000141143799","HULL":"2.009000062942505","MUFL":"1.5989999771118164",
"MULL":"0.4620000123977661","LUFL":"4.203000068664552","LULL":"1.3400000333786009","OT":"30.5310001373291"},
"dataset_name":"ETTH1"},
"mapping":[{"value":"date","label":"x","type":"select","desc":"横坐标,用于表示时序","axis":"date"},{"value":"X","label":"y_true","type":"select","desc":"纵坐标,用于表示实际值","axis":"HUFL"}],
"config":{}}
"""


@app.get("/train")
async def train_model(cnf: str):
    request = json.loads(cnf)
    dataset = request['dataset']
    print(dataset, type(dataset))
    data_src = dataset['config']
    msg = {"code": 200, "data": {"host": data_src['host'], "port": data_src['port'],
                                 "user": data_src['user'], "password": data_src['password'],
                                 "database": data_src['database'], "table_name": None}}
    try:
        table_name = uuid.uuid4().hex
        database_connection = Datasrc(host=data_src['host'], port=int(data_src['port']),
                                      user=data_src['user'], password=data_src['password'],
                                      database=data_src['database'],
                                      table_name=table_name)
        columns = COLS[request['model_name']]
        database_connection.create_table(columns)
        script = MODELS[request['model_name']]

        # if not  request['predict']: ## 此外记得区分训练和预测

        # TODO:// 你也可以用线程或者进程执行,不然会阻塞！！！！！记得，记得训练的结果需要写入数据库
        # await triformer.start_train() # 训练，记得别阻塞！！！！

        # Thread(target=exec_cmd, args=(script,), daemon=True).start() # 可以把这个写到start_train里面

        # TODO:// 模型的结果要记得写入数据库记得别阻塞！！！！,
        # 此外你可以把write_to_db写在start_train里面，
        # 这样就不用再写一个线程了，因为模型的输出的时间是很长的，所以最好是写在start_train里面
        # 但是记得别阻塞！！！！
        # triformer.write_to_db()
        #
        #
        # 下面是一个fake example，忽略就好
        # cols = [item[0] for item in columns]
        # database_connection.insert_into(cols, values=triformer.get_fake(['datetime', 'float', 'float'], 100), types=
        # ['datetime', 'float', 'float'])


        # 返回结果表名
        msg['data']['table_name'] = table_name

    except Exception as e:
        print("err", e)
        msg['code'] = 500
        msg['data'] = None
    return msg


if __name__ == '__main__':
    uvicorn.run(app, port=5678)

import json
import os
import pandas as pd
import numpy as np
from fastapi import FastAPI
# CORS
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
# base_path = "/app/data/"
base_path="G:/desktop/八钢-120吨-1#连铸机电机数据/data"

@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/hello/{name}")
async def say_hello(name: str):
    return {"message": f"Hello {name}"}


@app.get('/files')
async def get_dir():
    files = os.listdir(f"{base_path}")
    return files


@app.get('/file/')
async def get_csv_meta(name: str, per_page: int):
    data = pd.read_csv(f"{base_path}/{name}")
    print(data.head())

    types = data.dtypes.to_dict()
    types = {k: str(v) for k, v in types.items()}
    size = len(data)
    per_page = per_page
    pages = size // per_page
    return json.dumps({"size": size, "pages": pages, "per_page": per_page, **types})


@app.get('/data/')
async def get_csv(name: str, cnt: int, per_page: int, x: str, y: str):
    per_page = per_page
    data = pd.read_csv(f"{base_path}/{name}")
    x,y = x.split('_')[0],y.split('_')[0]
    data_x = data[x]
    data_y = data[y].fillna(0)
    _x = data_x.iloc[cnt * per_page: (cnt + 1) * per_page]
    _y = data_y.iloc[cnt * per_page: (cnt + 1) * per_page]
    return json.dumps({"x": _x.tolist(), "y": _y.tolist()})


@app.get('/get_file_by_range/')
async def get_file_by_range(name: str, l: int, r: int, x: str, y: str):
    data = pd.read_csv(f"{base_path}/{name}.csv")
    x,y = x.split('_')[0],y.split('_')[0]
    data_x = data[x]
    data_y = data[y].fillna(0)
    try:
        _x = data_x.iloc[l:r]
        _y = data_y.iloc[l:r]
    except Exception as e:
        return {"msg": e, "status": 500}
    return json.dumps({"x": _x.tolist(), "y": _y.tolist()})

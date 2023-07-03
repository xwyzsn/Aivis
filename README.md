# Introduction

## scaffold

> app: backend of this project,you may ignore this directory
> 
> front-endv2/front-endv2: frontend of this project,we use vue3 to build the frontend,
> and you can customize your chart. We use `echarts` as our chart library.
> 
> src: deprecated,(useless)
> 
> train:A minimal example of how to add a new algorithm into the system
> 

## setup
### development setup
prerequisite： `python3.10`,`node.js`,`npm or pnpm`,`pip`

### backend 
```shell
cd app && pip install -r requirements.txt
uvicorn main:app --reload
```

### frontend
```shell
cd front-endv2/front-endv2
pnpm install && pnpm run dev # or npm install && npm run dev
```
once you have done this, you can visit `http://localhost:5173` to see the website


### production setup
- [ ] docker image ask wanghe to build

## add a new Algorithm into the system
### add to DB 
In this system, we use `Pogress` as our database.

> host: 113.31.110.212
> 
> database: al
> 
> user:zzh
> 
> password:zzh0117.
> 
> port:5432
>
>
> 
Once you connection to the database,go to the `model` table,
add the specific information of the algorithm into the table (`using json format`)
you can see the example in the table. We  stored the training config in the table,
besides the training config, you also need to provide other information.

(e.g.,
```json
// input is the input of the chart,We mapping the use column to the chart input
// label will be shown in the frontend
// type is the type of the input, we support `select` and `input` now
// desc is the description of the input
// example is the example of what your model do.e.g.,a anomaly detect model can be shown via a line chart (we called TSL,now we noly support one chart)
// dataset is the database where the example data stored
// `mapping`: mapping the column of the dataset to the input of the chart
"input": [
        {
            "value": "date", 
            "label": "x",
            "type": "select",
            "desc": "横坐标,用于表示时序"
        },
        {
            "value": "X",
            "label": "y_true",
            "type": "select",
            "desc": "纵坐标,用于表示实际值"
        }
    ],
    "example": {
        "type": "TSL",
        "dataset": {
            "config": {
                "host": "113.31.110.212",
                "port": "5432",
                "user": "zzh",
                "password": "zzh0117.",
                "type": "psql",
                "database": "al",
                "query": "\nselect * from test;\n\n\n\n\n\n\n\n\n\n\n\n\n"
            }
        },
        "mapping": {
            "y_pred": "X_predict",
            "y": "X",
            "time": "date"
        }
    }
```
you should specify the config of each model you want to add.


### add your model into service
please see the `train` directory,
there is a `Trainer` class in the `Trainer.py`. You should implement the some function of the class.
in your case you may ignore some of them. But `write_to_db` is necessary,and you should return a object
which contain you output dataset stored in the database.

> 1. start_train: start the training process, the config of the model will be passed
> 2. get_predict: get the predict result of the model
> 3. write_to_db: write the result to the database
>
> 

After you implement the `Trainer` class, you should register your model by specify the running config such as host,port 
we use redis to store the model endpoint information.
you should add the `train url` into redis  like this `set triformer 'http://localhost:5678/train'`
```python
# redis config (do not modify other db)  
r = redis.Redis(host='106.75.239.46', port=6379, decode_responses=True,
                password='zzh0117.', db=1)
```

## TODO
- [ ] add more chart type
- [ ] add more model
- [ ] column mapping in the frontend
- [ ] build and deploy
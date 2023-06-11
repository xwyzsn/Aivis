from fastapi import FastAPI, APIRouter,Depends
from app.curd.schemas import ChartConfig
from app.curd.service.chart_service import get_all_charts, save_chart

router = APIRouter(prefix="/chart", tags=["chart"])


@router.get("/get_all")
def get_all_charts_controller():
    msg = {"code": 200, "data": None}
    try:
        res = get_all_charts()
        msg["data"] = res
    except Exception as e:
        print(e)
        msg["code"] = 500
        msg["data"] = str(e)
    return msg


@router.post("/save")
def save_chart_controller(chart=Depends(ChartConfig)):
    msg = {"code": 200, "data": "success"}
    try:
        print("save")
        save_chart({"config": chart.config, "dataset": chart.dataset,
                    "mapping": chart.mapping})
    except Exception as e:
        print(e)
        msg["code"] = 500
        msg["data"] = str(e)
    return msg

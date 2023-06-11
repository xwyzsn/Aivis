from app.curd.sqlconfig import SessionLocal, engine
from app.curd.model import Chart


def get_all_charts():
    session = SessionLocal()
    return session.query(Chart).all()


def save_chart(chart: dict):
    session = SessionLocal()
    chart = Chart(**chart)
    session.add(chart)
    session.commit()
    session.refresh(chart)
    return chart

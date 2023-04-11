from sqlalchemy.orm import Session
from .. import schemas,model

def get_datasource(db: Session, datasourceid: int):
    return db.query(model.DataSource).filter(model.DataSource.datasourceid == datasourceid).first()

def get_all_datasource(db: Session):
    return db.query(model.DataSource).all()

def bootstrap(db: Session):

    datasource = db.query(model.DataSource).all()
    chart = db.query(model.Chart).all()
    dashboard = db.query(model.Dashboard).all()

    return {"datasource": datasource, "chart": chart, "dashboard": dashboard}




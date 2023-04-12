from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker,Session
from sqlalchemy.ext.declarative import declarative_base
from .. import schemas,model
SQLALCHEMY_DATABASE_URL = "postgresql://zzh:zzh0117.@113.31.110.212/al"

engine = create_engine(SQLALCHEMY_DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

def save_dataset(dataset_config:schemas.DataSetConfig):
    db = SessionLocal()
    db_dataset = model.DataSet(**dataset_config.__dict__)
    db.add(db_dataset)
    db.commit()
    db.refresh(db_dataset)
    db.close()
    return db_dataset
    
def get_all_dataset():
    db = SessionLocal()
    db_dataset = db.query(model.DataSet).all()
    db.close()
    return db_dataset

def get_dataset(datasetid:int):
    db = SessionLocal()
    db_dataset = db.query(model.DataSet).filter(model.DataSet.datasetid == datasetid).first()
    db.close()
    return db_dataset

from fastapi import FastAPI,Depends
from fastapi.middleware.cors import CORSMiddleware
from router import dashboard, datasource,datasrc_meta_controlloer,dataset_controller,model_controller
from curd.service import curd
from curd.sqlconfig import SessionLocal, engine
from curd import model,schemas

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(dashboard.router)
app.include_router(datasource.router)
app.include_router(datasrc_meta_controlloer.router)
app.include_router(dataset_controller.router)
app.include_router(model_controller.router)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()



@app.get("/bootstrap", response_model=schemas.Bootstrap)
def bootstrap(db: SessionLocal = Depends(get_db)):
    return   curd.bootstrap(db)


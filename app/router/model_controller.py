from fastapi import APIRouter, Depends, HTTPException
from app.curd.service.model_serivce import get_all_model

router = APIRouter(prefix="/model",tags=["model"])

@router.get("getall")
def get_all():
    return get_all_model()
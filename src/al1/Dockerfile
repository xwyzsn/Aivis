FROM python:3.9

WORKDIR /app


COPY . .

RUN python3 -m pip install --no-cache-dir --upgrade -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple  && mkdir data

EXPOSE 10001
# 6、运行服务
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
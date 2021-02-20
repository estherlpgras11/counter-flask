FROM python:3.7-alpine AS build
WORKDIR /code
RUN apk add --no-cache gcc musl-dev linux-headers
COPY requirements.txt requirements.txt

FROM python:3.7-alpine
COPY --from=build /code /code
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV REDIS_HOST=redis
ENV REDIS_PASSWORD=default
ENV REDIS_PORT=6379
RUN pip install -r /code/requirements.txt
# RUN export GOOGLE_APPLICATION_CREDENTIALS=/Users/esther/DevOps/Bootcamp/MODULO4-Docker_k8s/practica_contenedores/flask/key.json
COPY . /code
CMD ["flask", "run"]
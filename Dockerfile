FROM python:3.7-alpine AS compile-image
WORKDIR /code
ENV FLASK_APP app.py
ENV FLASK_RUN_HOST 0.0.0.0
RUN apk add --no-cache gcc musl-dev linux-headers
COPY requirements.txt requirements.txt


FROM python:3.7-alpine AS build-image
COPY --from=compile-image /code /code
RUN pip install --user -r /code/requirements.txt
COPY . .
CMD ["flask", "run"]
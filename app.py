import time

import redis
from flask import Flask

import json_logging, logging, sys

from prometheus_client import start_http_server, Counter


import os

# Set environment variables
REDIS_HOST = os.environ['REDIS_HOST']
REDIS_PASSWORD = os.environ['REDIS_PASSWORD']

app = Flask(__name__)

# intialize logger
json_logging.init_flask(enable_json=True)
json_logging.init_request_instrument(app)
logger = logging.getLogger("flask-counter")
logger.setLevel(logging.DEBUG)
logger.addHandler(logging.StreamHandler(sys.stdout))

cache = redis.Redis(host=REDIS_HOST, port=6379, password=REDIS_PASSWORD)

start_http_server(8000)

c = Counter("redis_calls", "Number of calls to redis", ["status"])


def get_hit_count():
    retries = 5
    while True:
        try:
            hits = cache.incr('hits')
            c.labels(status="success").inc()
            return hits
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                c.labels(status="failure").inc()
                raise exc
            retries -= 1
            time.sleep(0.5)


@app.route('/')
def hello():
    count = get_hit_count()
    message = 'Hello Keepcoding! I have been seen {} times.\n'.format(count)
    with open("log.txt","a+") as fo:
        fo.write(message)
    
    return message

@app.route('/health/live')
def health_live():
    return "Ok"

@app.route('/health/ready')
def health_ready():
    return "Ok"


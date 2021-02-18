#!/bin/bash

docker build -t eu.gcr.io/kainight/flask:v1.1 .
docker push eu.gcr.io/kainight/flask:v1.1
#!/bin/bash

docker build -t eu.gcr.io/kainight/counter-flask:v1.0 .
docker push eu.gcr.io/kainight/counter-flask:v1.0
#!/bin/bash
docker build -t flask .
docker network create practice
docker run -d --name redis --network practice redis
docker run -ti --rm -p 5000:5000 --network practice -v $(pwd)/log.txt:/log.txt flask
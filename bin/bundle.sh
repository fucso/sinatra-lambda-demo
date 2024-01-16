#!/bin/bash

docker build -t sinatra-lambda-ruby -f container/app/Dockerfile .
docker run --rm -v "$PWD":/usr/src/app -it sinatra-lambda-ruby container/app/bundle.sh
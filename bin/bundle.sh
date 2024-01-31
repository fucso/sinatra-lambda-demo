#!/bin/bash

docker run --rm -v "$PWD":/usr/src/app -it sinatra-lambda-ruby container/app/bundle.sh
#!/bin/bash

function cleanup {
  echo "Stopping SAM Local..."
  if kill -0 $SAM_PID > /dev/null 2>&1; then
    kill -SIGTERM $SAM_PID
    # Wait for the process to exit
    wait $SAM_PID
  fi

  echo "Stopping PostgreSQL container..."
  docker stop sinatra-lambda-db

  exit 0
}

trap cleanup SIGINT

db_dir="$(pwd)/container/db"
data_dir="${db_dir}/data"
if [ ! -d "$data_dir" ]; then
    echo "Creating PostgreSQL data directory..."
    mkdir -p "$data_dir"
fi

docker run \
  --name sinatra-lambda-db \
  -e POSTGRES_USER=sinatra-lambda-demo \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=sinatra-lambda-demo \
  -v "${data_dir}":/var/lib/postgresql/data \
  -v "${db_dir}/init":/docker-entrypoint-initdb.d \
  -p 5432:5432 \
  -d --rm \
  postgres

sam local start-api --env-vars env.json --parameter-overrides PGLayerContentUri=".aws-sam/build/PGLayer/lib" &
SAM_PID=$!
echo "SAM Local started with PID $SAM_PID"

wait $SAM_PID
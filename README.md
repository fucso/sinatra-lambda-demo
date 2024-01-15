# Dev
## setup
### install sam

```
brew install aws-sam-cli
```

### bundle install

If you don't have the required Ruby version installed on your host machine, you can run `bundle install` in a Docker container.

```
docker run --rm -v "$PWD":/var/task -w /var/task -it public.ecr.aws/sam/build-ruby3.2:latest-x86_64 container/bundle.sh
```

### DB console

```
docker exec -it sinatra-lambda-db psql -U sinatra-lambda-demo -d sinatra-lambda-demo
```

## run

Hot reload is supported.

```
sam local start-api
```

# Note

This repository is forked from [serverless-sinatra-sample](https://github.com/aws-samples/serverless-sinatra-sample).
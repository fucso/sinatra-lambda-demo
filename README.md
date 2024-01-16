# Dev
## setup
### install sam

```
brew install aws-sam-cli
```

### bundle install

```
bin/bundle.sh
```

### DB console

```
docker exec -it sinatra-lambda-db psql -U sinatra-lambda-demo -d sinatra-lambda-demo
```

## run

Hot reload is supported.

```
bin/dev.sh
```

# Note

This repository is forked from [serverless-sinatra-sample](https://github.com/aws-samples/serverless-sinatra-sample).
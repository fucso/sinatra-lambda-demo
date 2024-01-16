# command
## setup
### install sam

```
brew install aws-sam-cli
```

### bundle install

```
bin/bundle.sh
```

## dev
### start

Hot reload is supported.

```
bin/dev.sh
```

### DB console

```
docker exec -it sinatra-lambda-db psql -U sinatra-lambda-demo -d sinatra-lambda-demo
```

### build

When Lambda Layer updated, use this command to build layers and update template.yaml. 

```
bin/build.sh
```

# Note

This repository is forked from [serverless-sinatra-sample](https://github.com/aws-samples/serverless-sinatra-sample).
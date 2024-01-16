FROM ruby:3.2-slim

WORKDIR /usr/src/app

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev

RUN gem install bundler

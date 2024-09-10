FROM ruby:3.1.2-alpine

RUN apk add --no-cache --virtual .build-deps build-base \
  && apk add --no-cache bash

WORKDIR /action

COPY Gemfile Gemfile.lock /action/

RUN bundle install --jobs=4 --retry=3

COPY lib /action/lib

RUN apk del .build-deps

CMD ["ruby", "/action/lib/index.rb"]
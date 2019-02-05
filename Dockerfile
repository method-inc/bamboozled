FROM ruby:2.5

WORKDIR /app
COPY . /app

RUN gem install bundler
RUN bundle install
FROM ruby:2.5

ENV APP_HOME /app
RUN apt-get update -qq && apt-get install -y build-essential
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME/
RUN bundle install
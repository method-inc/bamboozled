FROM ruby:2.5

LABEL "com.github.actions.name"="Bamboozled Action"
LABEL "com.github.actions.description"="Assists in actions for bamboozled"
LABEL "com.github.actions.icon"="mic"
LABEL "com.github.actions.color"="red"

WORKDIR /app
COPY . /app

RUN gem install bundler
RUN bundle install
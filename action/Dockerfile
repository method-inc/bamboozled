FROM ruby:2.5

LABEL "com.github.actions.name"="Bamboozled CI"
LABEL "com.github.actions.description"="Tests and lints this gem"
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="red"

LABEL "repository"="http://github.com/skookum/bamboozled"
LABEL "homepage"="http://github.com/skookum/bamboozled"
LABEL "maintainer"="Skookum"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
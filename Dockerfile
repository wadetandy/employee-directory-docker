FROM ruby:2.4

ARG GEMSERVER

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/

ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
  BUNDLE_JOBS=10 \
  BUNDLE_PATH=/bundle

RUN bundle install

COPY . .
COPY config/database.docker.yml $APP_HOME/config/database.yml

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0"]

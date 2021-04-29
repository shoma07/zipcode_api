FROM ruby:3.0.1-alpine
LABEL maintainer="23730734+shoma07@users.noreply.github.com"

ENV RAILS_ENV="production" \
    RAILS_LOG_TO_STDOUT="true"

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock /usr/src/app/
RUN apk add --no-cache --virtual=build-dependencies build-base && \
    apk add --no-cache libxml2-dev libxslt-dev sqlite-dev tzdata && \
    bundle install -j4 && \
    apk del --purge build-dependencies

COPY . /usr/src/app/
RUN bin/rails tmp:create db:migrate db:seed

CMD ["pumactl","start"]
EXPOSE 3000

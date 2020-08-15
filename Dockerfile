FROM ruby:2.7.1-alpine
LABEL maintainer="shoma07"

ENV RAILS_ENV="production" \
    RAILS_LOG_TO_STDOUT="true"

COPY . /usr/src/app/
WORKDIR /usr/src/app
RUN apk add --no-cache --virtual=build-dependencies build-base && \
    apk add --no-cache libxml2-dev libxslt-dev sqlite-dev tzdata && \
    bundle config build.google-protobuf --with-cflags=-D__va_copy=va_copy && \
    BUNDLE_FORCE_RUBY_PLATFORM=1 bundle install -j4 && \
    apk del --purge build-dependencies && \
    rails tmp:create && \
    rails db:migrate && \
    rails db:seed

CMD ["pumactl","start"]
EXPOSE 3000

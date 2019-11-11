FROM ruby:2.6.3-alpine3.9
LABEL maintainer="shoma07"

ARG BUILD_PACKAGES="build-base"
ARG DEV_PACKAGES="libxml2-dev libxslt-dev sqlite-dev tzdata"
ENV RAILS_ENV="production" \
    RAILS_LOG_TO_STDOUT="true"

COPY . /usr/src/app/
WORKDIR /usr/src/app
RUN apk add --update --no-cache --virtual=build-dependencies $BUILD_PACKAGES; \
    apk add --update --no-cache $DEV_PACKAGES; \
    gem install bundler:2.0.1; \
    bundle install; \
    apk del --update --no-cache --purge build-dependencies; \
    chmod +x docker-entrypoint.sh; \
    rails tmp:create; \
    rails db:migrate; \
    rails db:seed

ENTRYPOINT ["/usr/src/app/docker-entrypoint.sh"]
CMD ["pumactl","start"]
EXPOSE 3000

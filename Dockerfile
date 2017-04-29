FROM ruby:2.4

RUN apt-get update \
    && apt-get install -y --no-install-recommends postgresql-client nodejs\
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app/public

# Store user data outside of the container
VOLUME /usr/src/app/public

WORKDIR /usr/src/app

RUN bundle config --global frozen 1

ONBUILD COPY Gemfile* .
ONBUILD RUN bundle install --deployment --without=test
ONBUILD COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

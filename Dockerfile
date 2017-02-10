FROM jruby:9.1.7.0

RUN mkdir /rails
WORKDIR /rails

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "--bind=0.0.0.0", "--port=3000", "--pid=/tmp/server.pid"]

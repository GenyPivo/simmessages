FROM ruby:2.3
RUN apt-get update && apt-get -y install nodejs && apt-get -y install redis-server
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
ADD . /app
RUN gem install bundler
RUN bundle install

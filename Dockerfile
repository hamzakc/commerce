FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /commerce
WORKDIR /commerce
ADD Gemfile /commerce/Gemfile
ADD Gemfile.lock /commerce/Gemfile.lock
RUN bundle install
ADD . /commerce

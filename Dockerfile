FROM ruby:3.0.1

WORKDIR /usr/src/app

COPY . .

RUN gem install rails bundler

RUN bundle install

CMD rails s -b 0.0.0.0

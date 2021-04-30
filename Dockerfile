FROM ruby:3.0.1

WORKDIR /usr/src/app

COPY . .

RUN gem install rails bundler

RUN bundle install

CMD bin/delayed_job start -i analytics_worker--sleep-delay 10000 && rails s -b 0.0.0.0

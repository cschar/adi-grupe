FROM ruby:2.3.3

RUN apt-get update -qq && apt-get install -y build-essential

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for capybara-webkit
RUN apt-get install -y libqt4-webkit libqt4-dev xvfb

# for a JS runtime
RUN apt-get install -y nodejs

ENV APP_HOME /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

#Gemfile/Gemfile.lock
ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME



#
#RUN mkdir /myapp
#WORKDIR /myapp
#ADD Gemfile /myapp/Gemfile
#ADD Gemfile.lock /myapp/Gemfile.lock
#RUN bundle install
#ADD . /myapp
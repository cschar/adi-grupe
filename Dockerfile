FROM ruby:2.4

RUN apt-get update 

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - \
    && apt-get install -y nodejs

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn

RUN mkdir -p /adiapp
WORKDIR /adiapp
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && gem install foreman && bundle install --jobs 20 --retry 5 --without production


COPY . /adiapp

RUN bundle exec rails db:migrate 

#react_on_rails
#WORKDIR /adiapp/client
#RUN yarn

EXPOSE 3000
WORKDIR /adiapp
CMD foreman start -f Procfile


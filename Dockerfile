FROM ruby:2.3.3

RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs

RUN mkdir -p /app
WORKDIR /app


# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5
# Copy the main application.
COPY . ./

EXPOSE 3003
#dont need to specify it each time...
ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "server", "-b", "0.0.0.0", "--port", "3003"]


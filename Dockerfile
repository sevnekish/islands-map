FROM ruby:2.5.3

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000

ENV APP_HOME /AdvMap

RUN apt-get update -qq \
  && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs

RUN mkdir $APP_HOME

# Set working directory
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME

# The main command to run when the container starts.
CMD ["bundle", "exec", "puma", "-C", "./config/puma.rb"]

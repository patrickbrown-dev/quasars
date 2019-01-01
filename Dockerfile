FROM ruby:2.6.0

MAINTAINER Patrick Brown <kineticdial@icloud.com>

RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev --fix-missing --no-install-recommends

ENV RAILS_ROOT /quasars
RUN mkdir -p $RAILS_ROOT

WORKDIR $RAILS_ROOT

COPY . .

RUN bundle install --binstubs
RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

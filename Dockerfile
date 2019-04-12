FROM ruby:2.6.2

WORKDIR /src

ADD Gemfile* /src/
RUN bundle config path /bundle
ENV BUNDLE_PATH=/bundle
RUN bundle install

ADD . /src

EXPOSE 3000

CMD ["./docker/run.sh"]

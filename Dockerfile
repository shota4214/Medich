FROM ruby:3.1.4

RUN apt-get update -qq && apt-get install -y postgresql-client

RUN mkdir /apps
WORKDIR /apps

COPY ./apps/Gemfile       /apps/Gemfile
COPY ./apps/Gemfile.lock  /apps/Gemfile.lock
run bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
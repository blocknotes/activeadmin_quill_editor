ARG RUBY_VERSION=3
FROM ruby:${RUBY_VERSION}

ARG UID

ENV DEVEL=1
ENV LANG=C.UTF-8
ENV RAILS_ENV=development

RUN apt-get update -qq
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yqq --no-install-recommends build-essential chromium libyaml-dev

RUN gem install bundler
RUN echo 'gem: --no-document' > /etc/gemrc

COPY . /app

RUN mkdir -p /home/app
RUN useradd -u ${UID} --shell /bin/bash app 
RUN chown -R app /usr/local/bundle 
RUN chown -R app:app /home/app && chown -R app:app /app

USER ${UID}

WORKDIR /app
RUN bundle update

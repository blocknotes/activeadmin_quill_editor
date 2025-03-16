ARG RUBY_IMAGE=ruby:3
FROM ${RUBY_IMAGE}

ARG UID

ENV DEVEL=1
ENV LANG=C.UTF-8
ENV RAILS_ENV=development

RUN apt-get update -qq
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yqq --no-install-recommends build-essential chromium libyaml-dev nano

RUN gem install bundler
RUN echo 'gem: --no-document' > /etc/gemrc

RUN useradd -u ${UID} --shell /bin/bash app 
RUN mkdir -p /home/app && chown -R app:app /home/app
RUN chown -R app /usr/local/bundle 

USER ${UID}
COPY . /app

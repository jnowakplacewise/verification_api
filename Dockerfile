FROM ruby:3.0.0-buster
RUN apt-get -y update

WORKDIR /home
RUN mkdir /verification_api
COPY . /home/verification_api
WORKDIR /home/verification_api
RUN gem update --system && \
    gem install bundler -N

RUN bundler install
RUN gem install credit_card_verification-0.0.0.gem

EXPOSE 9292
CMD rackup --host 0.0.0.0 --port 9292
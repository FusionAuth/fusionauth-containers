#
# FusionAuth Search Dockerfile
#
# Example build command: docker build -t fusionauth/fusionauth-search:latest .
# Example start command: docker run -p 9020:9020 -it fusionauth/fusionauth-search
# Example publish command: docker push fusionauth/fusionauth-search:latest

FROM debian:stretch-slim

LABEL description="Create an image running FusionAuth Search. Installs FusionAuth Search"

MAINTAINER FusionAuth <dev@fusionauth.io>
EXPOSE 9020

###### Install stuff we need and then cleanup cache #################
RUN apt-get update && apt-get install -y -q \
 unzip \
 wget \
 curl \
 && rm -rf /var/lib/apt/lists/*

###### Install Java #################################################
RUN mkdir -p /usr/local/fusionauth/java \
 && wget --quiet -O /usr/local/fusionauth/java/jre-linux-1.8.0+u171.tar.gz https://storage.googleapis.com/inversoft_products_j098230498/java/jre/jre-linux-1.8.0+u171.tar.gz \
 && tar xfz /usr/local/fusionauth/java/jre-linux-1.8.0+u171.tar.gz -C /usr/local/fusionauth/java \
 && ln -s /usr/local/fusionauth/java/jre1.8.0_171 /usr/local/fusionauth/java/current \
 && rm /usr/local/fusionauth/java/jre-linux-1.8.0+u171.tar.gz

###### Get and install FusionAuth Search Bundle #####################
RUN export FUSIONAUTH_VERSION=1.0.14 \
 && wget --quiet https://storage.googleapis.com/inversoft_products_j098230498/products/fusionauth/${FUSIONAUTH_VERSION}/fusionauth-search_${FUSIONAUTH_VERSION}-1_all.deb \
 && dpkg -i fusionauth-search_${FUSIONAUTH_VERSION}-1_all.deb

###### Start FusionAuth Search ######################################
CMD service fusionauth-search start

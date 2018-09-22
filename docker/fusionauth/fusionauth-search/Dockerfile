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
EXPOSE 9021

###### Install stuff we need and then cleanup cache #################
RUN apt-get update && apt-get install -y -q \
 unzip \
 wget \
 curl \
 && rm -rf /var/lib/apt/lists/* \
 && groupadd -g 2087 fusionauth \
 && useradd -r -u 2087 -g fusionauth fusionauth

###### Install Java #################################################
RUN mkdir -p /usr/local/fusionauth/java \
 && wget --quiet https://storage.googleapis.com/inversoft_products_j098230498/java/jre/jre-linux-1.8.0+u171.tar.gz \
 && tar xfz jre-linux-1.8.0+u171.tar.gz -C /usr/local/fusionauth/java \
 && ln -s /usr/local/fusionauth/java/jre1.8.0_171 /usr/local/fusionauth/java/current \
 && rm jre-linux-1.8.0+u171.tar.gz

###### Get and install FusionAuth Search Bundle #####################
RUN export FUSIONAUTH_VERSION=1.0.14 \
  && wget --quiet https://storage.googleapis.com/inversoft_products_j098230498/products/fusionauth/${FUSIONAUTH_VERSION}/fusionauth-search-${FUSIONAUTH_VERSION}.zip \
  && mkdir -p /usr/local/fusionauth/fusionauth-search \
  && unzip -nq fusionauth-search-${FUSIONAUTH_VERSION}.zip -d /usr/local/fusionauth \
  && rm fusionauth-search-${FUSIONAUTH_VERSION}.zip \
  && chown -R fusionauth:root /usr/local/fusionauth

###### Start FusionAuth Search ######################################
USER fusionauth
CMD /usr/local/fusionauth/fusionauth-search/elasticsearch/bin/elasticsearch
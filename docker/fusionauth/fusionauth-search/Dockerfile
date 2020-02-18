#
# FusionAuth Search Dockerfile
#
# Build:
#   > docker build -t fusionauth/fusionauth-search:1.15.0 .
#   > docker build -t fusionauth/fusionauth-search:latest .
#
# Run:
#  > docker run -p 9020:9020 -p 9021:9021 -it fusionauth/fusionauth-search
#
# Publish:
#   > docker push fusionauth/fusionauth-search:1.15.0
#   > docker push fusionauth/fusionauth-search:latest
#

FROM debian:stretch-slim

LABEL description="Create an image running FusionAuth Search. Installs FusionAuth Search"
MAINTAINER FusionAuth <dev@fusionauth.io>

EXPOSE 9020
EXPOSE 9021

###### Install stuff we need and then cleanup cache #################
RUN apt-get update && apt-get install -y --no-install-recommends \
 unzip \
 wget \
 curl \
 && rm -rf /var/lib/apt/lists/* \
 && groupadd -g 1000 fusionauth \
 && useradd -g fusionauth -u 1000 fusionauth \
 && mkdir -p /usr/local/fusionauth \
 && chown fusionauth:fusionauth /usr/local/fusionauth

###### Install Java #################################################
RUN mkdir -p /usr/local/fusionauth/java \
 && curl -Sk --progress-bar https://storage.googleapis.com/inversoft_products_j098230498/java/jre/jre-linux-1.8.0+u171.tar.gz -o jre-linux-1.8.0+u171.tar.gz \
 && tar xfz jre-linux-1.8.0+u171.tar.gz -C /usr/local/fusionauth/java \
 && ln -s /usr/local/fusionauth/java/jre1.8.0_171 /usr/local/fusionauth/java/current \
 && rm jre-linux-1.8.0+u171.tar.gz \
 && chown -R fusionauth:fusionauth /usr/local/fusionauth/java

###### Get and install FusionAuth Search Bundle #####################
RUN export FUSIONAUTH_VERSION=1.15.0 \
  && curl -Sk --progress-bar https://storage.googleapis.com/inversoft_products_j098230498/products/fusionauth/${FUSIONAUTH_VERSION}/fusionauth-search-${FUSIONAUTH_VERSION}.zip -o fusionauth-search.zip \
  && unzip -nq fusionauth-search.zip -d /usr/local/fusionauth \
  && rm fusionauth-search.zip \
  && mkdir -p /usr/local/fusionauth/data \
  && find /usr/local/fusionauth -type d -maxdepth 1 -not -user fusionauth -not -group fusionauth -exec chown -R fusionauth:fusionauth {} +

###### Start FusionAuth Search ######################################
USER fusionauth
CMD /usr/local/fusionauth/fusionauth-search/elasticsearch/bin/elasticsearch
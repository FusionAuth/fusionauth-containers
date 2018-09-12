#
# FusionAuth Search Dockerfile
#
# Example use: docker build -t fusionauth-search .
# Once built, to start: docker run -p 9020:9020 -p 9021:9021 -it fusionauth-search

FROM ubuntu:18.04

LABEL description="Create an image running FusionAuth Search. Installs FusionAuth Search"

MAINTAINER FusionAuth <dev@fusionauth.io>
EXPOSE 9020

###### Install stuff we need ##########################
RUN apt-get update && apt-get install -y -q \
 unzip \
 wget \
 curl

###### Get and install the FusionAuth Search Bundle #######################
RUN export FUSIONAUTH_VERSION=$(curl -s https://www.inversoft.com/api/fusionauth/latest-version) && wget --quiet https://storage.googleapis.com/inversoft_products_j098230498/products/fusionauth/${FUSIONAUTH_VERSION}/fusionauth-search_${FUSIONAUTH_VERSION}-1_all.deb && dpkg -i fusionauth-search_${FUSIONAUTH_VERSION}-1_all.deb


###### start #########################################
CMD service fusionauth-search start


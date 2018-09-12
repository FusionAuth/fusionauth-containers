#
# FusionAuth Dockerfile
#
# Example use: docker build -t fusionauth .
# Once built, to start: docker run -p 9011:9011 -it fusionauth

FROM ubuntu:18.04

LABEL description="Create an image running FusionAuth with embedded search engine. \
Installs FusionAuth Search, FusionAuth App"

MAINTAINER FusionAuth <dev@fusionauth.io>
EXPOSE 9011 9020 9021

###### Install stuff we need ##########################
RUN apt-get update && apt-get install -y -q \
 unzip \
 wget \
 curl

###### Get and install the FusionAuth Bundles #######################
RUN export FUSIONAUTH_VERSION=$(curl -s https://www.inversoft.com/api/fusionauth/latest-version) && wget --quiet https://storage.googleapis.com/inversoft_products_j098230498/products/fusionauth/${FUSIONAUTH_VERSION}/fusionauth-app_${FUSIONAUTH_VERSION}-1_all.deb && dpkg -i fusionauth-app_${FUSIONAUTH_VERSION}-1_all.deb
RUN export FUSIONAUTH_VERSION=$(curl -s https://www.inversoft.com/api/fusionauth/latest-version) && wget --quiet https://storage.googleapis.com/inversoft_products_j098230498/products/fusionauth/${FUSIONAUTH_VERSION}/fusionauth-search_${FUSIONAUTH_VERSION}-1_all.deb && dpkg -i fusionauth-search_${FUSIONAUTH_VERSION}-1_all.deb

###### start #########################################
CMD service fusionauth-search start && service fusionauth-app start && tail -f /usr/local/fusionauth/logs/fusionauth-app.log


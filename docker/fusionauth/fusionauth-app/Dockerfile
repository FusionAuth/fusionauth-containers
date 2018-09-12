#
# FusionAuth App Dockerfile
#
# Example use: docker build -t fusionauth-app .
# Once built, to start: docker run -p 9011:9011 -it fusionauth-app

FROM ubuntu:18.04

LABEL description="Create an image running FusionAuth App. Installs FusionAuth App"


MAINTAINER FusionAuth <dev@fusionauth.io>
EXPOSE 9011

###### Install stuff we need ##########################
RUN apt-get update && apt-get install -y -q \
 unzip \
 wget \
 curl

###### Get and Install FusionAuth App Bundle #######################
RUN export FUSIONAUTH_VERSION=$(curl -s https://www.inversoft.com/api/fusionauth/latest-version) && wget --quiet https://storage.googleapis.com/inversoft_products_j098230498/products/fusionauth/${FUSIONAUTH_VERSION}/fusionauth-app_${FUSIONAUTH_VERSION}-1_all.deb && dpkg -i fusionauth-app_${FUSIONAUTH_VERSION}-1_all.deb

###### start #########################################
CMD service fusionauth-app start && tail -f /usr/local/fusionauth/logs/fusionauth-app.log
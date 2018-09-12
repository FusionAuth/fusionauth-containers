#
# FusionAuth Dockerfile
#
# Example use: docker build -t fusionauth .
# Once built, to start: docker run -p 9011:9011 -it fusionauth

FROM ubuntu:18.04

LABEL description="Create an image running FusionAuth with embedded search engine. \
Installs MySQL, FusionAuth Search, FusionAuth App, including the DB Schema"

MAINTAINER FusionAuth <dev@fusionauth.io>
EXPOSE 9011 9020 9021

###### Install stuff we need ##########################
# The DEBIAN_FRONTEND is to prevent MySQL from prompting for a root user password
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y -q \
 unzip \
 wget \
 curl \
 mysql-server-5.7

###### Get and install the FusionAuth Bundles #######################
RUN export FUSIONAUTH_VERSION=$(curl -s https://www.inversoft.com/api/fusionauth/latest-version) && wget --quiet https://storage.googleapis.com/inversoft_products_j098230498/products/fusionauth/${FUSIONAUTH_VERSION}/fusionauth-app_${FUSIONAUTH_VERSION}-1_all.deb dpkg -i fusionauth-app_${FUSIONAUTH_VERSION}-1_all.deb
RUN export FUSIONAUTH_VERSION=$(curl -s https://www.inversoft.com/api/fusionauth/latest-version) && wget --quiet https://storage.googleapis.com/inversoft_products_j098230498/products/fusionauth/${FUSIONAUTH_VERSION}/fusionauth-search_${FUSIONAUTH_VERSION}-1_all.deb && dpkg -i fusionauth-search_${FUSIONAUTH_VERSION}-1_all.deb

###### Update my.cnf ##################################
RUN sed -i '/\[mysql\]/c\
[mysql]\
default-character-set = utf8mb4' /etc/mysql/my.cnf

RUN sed -i '/\[client\]/c\
[client]\
default-character-set = utf8mb4' /etc/mysql/my.cnf

RUN sed -i '/\[mysqld\]/c\
[mysqld]\
character-set-client-handshake = FALSE\
character-set-server = utf8mb4\
collation-server = utf8mb4_bin' /etc/mysql/my.cnf

###### start #########################################
CMD service mysql restart && service fusionauth-search start && service fusionauth-app start && tail -f /usr/local/fusionauth/logs/fusionauth-app.log


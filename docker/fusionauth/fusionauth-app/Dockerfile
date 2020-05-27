#
# FusionAuth App Dockerfile
#
# Build:
#   > docker build -t fusionauth/fusionauth-app:1.17.0 .
#   > docker build -t fusionauth/fusionauth-app:latest .
#
# Run:
#  > docker run -p 9011:9011 -it fusionauth/fusionauth-app
#
# Publish:
#   > docker push fusionauth/fusionauth-app:1.17.0
#   > docker push fusionauth/fusionauth-app:latest
#

FROM alpine:latest as build

###### Install stuff we need and then cleanup cache #################
RUN apk add --no-cache \
  unzip \
  curl

###### Get and install FusionAuth App Bundle ########################
ENV FUSIONAUTH_VERSION=1.17.0
RUN curl -Sk --progress-bar https://storage.googleapis.com/inversoft_products_j098230498/products/fusionauth/${FUSIONAUTH_VERSION}/fusionauth-app-${FUSIONAUTH_VERSION}.zip -o fusionauth-app.zip \
  && mkdir -p /usr/local/fusionauth/fusionauth-app \
  && unzip -nq fusionauth-app.zip -d /usr/local/fusionauth

FROM fusionauth/fusionauth-java:14-jdk-alpine3.11.5

RUN addgroup fusionauth \
  && adduser -G fusionauth -D -H fusionauth

COPY --chown=fusionauth:fusionauth --from=build /usr/local/fusionauth /usr/local/fusionauth

###### Start FusionAuth App #########################################
LABEL description="Create an image running FusionAuth App. Installs FusionAuth App"
LABEL maintainer="FusionAuth <dev@fusionauth.io>"
EXPOSE 9011
USER fusionauth
ENV FUSIONAUTH_USE_GLOBAL_JAVA=1
CMD ["/usr/local/fusionauth/fusionauth-app/apache-tomcat/bin/catalina.sh", "run"]

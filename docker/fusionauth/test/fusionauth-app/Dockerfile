#
# FusionAuth App Dockerfile
#
# Build:
#   > cp ~/dev/inversoft/fusionauth/fusionauth-app/build/bundles/*.zip .
#   > docker build -t fusionauth/fusionauth-app:dev .
#
# Run:
#  > docker run -p 9011:9011 -it fusionauth/fusionauth-app
#

FROM alpine:latest as build

###### Setup user/group #################
RUN addgroup fusionauth \
  && adduser -G fusionauth -D -H fusionauth

###### Copy the FusionAuth Bundle #######
COPY --chown=fusionauth:fusionauth fusionauth-app /usr/local/fusionauth

FROM fusionauth/fusionauth-java:14-jdk-alpine3.11.5

###### Setup user/group #################
RUN addgroup fusionauth \
  && adduser -G fusionauth -D -H fusionauth

COPY --chown=fusionauth:fusionauth --from=build /usr/local/fusionauth /usr/local/fusionauth

###### Start FusionAuth App #############
LABEL description="Create an image running FusionAuth App. Installs FusionAuth App"
LABEL maintainer="FusionAuth <dev@fusionauth.io>"
EXPOSE 9011
# We set this so that we don't download java
ENV FUSIONAUTH_USE_GLOBAL_JAVA=1
USER fusionauth
CMD ["/usr/local/fusionauth/fusionauth-app/apache-tomcat/bin/catalina.sh", "run"]

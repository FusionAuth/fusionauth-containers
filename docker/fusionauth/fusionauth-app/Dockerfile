#
# FusionAuth App Dockerfile
#
# Build:
#   > docker build -t fusionauth/fusionauth-app:1.19.9 .
#   > docker build -t fusionauth/fusionauth-app:latest .
#
# Run:
#  > docker run -p 9011:9011 -it fusionauth/fusionauth-app
#
# Publish:
#   > docker push fusionauth/fusionauth-app:1.19.9
#   > docker push fusionauth/fusionauth-app:latest
#

###### Setup the java base ##########################################
FROM openjdk:14-jdk-alpine3.10 as build

ENV FUSIONAUTH_VERSION=1.19.9
RUN /opt/openjdk-14/bin/jlink --compress=2 \
     --module-path /opt/openjdk-14/jmods/ \
     --add-modules java.base,java.compiler,java.desktop,java.instrument,java.management,java.naming,java.rmi,java.security.jgss,java.security.sasl,java.sql,java.xml.crypto,jdk.attach,jdk.crypto.ec,jdk.jdi,jdk.localedata,jdk.scripting.nashorn,jdk.unsupported \
     --output /jlinked \
     && apk add --no-cache curl unzip \
     && curl -Sk --progress-bar https://files.fusionauth.io/products/fusionauth/${FUSIONAUTH_VERSION}/fusionauth-app-${FUSIONAUTH_VERSION}.zip -o fusionauth-app.zip \
     && mkdir -p /usr/local/fusionauth/fusionauth-app \
     && unzip -nq fusionauth-app.zip -d /usr/local/fusionauth

###### Use alpine latest to ensure we are up-to-date ################
FROM alpine:latest
RUN addgroup fusionauth \
  && adduser -G fusionauth -D -H fusionauth
COPY --from=build /jlinked /opt/openjdk
COPY --chown=fusionauth:fusionauth --from=build /usr/local/fusionauth /usr/local/fusionauth

###### Get and install FusionAuth App Bundle ########################
RUN apk add --no-cache bash \
  && mkdir -p /usr/local/fusionauth/logs \
  && touch /usr/local/fusionauth/logs/fusionauth-app.log \
  && ln -sf /dev/stdout /usr/local/fusionauth/logs/fusionauth-app.log

###### Start FusionAuth App #########################################
LABEL description="Create an image running FusionAuth App. Installs FusionAuth App"
LABEL maintainer="FusionAuth <dev@fusionauth.io>"
EXPOSE 9011
USER fusionauth
ENV FUSIONAUTH_USE_GLOBAL_JAVA=1
ENV JAVA_HOME=/opt/openjdk/
ENV PATH=$PATH:$JAVA_HOME/bin
CMD ["/usr/local/fusionauth/fusionauth-app/apache-tomcat/bin/catalina.sh", "run"]
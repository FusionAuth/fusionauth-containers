#
# FusionAuth App (with MySQL connector) Dockerfile
#
# Normally the mysql-connector jar is downloaded at runtime due to licensing,
# in this case the mysql connector jar will be baked into the image. As a result,
# this images CANNOT BE DISTRIBUTED due to the GPL license of the connector jar.
# We will only ship this file so that people can build the images themselves and
# thus avoid the license issues.
#
# Build: (use any variation of the following)
#   > docker build -t fusionauth/fusionauth-app-mysql:1.16.0-RC.2 .
#   > docker build -t fusionauth/fusionauth-app-mysql:latest .
#   > docker build --build-arg MYSQL_CONNECTOR_VERSION=8.0.18 -t fusionauth/fusionauth-app-mysql:latest .
#
# Run:
#  > docker run -p 9011:9011 -it fusionauth/fusionauth-app-mysql
#
# Publish:
#  DO NOT PUBLISH
#

FROM fusionauth/fusionauth-app:latest

ARG MYSQL_CONNECTOR_VERSION=8.0.18

ADD --chown=fusionauth:fusionauth https://storage.googleapis.com/inversoft_products_j098230498/mysql/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar /usr/local/fusionauth/fusionauth-app/apache-tomcat/lib

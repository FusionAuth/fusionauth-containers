#
# FusionAuth App Dockerfile including the MySQL connector
#
# Note:
# -----------------------------------------------------------------------------
# Under normal circumstances, the MySQL connector is downloaded at runtime
# if you have configured a MySQL JDBC URL.
#
# This means the MySQL connector is not bundled with FusionAuth due to the
# GPL license under which Oracle publishes this software.
#
#  https://github.com/mysql/mysql-connector-j/blob/release/8.0/LICENSE
#
# Generally speaking downloading this jar at runtime works just fine. However
# if you have blocked outbound network access or are concerned with this
# external depdendency leading to possible failures during startup you may
# optionally download the jar ahead of time.
#
# During startup, if we identify the correct MySQL connector jar in the
# classpath the download attempt will be skipped.
#
# Re-packacing the FusionAuth Docker image with the MySQL connector is one
# way of keeping this download from occuring at runtime.
#
# This file is provided as an example only.
# -----------------------------------------------------------------------------
#
# Build:
#   > docker build -t fusionauth/fusionauth-app-mysql:1.16.0-RC.2 .
#   > docker build -t fusionauth/fusionauth-app-mysql:latest .
#
# Run:
#  > docker run -p 9011:9011 -it fusionauth/fusionauth-app-mysql
#

FROM fusionauth/fusionauth-app:1.16.0-RC.2

# Do not change this version, this is the version that will be expected in the classpath at runtime.
ARG MYSQL_CONNECTOR_VERSION=8.0.18

ADD --chown=fusionauth:fusionauth https://storage.googleapis.com/inversoft_products_j098230498/mysql/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar /usr/local/fusionauth/fusionauth-app/apache-tomcat/lib

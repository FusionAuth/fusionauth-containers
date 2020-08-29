#
# FusionAuth App Dockerfile including the MySQL connector
#
# Note:
# -----------------------------------------------------------------------------
# The MySQL JDBC connector is not bundled with FusionAuth due to the GPL
# license terms under which Oracle publishes this software.
#
# https://github.com/mysql/mysql-connector-j/blob/release/8.0/LICENSE
#
# Because of this restriction, the MySQL connector is downloaded at runtime
# to allow FusionAuth to connect to a MySQL JDBC URL.
#
# Generally speaking downloading this jar at runtime works just fine. However
# if you have blocked outbound network access or are concerned with this
# external network dependency leading to possible failures during startup you
# may optionally download the jar ahead of time.
#
# During startup, if we identify the correct MySQL connector jar in the
# classpath the download attempt will be skipped.
#
# Re-packaging the FusionAuth Docker image with the MySQL connector is one
# way of keeping this download from occurring at runtime.
#
# This file is provided as an example only.
# -----------------------------------------------------------------------------
#
# Build:
#   > docker build -t fusionauth/fusionauth-app-mysql:1.19.0 .
#   > docker build -t fusionauth/fusionauth-app-mysql:latest .
#
# Run:
#  > docker run -p 9011:9011 -it fusionauth/fusionauth-app-mysql
#

FROM fusionauth/fusionauth-app:1.19.0

# Do not change this version, this is the version that will be expected in the classpath at runtime.
ARG MYSQL_CONNECTOR_VERSION=8.0.18

ADD --chown=fusionauth:fusionauth https://files.fusionauth.io/mysql/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar /usr/local/fusionauth/fusionauth-app/apache-tomcat/lib

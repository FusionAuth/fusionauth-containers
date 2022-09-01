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
# Because of this restriction, you will need to build a docker image for your
# use that contains the MySQL JDBC connector in order to connect to a MySQL
# database at runtime.
#
# This file is provided as an example only.
# -----------------------------------------------------------------------------
#
# Build:
#   > docker build -t fusionauth/fusionauth-app-mysql:1.38.1 .
#   > docker build -t fusionauth/fusionauth-app-mysql:latest .
#
# Run:
#  > docker run -p 9011:9011 -it fusionauth/fusionauth-app-mysql
#

FROM fusionauth/fusionauth-app:1.38.1

# Do not change this version, this is the version that will be expected in the classpath at runtime.
ARG MYSQL_CONNECTOR_VERSION=8.0.21

ADD --chown=fusionauth:fusionauth https://files.fusionauth.io/mysql/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar /usr/local/fusionauth/fusionauth-app/lib

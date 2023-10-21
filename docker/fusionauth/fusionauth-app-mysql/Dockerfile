#
# FusionAuth App Dockerfile including the MySQL connector
#
# Note:
# -----------------------------------------------------------------------------
# The MySQL JDBC connector is not bundled with FusionAuth due to the GPL
# license terms under which Oracle publishes this software.
#
# Because of this restriction, you will need to build a docker image for your
# use that contains the MySQL JDBC connector in order to connect to a MySQL
# database at runtime.

# Source: https://github.com/mysql/mysql-connector-j
# License: https://github.com/mysql/mysql-connector-j/blob/release/8.0/LICENSE
# Homepage: https://dev.mysql.com/doc/connector-j/8.0/en/
#
# If you choose to build a Docker image containing this connector, ensure you
# aware and in compliance with the license under which the MySQL JDBC connector
# is provided.
#
# This file is provided as an example only.
# -----------------------------------------------------------------------------
#
# Build:
#   > docker build -t fusionauth/fusionauth-app-mysql:1.48.0-EAP.20231021-{integration} .
#   > docker build -t fusionauth/fusionauth-app-mysql:latest .
#
# Run:
#  > docker run -p 9011:9011 -it fusionauth/fusionauth-app-mysql
#

FROM fusionauth/fusionauth-app:1.48.0-EAP.20231021
ADD --chown=fusionauth:fusionauth https://search.maven.org/remotecontent?filepath=mysql/mysql-connector-java/8.0.30/mysql-connector-java-8.0.30.jar /usr/local/fusionauth/fusionauth-app/lib

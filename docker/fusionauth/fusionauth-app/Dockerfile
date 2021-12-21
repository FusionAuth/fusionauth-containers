#
# FusionAuth App Dockerfile
#
# Build:
#   > docker pull ubuntu:focal
#   > docker build -t fusionauth/fusionauth-app:1.32.2 .
#   > docker build -t fusionauth/fusionauth-app:latest .
#
# Run:
#  > docker run -p 9011:9011 -it fusionauth/fusionauth-app
#
# Publish:
#   > docker push fusionauth/fusionauth-app:1.32.2
#   > docker push fusionauth/fusionauth-app:latest
#

###### Setup the java and fusionauth-app base #####################################################
FROM ubuntu:focal as build

ARG JDK_MODULES=java.base,java.compiler,java.desktop,java.instrument,java.logging,java.management,java.naming,java.rmi,java.security.jgss,java.security.sasl,java.scripting,java.sql,java.xml.crypto,jdk.attach,jdk.crypto.ec,jdk.dynalink,jdk.jcmd,jdk.jdi,jdk.localedata,jdk.jpackage,jdk.unsupported,jdk.zipfs
ARG FUSIONAUTH_VERSION=1.32.2
RUN ARCH="$(dpkg --print-architecture)"; \
    case "${ARCH}" in \
    aarch64|arm64)\
        ESUM='f23d482b2b4ada08166201d1a0e299e3e371fdca5cd7288dcbd81ae82f3a75e3';\
        BINARY_URL='https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.1%2B12/OpenJDK17U-jdk_aarch64_linux_hotspot_17.0.1_12.tar.gz';\
        ;;\
    armhf|armv7l|armel)\
        ESUM='f5945a39929384235e7cb1c57df071b8c7e49274632e2a54e54b2bad05de21a5';\
        BINARY_URL='https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.1%2B12/OpenJDK17U-jdk_arm_linux_hotspot_17.0.1_12.tar.gz';\
        ;;\
    ppc64el|ppc64le)\
        ESUM='bd65d4e8ecc4236924ae34d2075b956799abca594021e1b40c36aa08a0d610b0';\
        BINARY_URL='https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.1%2B12/OpenJDK17U-jdk_ppc64le_linux_hotspot_17.0.1_12.tar.gz';\
        ;;\
    s390x)\
        ESUM='dcc17e6ef28984656e997b6b8a6a31c89f45aff87a56b5d3819137c8f1050bef';\
        BINARY_URL='https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.1%2B12/OpenJDK17U-jdk_s390x_linux_hotspot_17.0.1_12.tar.gz';\
        ;;\
    amd64|x86_64)\
        ESUM='6ea18c276dcbb8522feeebcfc3a4b5cb7c7e7368ba8590d3326c6c3efc5448b6';\
        BINARY_URL='https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.1%2B12/OpenJDK17U-jdk_x64_linux_hotspot_17.0.1_12.tar.gz';\
        ;;\
    *)\
        echo "Unsupported arch: ${ARCH}";\
        exit 1;\
        ;;\
    esac \
    && apt-get update 
RUN apt-get install -y curl unzip 
RUN echo "${ARG} --> ${BINARY_URL}" 
RUN curl -LfsSo /tmp/openjdk.tar.gz "${BINARY_URL}" 
RUN echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c - 
RUN mkdir -p /tmp/openjdk \
    && cd /tmp/openjdk \
    && tar -xf /tmp/openjdk.tar.gz --strip-components=1 
RUN /tmp/openjdk/bin/jlink --compress=2 \
       --module-path /tmp/openjdk/jmods/ \
       --add-modules ${JDK_MODULES} \
       --output /opt/openjdk \
    && curl -LfsSo /tmp/fusionauth-app.zip https://files.fusionauth.io/products/fusionauth/${FUSIONAUTH_VERSION}/fusionauth-app-${FUSIONAUTH_VERSION}.zip \
    && mkdir -p /usr/local/fusionauth/fusionauth-app \
    && unzip -nq /tmp/fusionauth-app.zip -d /usr/local/fusionauth

###### Use Ubuntu latest and only copy in what we need to reduce the layer size ###################
FROM ubuntu:focal
RUN useradd -d /usr/local/fusionauth -U fusionauth
COPY --from=build /opt/openjdk /opt/openjdk
COPY --chown=fusionauth:fusionauth --from=build /usr/local/fusionauth /usr/local/fusionauth

###### Connect the log file to stdout #############################################################
RUN mkdir -p /usr/local/fusionauth/logs \
  && touch /usr/local/fusionauth/logs/fusionauth-app.log \
  && ln -sf /dev/stdout /usr/local/fusionauth/logs/fusionauth-app.log

###### Start FusionAuth App #######################################################################
LABEL description="Create an image running FusionAuth App. Installs FusionAuth App"
LABEL maintainer="FusionAuth <dev@fusionauth.io>"
EXPOSE 9011
USER fusionauth
ENV FUSIONAUTH_USE_GLOBAL_JAVA=1
ENV JAVA_HOME=/opt/openjdk
ENV PATH=$PATH:$JAVA_HOME/bin
CMD ["/usr/local/fusionauth/fusionauth-app/apache-tomcat/bin/catalina.sh", "run"]

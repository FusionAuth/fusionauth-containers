#
# FusionAuth App Dockerfile
#
# Build:
#   > docker pull ubuntu:latest
#   > docker build -t fusionauth/fusionauth-app:1.21.0 .
#   > docker build -t fusionauth/fusionauth-app:latest .
#
# Run:
#  > docker run -p 9011:9011 -it fusionauth/fusionauth-app
#
# Publish:
#   > docker push fusionauth/fusionauth-app:1.21.0
#   > docker push fusionauth/fusionauth-app:latest
#

###### Setup the java and fusionauth-app base #####################################################
FROM ubuntu:latest as build

ARG JDK_MODULES=java.base,java.compiler,java.desktop,java.instrument,java.management,java.naming,java.rmi,java.security.jgss,java.security.sasl,java.sql,java.xml.crypto,jdk.attach,jdk.crypto.ec,jdk.jdi,jdk.localedata,jdk.scripting.nashorn,jdk.unsupported
ARG FUSIONAUTH_VERSION=1.21.0
RUN ARCH="$(dpkg --print-architecture)"; \
    case "${ARCH}" in\
    aarch64|arm64)\
        ESUM='81ca31ad90f9bd789a2ca1753d6d83d10f4927876b4a4b9f4b1c4c8cbce85feb';\
        BINARY_URL='https://github.com/AdoptOpenJDK/openjdk14-binaries/releases/download/jdk-14.0.1%2B7/OpenJDK14U-jdk_aarch64_linux_hotspot_14.0.1_7.tar.gz';\
        ;;\
    armhf|armv7l|armel)\
        ESUM='458d091756500dc3013737aa182a14752b3d4ffc358d09532201874ffb8cae22';\
        BINARY_URL='https://github.com/AdoptOpenJDK/openjdk14-binaries/releases/download/jdk-14.0.1%2B7/OpenJDK14U-jdk_arm_linux_hotspot_14.0.1_7.tar.gz';\
        ;;\
    ppc64el|ppc64le)\
        ESUM='bfdd77112d81256d4e1a859a465dd4dcb670019a5d6cf8260c30e24a0e5947e4';\
        BINARY_URL='https://github.com/AdoptOpenJDK/openjdk14-binaries/releases/download/jdk-14.0.1%2B7/OpenJDK14U-jdk_ppc64le_linux_hotspot_14.0.1_7.tar.gz';\
        ;;\
    s390x)\
        ESUM='c13545924e92cb9d495282e95270f299a28d5466f9741c67791f131c38ebbd0c';\
        BINARY_URL='https://github.com/AdoptOpenJDK/openjdk14-binaries/releases/download/jdk-14.0.1%2B7/OpenJDK14U-jdk_s390x_linux_hotspot_14.0.1_7.tar.gz';\
        ;;\
    amd64|x86_64)\
        ESUM='9ddf9b35996fbd784a53fff3e0d59920a7d5acf1a82d4c8d70906957ac146cd1';\
        BINARY_URL='https://github.com/AdoptOpenJDK/openjdk14-binaries/releases/download/jdk-14.0.1%2B7/OpenJDK14U-jdk_x64_linux_hotspot_14.0.1_7.tar.gz';\
        ;;\
    *)\
        echo "Unsupported arch: ${ARCH}";\
        exit 1;\
        ;;\
    esac \
    && apt update \
    && apt install -y curl unzip \
    && curl -LfsSo /tmp/openjdk.tar.gz ${BINARY_URL} \
    && echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c - \
    && mkdir -p /tmp/openjdk \
    && cd /tmp/openjdk \
    && tar -xf /tmp/openjdk.tar.gz --strip-components=1 \
    && /tmp/openjdk/bin/jlink --compress=2 \
       --module-path /tmp/openjdk/jmods/ \
       --add-modules ${JDK_MODULES} \
       --output /opt/openjdk \
     && curl -LfsSo /tmp/fusionauth-app.zip https://files.fusionauth.io/products/fusionauth/${FUSIONAUTH_VERSION}/fusionauth-app-${FUSIONAUTH_VERSION}.zip \
     && mkdir -p /usr/local/fusionauth/fusionauth-app \
     && unzip -nq /tmp/fusionauth-app.zip -d /usr/local/fusionauth

###### Use Ubuntu latest and only copy in what we need to reduce the layer size ###################
FROM ubuntu:latest
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
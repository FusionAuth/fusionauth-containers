#
# FusionAuth App Dockerfile
#
# Build:
#   > docker pull ubuntu:focal
#   > docker buildx build --platform=linux/arm64 -t fusionauth/fusionauth-app:1.32.2 .
#   > docker buildx build --platform=linux/arm64  -t fusionauth/fusionauth-app:latest .
#
# Note: Substiture your platform architecture. The above example is building on an Apple M1 ARM 64 bit architecture.
#       To build on an Intel based platform use --platform=linux/amd64.
#
# Run:
#  > docker run -p 9011:9011 -it fusionauth/fusionauth-app
#
# Publish:
#   > docker push fusionauth/fusionauth-app:1.32.2
#   > docker push fusionauth/fusionauth-app:latest
#

###### Setup the java and fusionauth-app base #####################################################
FROM --platform=$BUILDPLATFORM ubuntu:focal as build

ARG BUILDPLATFORM
ARG FUSIONAUTH_VERSION=1.32.1
ARG JDK_MODULES=java.base,java.compiler,java.desktop,java.instrument,java.management,java.naming,java.rmi,java.security.jgss,java.security.sasl,java.sql,java.xml.crypto,jdk.attach,jdk.crypto.ec,jdk.jdi,jdk.localedata,jdk.scripting.nashorn,jdk.unsupported
ARG TARGETPLATFORM
ARG TARGETARCH
RUN printf "Building on ${BUILDPLATFORM} for ${TARGETPLATFORM} (${TARGETARCH})."
RUN case "${BUILDPLATFORM}" in \
    linux/arm64)\
        BUILD_JAVA_SUM="81ca31ad90f9bd789a2ca1753d6d83d10f4927876b4a4b9f4b1c4c8cbce85feb";\
        BUILD_JAVA_URL="https://github.com/AdoptOpenJDK/openjdk14-binaries/releases/download/jdk-14.0.1%2B7/OpenJDK14U-jdk_aarch64_linux_hotspot_14.0.1_7.tar.gz";\
        ;;\
    linux/amd64)\
        BUILD_JAVA_SUM="9ddf9b35996fbd784a53fff3e0d59920a7d5acf1a82d4c8d70906957ac146cd1";\
        BUILD_JAVA_URL="https://github.com/AdoptOpenJDK/openjdk14-binaries/releases/download/jdk-14.0.1%2B7/OpenJDK14U-jdk_x64_linux_hotspot_14.0.1_7.tar.gz";\
        ;;\
    *)\
        printf "Unsupported build platform arch: ${BUILDPLATFORM}";\
        exit 1;\
        ;;\
    esac \
    && case "${TARGETARCH}" in \
    arm64)\
        JAVA_SUM="81ca31ad90f9bd789a2ca1753d6d83d10f4927876b4a4b9f4b1c4c8cbce85feb";\
        JAVA_URL="https://github.com/AdoptOpenJDK/openjdk14-binaries/releases/download/jdk-14.0.1%2B7/OpenJDK14U-jdk_aarch64_linux_hotspot_14.0.1_7.tar.gz";\
        ;;\
    arm)\
        JAVA_SUM="458d091756500dc3013737aa182a14752b3d4ffc358d09532201874ffb8cae22";\
        JAVA_URL="https://github.com/AdoptOpenJDK/openjdk14-binaries/releases/download/jdk-14.0.1%2B7/OpenJDK14U-jdk_arm_linux_hotspot_14.0.1_7.tar.gz";\
        ;;\
    ppc64le)\
        JAVA_SUM="bfdd77112d81256d4e1a859a465dd4dcb670019a5d6cf8260c30e24a0e5947e4";\
        JAVA_URL="https://github.com/AdoptOpenJDK/openjdk14-binaries/releases/download/jdk-14.0.1%2B7/OpenJDK14U-jdk_ppc64le_linux_hotspot_14.0.1_7.tar.gz";\
        ;;\
    s390x)\
        JAVA_SUM="c13545924e92cb9d495282e95270f299a28d5466f9741c67791f131c38ebbd0c";\
        JAVA_URL="https://github.com/AdoptOpenJDK/openjdk14-binaries/releases/download/jdk-14.0.1%2B7/OpenJDK14U-jdk_s390x_linux_hotspot_14.0.1_7.tar.gz";\
        ;;\
    amd64)\
        JAVA_SUM="9ddf9b35996fbd784a53fff3e0d59920a7d5acf1a82d4c8d70906957ac146cd1";\
        JAVA_URL="https://github.com/AdoptOpenJDK/openjdk14-binaries/releases/download/jdk-14.0.1%2B7/OpenJDK14U-jdk_x64_linux_hotspot_14.0.1_7.tar.gz";\
        ;;\
    *)\
        printf "Unsupported arch: ${TARGETARCH}";\
        exit 1;\
        ;;\
    esac \
    && apt-get update \
    && apt-get install -y curl unzip \
    && mkdir -p /tmp/openjdk \
    && mkdir -p /tmp/build/openjdk \
    && curl -LfsSo /tmp/build/openjdk.tar.gz "${BUILD_JAVA_URL}" \
    && echo "${BUILD_JAVA_SUM} */tmp/build/openjdk.tar.gz" | sha256sum -c - \
    && curl -LfsSo /tmp/openjdk.tar.gz "${JAVA_URL}" \
    && echo "${JAVA_SUM} */tmp/openjdk.tar.gz" | sha256sum -c - \
    && cd /tmp/build/openjdk \
    && tar -xf /tmp/build/openjdk.tar.gz --strip-components=1 \
    && cd /tmp/openjdk \
    && tar -xf /tmp/openjdk.tar.gz --strip-components=1 \
    && /tmp/build/openjdk/bin/jlink --compress=2 \
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
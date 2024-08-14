#
# FusionAuth App Dockerfile
#
# Build:
#   > docker pull ubuntu:noble
#   > docker buildx build --platform=linux/arm64 -t fusionauth/fusionauth-app:1.52.1 .
#   > docker buildx build --platform=linux/arm64 -t fusionauth/fusionauth-app:latest .
#
# Note: Substitute your target platform architecture. The above example is targetting a 64-bit ARM platform.
#       To target an Intel based platform use --platform=linux/amd64.
#
# Run:
#  > docker run -p 9011:9011 -it fusionauth/fusionauth-app
#
# Publish:
#   > docker push fusionauth/fusionauth-app:1.52.1
#   > docker push fusionauth/fusionauth-app:latest
#

###### Setup the java and fusionauth-app base #####################################################
FROM --platform=$BUILDPLATFORM ubuntu:noble AS build

ARG BUILDPLATFORM
ARG FUSIONAUTH_VERSION=1.52.1
ARG JDK_MODULES=java.base,java.compiler,java.desktop,java.instrument,java.logging,java.management,java.naming,java.net.http,java.rmi,java.security.jgss,java.security.sasl,java.sql,java.xml.crypto,jdk.attach,jdk.crypto.ec,jdk.dynalink,jdk.jcmd,jdk.jdi,jdk.localedata,jdk.jpackage,jdk.unsupported,jdk.zipfs
ARG TARGETPLATFORM
ARG TARGETARCH
RUN printf "Building on ${BUILDPLATFORM} for ${TARGETPLATFORM} (${TARGETARCH})."
RUN case "${BUILDPLATFORM}" in \
    linux/arm64)\
        BUILD_JAVA_SUM="eefd3cf3b3dd47ff269fa5b5c10b5e096b163f4e9c1810023abdbc00dc6cc304";\
        BUILD_JAVA_URL="https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.8.1%2B1/OpenJDK17U-jdk_aarch64_linux_hotspot_17.0.8.1_1.tar.gz";\
        ;;\
    linux/amd64)\
        BUILD_JAVA_SUM="c25dfbc334068a48c19c44ce39ad4b8427e309ae1cfa83f23c102e78b8a6dcc0";\
        BUILD_JAVA_URL="https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.8.1%2B1/OpenJDK17U-jdk_x64_linux_hotspot_17.0.8.1_1.tar.gz";\
        ;;\
    *)\
        printf "Unsupported build platform arch: ${BUILDPLATFORM}";\
        exit 1;\
        ;;\
    esac \
    && case "${TARGETARCH}" in \
    arm64)\
        JAVA_SUM="eefd3cf3b3dd47ff269fa5b5c10b5e096b163f4e9c1810023abdbc00dc6cc304";\
        JAVA_URL="https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.8.1%2B1/OpenJDK17U-jdk_aarch64_linux_hotspot_17.0.8.1_1.tar.gz";\
        ;;\
    arm)\
        JAVA_SUM="b1f1d8b7fcb159a0a8029b6c3106d1d16207cecbb2047f9a4be2a64d29897da5";\
        JAVA_URL="https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.8.1%2B1/OpenJDK17U-jdk_arm_linux_hotspot_17.0.8.1_1.tar.gz";\
        ;;\
    ppc64le)\
        JAVA_SUM="00a4c07603d0218cd678461b5b3b7e25b3253102da4022d31fc35907f21a2efd";\
        JAVA_URL="https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.8.1%2B1/OpenJDK17U-jdk_ppc64le_linux_hotspot_17.0.8.1_1.tar.gz";\
        ;;\
    s390x)\
        JAVA_SUM="ffacba69c6843d7ca70d572489d6cc7ab7ae52c60f0852cedf4cf0d248b6fc37";\
        JAVA_URL="https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.8.1%2B1/OpenJDK17U-jdk_s390x_linux_hotspot_17.0.8.1_1.tar.gz";\
        ;;\
    amd64)\
        JAVA_SUM="c25dfbc334068a48c19c44ce39ad4b8427e309ae1cfa83f23c102e78b8a6dcc0";\
        JAVA_URL="https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.8.1%2B1/OpenJDK17U-jdk_x64_linux_hotspot_17.0.8.1_1.tar.gz";\
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
FROM ubuntu:noble
RUN apt-get update \
    && apt-get -y install --no-install-recommends curl \
    && apt-get -y upgrade \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists \
    && useradd -d /usr/local/fusionauth -U fusionauth
COPY --chown=fusionauth:fusionauth --from=build /opt/openjdk /opt/openjdk
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
CMD ["/usr/local/fusionauth/fusionauth-app/bin/start.sh"]

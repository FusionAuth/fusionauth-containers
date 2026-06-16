#
# FusionAuth App Dockerfile
#
# Build:
#   > docker pull ubuntu:noble
#   > docker buildx build --platform=linux/arm64 -t fusionauth/fusionauth-app:1.68.0 .
#   > docker buildx build --platform=linux/arm64 -t fusionauth/fusionauth-app:latest .
#
# Note: Substitute your target platform architecture. The above example is targetting a 64-bit ARM platform.
#       To target an Intel based platform use --platform=linux/amd64.
#       By default, the build will fetch the fusionauth artifact from the public download location. If you have a local copy of the artifact,
#       place it in the same directory as this Dockerfile and name it fusionauth-app-<version>.zip. The build will detect the local file and
#       use it instead of downloading it.
#
# Run:
#  > docker run -p 9011:9011 -it fusionauth/fusionauth-app
#
# Publish:
#   > docker push fusionauth/fusionauth-app:1.68.0
#   > docker push fusionauth/fusionauth-app:latest
#

###### Setup the java and fusionauth-app base #####################################################
FROM --platform=$BUILDPLATFORM ubuntu:noble AS build

ARG BUILDARCH
ARG BUILDPLATFORM
ARG FUSIONAUTH_VERSION=1.68.0
ARG JDK_MODULES=java.base,java.compiler,java.desktop,java.instrument,java.logging,java.management,java.naming,java.net.http,java.rmi,java.security.jgss,java.security.sasl,java.sql,java.xml.crypto,jdk.attach,jdk.crypto.ec,jdk.dynalink,jdk.jcmd,jdk.jdi,jdk.localedata,jdk.jpackage,jdk.unsupported,jdk.zipfs
ARG TARGETPLATFORM
ARG TARGETARCH
RUN printf "Building on ${BUILDPLATFORM} for ${TARGETPLATFORM} (${TARGETARCH})."
RUN --mount=type=bind,target=/ctx apt-get update \
    && apt-get install -y curl jq unzip \
    && JAVA_VERSION="$(jq -r '.version' /ctx/java.json)" \
    && JAVA_MAJOR=$(echo "${JAVA_VERSION}" | cut -d. -f1) \
    && echo "Using Java version ${JAVA_VERSION}" \
    && JAVA_VERSION_URL="jdk-$(echo "${JAVA_VERSION}" | sed 's/_/%2B/g')" \
    && BUILD_JAVA_SUM="$(jq -r '.checksums["'"${BUILDARCH}"'"]' /ctx/java.json)" \
    && BUILD_JAVA_URL="https://github.com/adoptium/temurin${JAVA_MAJOR}-binaries/releases/download/${JAVA_VERSION_URL}/OpenJDK${JAVA_MAJOR}U-jdk_$(echo "${BUILDPLATFORM}" | sed 's|linux/||;s|arm64|aarch64|;s|amd64|x64|')_linux_hotspot_${JAVA_VERSION}.tar.gz" \
    && JAVA_SUM="$(jq -r '.checksums["'"${TARGETARCH}"'"]' /ctx/java.json)" \
    && JAVA_URL="https://github.com/adoptium/temurin${JAVA_MAJOR}-binaries/releases/download/${JAVA_VERSION_URL}/OpenJDK${JAVA_MAJOR}U-jdk_$(echo "${TARGETARCH}" | sed 's|arm64|aarch64|;s|amd64|x64|')_linux_hotspot_${JAVA_VERSION}.tar.gz" \
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
    && if [ -f /ctx/fusionauth-app-${FUSIONAUTH_VERSION}.zip ]; then \
           cp /ctx/fusionauth-app-${FUSIONAUTH_VERSION}.zip /tmp/fusionauth-app.zip; \
       else \
           curl -LfsSo /tmp/fusionauth-app.zip https://files.fusionauth.io/products/fusionauth/${FUSIONAUTH_VERSION}/fusionauth-app-${FUSIONAUTH_VERSION}.zip; \
       fi \
    && mkdir -p /usr/local/fusionauth/fusionauth-app \
    && unzip -nq /tmp/fusionauth-app.zip -d /usr/local/fusionauth \
    && JAVA_DEB_VERSION="$(echo "${JAVA_VERSION}" | sed 's/_/+/')-99" \
    && DEB_TARGETARCH="${TARGETARCH}" \
    && if [ "${TARGETARCH}" = "ppc64le" ]; then DEB_TARGETARCH="ppc64el"; fi \
    && mkdir -p /tmp/jdk-shim/DEBIAN \
    && printf "Package: openjdk-${JAVA_MAJOR}-jdk\nSource: openjdk-${JAVA_MAJOR}\nVersion: ${JAVA_DEB_VERSION}\nArchitecture: ${DEB_TARGETARCH}\nMaintainer: Eclipse Adoptium <temurin@adoptium.net>\nDescription: Eclipse Temurin JDK ${JAVA_MAJOR} (security metadata shim)\n" \
           > /tmp/jdk-shim/DEBIAN/control \
    && dpkg-deb --build /tmp/jdk-shim /tmp/jdk-shim.deb \
    && rm -rf /tmp/jdk-shim

###### Use Ubuntu latest and only copy in what we need to reduce the layer size ###################
FROM ubuntu:noble
RUN apt-get update \
    && apt-get -y upgrade \
    # Automatically apply security updates that are currently available. some security updates (e.g. libssl3t64) \
    # will not apply after curl is installed \
    && apt-get -s dist-upgrade | grep "^Inst" | \
           grep -i securi | awk -F " " {'print $2'} | \
           xargs -r apt-get install -y \
    # we want the lightest curl possible in the image \
    && apt-get -y install --no-install-recommends curl \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists \
    && useradd --shell /usr/sbin/nologin -d /usr/local/fusionauth -U fusionauth
COPY --chown=fusionauth:fusionauth --from=build /opt/openjdk /opt/openjdk
COPY --chown=fusionauth:fusionauth --from=build /usr/local/fusionauth /usr/local/fusionauth
COPY --from=build /tmp/jdk-shim.deb /tmp/jdk-shim.deb

RUN mkdir -p /usr/local/fusionauth/logs \
    && chown fusionauth:fusionauth /usr/local/fusionauth/logs \
    && dpkg -i /tmp/jdk-shim.deb \
    && rm /tmp/jdk-shim.deb

###### Start FusionAuth App #######################################################################
LABEL description="Create an image running FusionAuth App. Installs FusionAuth App"
LABEL maintainer="FusionAuth <dev@fusionauth.io>"
EXPOSE 9011
USER fusionauth
ENV FUSIONAUTH_USE_GLOBAL_JAVA=1
ENV JAVA_HOME=/opt/openjdk
ENV PATH=$PATH:$JAVA_HOME/bin
CMD ["/usr/local/fusionauth/fusionauth-app/bin/start.sh"]

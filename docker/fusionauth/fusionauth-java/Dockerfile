
FROM alpine:3.11 as build

#COPY openjdk-14-ea+15_linux-x64-musl_bin.tar.gz /opt/jdk/
RUN apk --no-cache add \
    curl \
  && mkdir -p /opt/jdk \
  && cd /opt/jdk \
  && curl -O https://download.java.net/java/early_access/alpine/15/binaries/openjdk-14-ea+15_linux-x64-musl_bin.tar.gz \
  && tar -xzvf /opt/jdk/openjdk-14-ea+15_linux-x64-musl_bin.tar.gz -C /opt/jdk/ \
  && /opt/jdk/jdk-14/bin/jlink --compress=2 \
     --module-path /opt/jdk/jdk-14/jmods/ \
     --add-modules java.base,java.compiler,java.desktop,java.instrument,java.management,java.naming,java.rmi,java.security.jgss,java.security.sasl,java.sql,java.xml.crypto,jdk.attach,jdk.jdi,jdk.scripting.nashorn,jdk.unsupported \
     --output /jlinked \
  && rm -rf /opt/jdk \
  && mv /jlinked /opt/jdk \
  && apk --no-cache del \
    curl

ENV JAVA_HOME=/opt/jdk/
ENV PATH=$PATH:$JAVA_HOME/bin

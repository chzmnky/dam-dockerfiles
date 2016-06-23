FROM dam/alpine-glibc:3.4


ENV JAVA_VERSION=8 \
    JAVA_UPDATE=92 \
    JAVA_BUILD=14 \
    JAVA_HOME="/usr/lib/jvm/default-jvm" \
    PATH=$JAVA_HOME/bin:$PATH

RUN apk add --no-cache --virtual=build-dependencies ca-certificates && \
    cd "/tmp" && \
    apk add --no-cache openjdk8-jre && \

    # Cleanup after ourselves
    apk del --no-cache build-dependencies ca-certificates && \
    rm -rf "/tmp/"*

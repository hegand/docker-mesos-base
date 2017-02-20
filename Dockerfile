FROM hegand/jdk:openjdk8

ENV MESOS_VERSION 1.0.1

RUN apk --update add --virtual build-dependencies \
    alpine-sdk \
    libtool \
    make \
    patch \
    g++ \
    subversion-dev \
    zlib-dev \
    curl-dev \
    apr-dev \
    linux-headers \
    python-dev \
    fts-dev \
    cyrus-sasl-dev \
    cyrus-sasl-crammd5 \
    curl \
    python \
 && mkdir -p /usr/local/mesos \
 && curl -sL http://www.apache.org/dist/mesos/$MESOS_VERSION/mesos-$MESOS_VERSION.tar.gz \
    | gunzip \
    | tar x -C /tmp/ \
 && cd /tmp/mesos-$MESOS_VERSION \
 && ./configure --disable-java --prefix /usr/local/mesos \
 && make install -j5 \
 && rm -rf /tmp/mesos-$MESOS_VERSION \
 && rm -rf /var/cache/apk/* \
 && apk del build-dependencies

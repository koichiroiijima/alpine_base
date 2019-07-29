FROM alpine:3.10.1

ARG IMAGE_NAME=alpine_base
ARG IMAGE_VERSION=0.0.1

LABEL \
    NAME=${IMAGE_NAME}} \
    VERSION=${IMAGE_VERSION}}

# Set User
USER root

# Set working directory
RUN set -ex && mkdir -p /root/bin $$ mkdir -p /opt/bin
WORKDIR /opt/
ENV PATH=${PATH}:/opt/bin:/root/bin

# Set apk repository
RUN set -ex \
    && \
    mkdir -p /var/cache/apk/ \
    && \
    ln -snf /var/cache/apk/ /etc/apk/cache \
    && \
    echo "http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && \
    echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && \
    echo "http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && \
    echo "http://nl.alpinelinux.org/alpine/v3.8/main" >> /etc/apk/repositories

# Set timezone
ENV TZ=America/Los_Angeles
RUN set -ex \
    && \
    apk add --no-cache --update \
    tzdata

RUN set -ex && \
    cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone &&\
    date \
    && \
    apk del tzdata

# Install utility commands
RUN set -ex \
    && \
    apk add --no-cache --update \
        bash \
        wget \
        curl \
        tar \
        gzip \
        unzip \
        coreutils \
        ca-certificates \
        openssl \
        openssh-client \
        gnupg

# Install develpment commands
RUN set -ex \
    && \
    apk add --no-cache --update \
        git \
        gcc \
        g++ \
        gfortran \
        perl 

# Install libraries 
RUN set -ex \
    && \
    apk add --no-cache --update \
        libc6-compat \
        musl \
        linux-headers

# Clean apk
RUN set -ex \
    && \
    apk cache clean \
    && \
    rm -rf /var/cache/apk/*

CMD ["bash"]

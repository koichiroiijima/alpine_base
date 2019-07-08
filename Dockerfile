FROM alpine:3.10

LABEL \
    NAME=aplpine \
    VERSION=3.10-0.0.1-20190707

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
    echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && \
    echo "@edgecommunity http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && \
    echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# Set timezone
ENV TZ=America/Los_Angeles
RUN set -ex \
    && \
    apk add --no-cache --update \
    tzdata
    # && \
    # ls /usr/share/zoneinfo \
    # && \
RUN set -ex && \
    cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone &&\
    date
RUN set -ex \
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
        libssh2 \
        libssl1.1 \
        libc6-compat \
        linux-headers

# Clean apk
RUN set -ex \
    && \
    apk cache clean \
    && \
    rm -rf /var/cache/apk/*

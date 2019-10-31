FROM alpine:3.10.3

ARG IMAGE_NAME=alpine_base
ARG IMAGE_VERSION=0.0.1

LABEL \
    NAME=${IMAGE_NAME}} \
    VERSION=${IMAGE_VERSION}}

# Set User
USER root

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV TZ=America/Los_Angeles
ENV PATH=/opt/bin:/root/bin:${PATH}

# Set working directory
WORKDIR /opt/
RUN set -ex \
    && \
    mkdir -p /root/bin \
    && \
    mkdir -p /opt/bin \
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
    echo "http://nl.alpinelinux.org/alpine/v3.8/main" >> /etc/apk/repositories \
    && \
    apk update \
    && \
    apk add --no-cache --update \
    tzdata \
    && \
    cp /usr/share/zoneinfo/${TZ} /etc/localtime \
    && \
    echo ${TZ} > /etc/timezone \
    && \
    date \
    && \
    apk del tzdata \
# Install utility commands
    && \
    apk add --no-cache --update \
        bash \
        wget \
        curl \
	git \
        tar \
        gzip \
        unzip \
        coreutils \
        ca-certificates \
        openssl \
        openssh-client \
        gnupg \
        vim \
# Install develpment commands
    && \
    apk add --no-cache --update \
        git \
        gcc \
        g++ \
        gfortran \
        perl \
# Install libraries 
    && \
    apk add --no-cache --update \
        libc6-compat \
        musl \
        linux-headers \
# Clean apk
    && \
    apk cache clean \
    && \
    rm -rf /var/cache/apk/*

ENV ENV=/root/.bashrc
SHELL ["/bin/bash", "-c"]

CMD ["bash"]

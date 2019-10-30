#!/bin/bash
set -ex
cd "$(dirname "$0")"

VERSION=3.10-0.0.3-20191029
docker build . --squash -t alpine_base:${VERSION} --build-arg IMAGE_VERSION=${VERSION} --build-arg IMAGE_NAME="alpine_base"
docker tag alpine_base:${VERSION} alpine_base:latest

docker login
docker tag alpine_base:${VERSION} koichiroiijima/alpine_base:${VERSION}
docker tag alpine_base:${VERSION} koichiroiijima/alpine_base:latest
docker push koichiroiijima/alpine_base:${VERSION}
docker push koichiroiijima/alpine_base:latest

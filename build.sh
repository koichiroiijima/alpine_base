#!/bin/bash
set -ex
cd "$(dirname "$0")"

export VERSION=3.10-0.0.1-20190707
docker build . --squash -t alpine_base:${VERSION}
docker tag alpine_base:${VERSION} alpine_base:latest

docker login
docker tag alpine_base:${VERSION} koichiroiijima/alpine_base:${VERSION}
docker tag alpine_base:${VERSION} koichiroiijima/alpine_base:latest
docker push koichiroiijima/alpine_base:${VERSION}
docker push koichiroiijima/alpine_base:latest
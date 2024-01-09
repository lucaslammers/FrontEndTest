#!/usr/bin/env bash

set -e

DOCKER_REGISTRY="localhost:5000"

IMAGE_TAG="ontdekstation-client-release"
VERSION="${1-latest}"

# script takes an optional tag argument, otherwise uses "latest"
docker build \
    -f /var/lib/jenkins/workspace/FrontEndTest/Dockerfile.release \
    -t "$DOCKER_REGISTRY/$IMAGE_TAG:$VERSION" .

docker push "$DOCKER_REGISTRY/$IMAGE_TAG:$VERSION"

echo "Image pushed to $DOCKER_REGISTRY/$IMAGE_TAG:$VERSION"

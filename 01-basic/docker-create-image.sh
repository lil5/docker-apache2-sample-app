#!/bin/bash

function prop {
  grep $1 deployment.properties | cut -d "=" -f2
}

IMAGE_USER=$(prop 'image.user')
IMAGE_NAME=$(prop 'image.name')
IMAGE_VERSION=$(prop 'image.version')
PROXY=$(prop 'http.proxy')
NO_PROXY=$(prop 'http.no_proxy')

echo "Building image $IMAGE_NAME:$IMAGE_VERSION"

docker build \
  -f Dockerfile \
  --build-arg IMAGE_PROXY=$PROXY \
  --build-arg IMAGE_NO_PROXY=$NO_PROXY \
  -t $IMAGE_USER/$IMAGE_NAME:$IMAGE_VERSION .

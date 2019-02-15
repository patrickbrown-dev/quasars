#!/bin/bash
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker tag kineticdial/quasars:latest kineticdial/quasars:$(git rev-parse --short HEAD)

docker push kineticdial/quasars:latest
docker push kineticdial/quasars:$(git rev-parse --short HEAD)
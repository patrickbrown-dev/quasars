#!/bin/bash
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker-compose build quasars nginx

docker tag kineticdial/quasars:latest kineticdial/quasars:$(git rev-parse HEAD)
docker tag kineticdial/quasars-nginx:latest kineticdial/quasars-nginx:$(git rev-parse HEAD)

docker push kineticdial/quasars:latest
docker push kineticdial/quasars:$(git rev-parse HEAD)

docker push kineticdial/quasars-nginx:latest
docker push kineticdial/quasars-nginx:$(git rev-parse HEAD)
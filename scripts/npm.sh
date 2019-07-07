#!/usr/bin/env bash

docker run --rm \
    --volume $PWD/webroot:/usr/src/app \
    --workdir /usr/src/app \
    node:8 npm "$@"
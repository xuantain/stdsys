#!/usr/bin/env bash

docker run --rm \
    --user $(id -u):$(id -g) \
    --volume $PWD/webroot:/var/www \
    --volume $HOME/.composer:/.composer \
    --workdir /var/www \
    --entrypoint "composer" \
    digitalocean.com/php "$@"
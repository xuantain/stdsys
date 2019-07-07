#!/usr/bin/env bash

set -e [ -f ".env" ] || $(echo Please make an .env file and run: php artisan key:generate --env=dev; exit 1)

export $(cat .env | grep -v ^# | xargs);

echo Starting services

docker-compose up -d

echo Host: 127.0.0.1

# until docker-compose exec mariadb mysql -h 127.0.0.1 -u $DB_USERNAME -p$DB_PASSWORD -D $DB_DATABASE --silent -e "show databases;"
until docker-compose exec db mysql -h 127.0.0.1 -p$DB_PASSWORD -D $DB_DATABASE --silent -e "show databases;"
do
  echo "Waiting for database connection..."
  sleep 5
done

echo Installing dependencies
./scripts/npm.sh install
./scripts/composer.sh install

echo Seeding database

rm -f ./webroot/bootstrap/cache/*.php

docker-compose exec app php artisan migrate --env=dev && echo Database migrated
docker-compose exec app php artisan db:seed --env=dev && echo Database seeded
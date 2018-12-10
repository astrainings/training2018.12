#!/usr/bin/env sh
docker-compose pull --parallel
docker-compose build
composer install
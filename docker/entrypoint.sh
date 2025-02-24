#!/bin/bash


if [ ! -f "vendor/autoload.php" ]; then
    composer install --no-progress --no-interaction
fi


if [ ! -f ".env" ]; then
    echo "Creating a .env file for environment: $APP_ENV"
    cp .env.example .env
else 
    echo ".env file exists"
fi

php artisan migrate

php artisan keY:generate

php artisan optimize

php artisan ser --port= $PORT --host= 0.0.0.0 --env=.env

exec docker-php-entrypoint "$@"
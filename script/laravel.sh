#!/bin/bash -eux


echo "==> Installing laravel"

curl -sS http://laravel.com/laravel.phar -o /usr/local/bin/laravel
chmod 755 /usr/local/bin/laravel

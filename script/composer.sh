#!/bin/bash -eux


echo "==> Installing composer"

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
chmod 755 /usr/local/bin/composer
composer self-update

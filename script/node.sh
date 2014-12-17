#!/bin/bash -eux

echo '==> Installing nodeJS'
yum --enablerepo=remi -y install nodejs npm

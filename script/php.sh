#!/bin/bash -eux


echo "==> Installing php packages"

yum --enablerepo=remi -y install php php-mysql php-gd php-xml php-mbstring php-mcrypt
yum -y clean all

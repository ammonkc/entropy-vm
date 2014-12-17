#!/bin/bash -eux


echo "==> Installing mysql packages"

yum --enablerepo=remi -y install mysql mysql-server
yum -y clean all

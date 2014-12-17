#!/bin/bash -eux


echo "==> Installing Apache packages"

yum --enablerepo=remi -y install httpd mod_ssl
yum -y clean all

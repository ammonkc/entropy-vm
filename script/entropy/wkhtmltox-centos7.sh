#!/bin/bash -eux

echo '==> Installing wkhtmltopdf'
cd /tmp
wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.2.1/wkhtmltox-0.12.2.1_linux-centos7-amd64.rpm
yum --enablerepo=remi -y install urw-fonts libXext openssl-devel
yum --nogpgcheck -y localinstall wkhtmltox*.rpm

#!/bin/bash -eux

echo '==> Installing wkhtmltopdf'
cd /tmp
wget http://downloads.sourceforge.net/project/wkhtmltopdf/0.12.2.1/wkhtmltox-0.12.2.1_linux-centos6-amd64.rpm
yum --enablerepo=remi -y install urw-fonts libXext openssl-devel
yum --nogpgcheck -y localinstall wkhtmltox*.rpm

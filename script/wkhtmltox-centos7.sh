#!/bin/bash -eux

echo '==> Installing wkhtmltopdf'
cd /tmp
wget http://downloads.sourceforge.net/project/wkhtmltopdf/0.12.1/wkhtmltox-0.12.1_linux-centos7-amd64.rpm
yum --enablerepo=remi -y install urw-fonts libXext openssl-devel
yum --nogpgcheck localinstall wkhtmltox*.rpm
yum -y clean all
rm -f wkhtmltox*.rpm

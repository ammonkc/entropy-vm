#!/bin/bash -eux

echo '==> Installing wkhtmltopdf'
cd /tmp

if grep -q -i "release 6" /etc/redhat-release ; then
    wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.2.1/wkhtmltox-0.12.2.1_linux-centos6-amd64.rpm
fi

if grep -q -i "release 7" /etc/redhat-release ; then
    wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.2.1/wkhtmltox-0.12.2.1_linux-centos7-amd64.rpm
fi

yum --enablerepo=remi -y install urw-fonts libXext openssl-devel
yum --nogpgcheck -y localinstall wkhtmltox-*.rpm

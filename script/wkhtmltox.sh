#!/bin/bash -eux

echo '==> Installing wkhtmltopdf'
cd /tmp

if grep -q -i "release 6" /etc/redhat-release ; then
    wget http://downloads.sourceforge.net/project/wkhtmltopdf/0.12.2/wkhtmltox-0.12.2_linux-centos6-amd64.rpm
fi

if grep -q -i "release 7" /etc/redhat-release ; then
    wget http://downloads.sourceforge.net/project/wkhtmltopdf/0.12.2/wkhtmltox-0.12.2_linux-centos7-amd64.rpm
fi

yum --enablerepo=remi -y install urw-fonts libXext openssl-devel
yum --nogpgcheck -y localinstall wkhtmltox-*.rpm

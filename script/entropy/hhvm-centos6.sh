#!/bin/bash -eux

echo '==> Installing HHVM'
cd /tmp
wget http://yum.gleez.com/6/x86_64/gleez-repo-6-0.el6.noarch.rpm
yum --enablerepo=remi --nogpgcheck -y install libwebp hhvm
yum -y clean all
rm -f gleez*.rpm

#!/bin/bash -eux

echo "==> Install EPEL, remi, hop5, pgdg, and rpmforge yum repos"
yum -y install wget

cd /tmp

if grep -q -i "release 6" /etc/redhat-release ; then
    wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
    wget -O /etc/yum.repos.d/hop5.repo http://www.hop5.in/yum/el6/hop5.repo
    wget http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm
fi

if grep -q -i "release 7" /etc/redhat-release ; then
    wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
    wget https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
fi

yum -y install epel-release
rpm -Uvh remi-release-*.rpm pgdg-*.rpm


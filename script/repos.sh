#!/bin/bash -eux


echo "==> Install EPEL, remi, and rpmforge yum repos"
yum -y install wget

cd /tmp

if grep -q -i "release 6" /etc/redhat-release ; then
    wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
    wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
    wget http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
fi

if grep -q -i "release 7" /etc/redhat-release ; then
    wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
    wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
    wget http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm
fi

# yum -y install epel-release
rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt
rpm -Uvh epel-release-*.rpm remi-release-*.rpm rpmforge-release-*.rpm


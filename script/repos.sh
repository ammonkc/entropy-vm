#!/bin/bash -eux


echo "==> Install EPEL, remi, and rpmforge yum repos"
yum -y install wget

cd /tmp
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
wget http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm

rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt
sudo rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm rpmforge-release*.rpm


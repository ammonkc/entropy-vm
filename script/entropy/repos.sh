#!/bin/bash -eux

echo "==> Install EPEL, remi, hop5, pgdg, and mariadb yum repos"
yum -y install wget

cd /tmp

if grep -q -i "release 6" /etc/redhat-release ; then
    wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
    wget -O /etc/yum.repos.d/hop5.repo http://www.hop5.in/yum/el6/hop5.repo
    wget http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm
    wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
fi

if grep -q -i "release 7" /etc/redhat-release ; then
    wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
    wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
    wget https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
    curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -
    wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
cat <<EOF > /etc/yum.repos.d/mariadb.repo
# MariaDB 10.1 CentOS repository list - created 2017-12-01 22:42 UTC
# http://downloads.mariadb.org/mariadb/repositories/
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.1/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
enabled=0
EOF

fi

yum -y install epel-release
rpm -Uvh remi-release-*.rpm mysql57-*.rpm pgdg-*.rpm


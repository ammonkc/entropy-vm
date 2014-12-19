#!/bin/bash -eux

echo "==> Installing LAMP packages"

yum --enablerepo=remi -y install httpd mod_ssl php-fpm mod_fastcgi php-mysql php-gd php-xml php-mbstring php-mcrypt php-pecl-memcached memcached redis mysql mysql-server nodejs npm
yum --enablerepo=remi  --enablerepo=pgdg-93-centos -y install postgresql93-server postgresql93-contrib php-pgsql

# Start httpd service
chkconfig httpd --add
chkconfig httpd on --level 2345
service httpd start

# vhosts.conf
cat <<EOF > /etc/httpd/conf.d/vhosts.conf
    ServerName entropy.dev
    # virtualHost
    NameVirtualHost *:80
    NameVirtualHost *:443
    # Load vhost configs from enabled directory
    Include conf/vhosts/enabled/*.conf
EOF

# create directory for vhosts
mkdir -p /etc/httpd/conf/vhosts/{available,enabled}

# Start php-fpm service
chkconfig php-fpm --add
chkconfig php-fpm on --levels 235
service php-fpm start
#Configure Apache to use mod_fastcgi
sed -i 's/FastCgiWrapper On/FastCgiWrapper Off/g' /etc/httpd/conf.d/fastcgi.conf
echo -e "<IfModule mod_fastcgi.c>\nDirectoryIndex index.html index.shtml index.cgi index.php\nAddHandler php5-fcgi .php\nAction php5-fcgi /php5-fcgi\nAlias /php5-fcgi /usr/lib/cgi-bin/php5-fcgi\nFastCgiExternalServer /usr/lib/cgi-bin/php5-fcgi -host 127.0.0.1:9000 -pass-header Authorization\n</IfModule>" >> /etc/httpd/conf.d/fastcgi.conf
mkdir /usr/lib/cgi-bin/
# Fix Permissions
chown -R apache:apache /var/run/mod_fastcgi
# optimise php-fpm
sed -i 's/;listen.backlog = -1/listen.backlog = 1000/' /etc/php-fpm.d/www.conf
sed -i 's/pm.max_children = 50/pm.max_children = 512/' /etc/php-fpm.d/www.conf
sed -i 's/pm.start_servers = 5/pm.start_servers = 16/' /etc/php-fpm.d/www.conf
sed -i 's/pm.min_spare_servers = 5/pm.min_spare_servers = 10/' /etc/php-fpm.d/www.conf
sed -i 's/pm.max_spare_servers = 35/pm.max_spare_servers = 64/' /etc/php-fpm.d/www.conf
sed -i 's/;pm.max_requests = 500/pm.max_requests = 5000/' /etc/php-fpm.d/www.conf
sed -i 's/;rlimit_files = 1024/rlimit_files = 102400/' /etc/php-fpm.d/www.conf

# Start mysqld service
chkconfig mysqld --add
chkconfig mysqld on --level 2345
service mysqld start

echo "==> Installing composer"

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
chmod 755 /usr/local/bin/composer
/usr/local/bin/composer self-update

echo "==> Installing laravel"

curl -sS http://laravel.com/laravel.phar -o /usr/local/bin/laravel
chmod 755 /usr/local/bin/laravel

echo ">>> Installing Beanstalkd"

# Install Beanstalkd
# -y --force-yes
yum -y install beanstalkd

# Set to start on system start
sudo sed -i "s/#START=yes/START=yes/" /etc/default/beanstalkd

# Start Beanstalkd
sudo service beanstalkd start

echo "==> Network fix"

cat <<EOF > /etc/start_netfix.sh
rm -f /etc/udev/rules.d/70-persistent-net.rules
sed -i '/HWADDR/d' /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i '/UUID/d' /etc/sysconfig/network-scripts/ifcfg-eth0
rm -f /etc/sysconfig/network-scripts/ifcfg-eth1
EOF

sh /etc/start_netfix.sh

echo "==> Setup NFS"

chkconfig nfs --add
chkconfig nfs on --level 2345
service nfs start

chkconfig nfslock --add
chkconfig nfslock on --level 2345
service nfslock start

chkconfig rpcbind --add
chkconfig rpcbind on --level 2345
service rpcbind start

echo "==> Setup iptables"
iptables -I INPUT -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -p tcp --dport 443 -j ACCEPT
iptables -I INPUT -p tcp --dport 3306 -j ACCEPT
iptables -I INPUT -p tcp --dport 8081 -j ACCEPT
service iptables save

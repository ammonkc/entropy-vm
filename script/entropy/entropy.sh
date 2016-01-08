echo '==> Recording box config date'
date > /etc/box_build_time

echo '==> Customizing message of the day'
echo 'Welcome to your Entropy virtual machine.' > /etc/motd

# Disable static motd
# sed -i 's/#PrintMotd yes/PrintMotd no/g' /etc/ssh/sshd_config
# install motd.sh
cat << 'EOF' > /etc/profile.d/motd.sh
#!/bin/bash

echo -e "
                _
               | |
      ___ _ __ | |_ _ __ ___  _ __  _   _
     / _ \ '_ \| __| '__/ _ \| '_ \| | | |
    |  __/ | | | |_| | | (_) | |_) | |_| |
     \___|_| |_|\__|_|  \___/| .__/ \__, |
                             | |     __/ |
                             |_|    |___/

################################################
Vagrant Box.......: ammonkc/entropy (v@@BOX_VERSION@@)
hostname..........: `hostname`
IP Address........: `/sbin/ifconfig eth1 | grep 'inet addr' | awk -F: '{print $2}' | awk '{print $1}'`
OS Release........: `cat /etc/redhat-release`
kernel............: `uname -r`
User..............: `whoami`
Apache............: `httpd -v | grep 'Server version' | awk '{print $3}' | tr -d Apache/`
PHP...............: `php -v | grep cli | awk '{print $2}'`
HHVM..............: `hhvm --version | grep 'HipHop VM' | awk '{print $3}'`
MySQL.............: `mysql -V | awk '{print $5}' | tr -d ,`
PostgreSQL........: `psql --version | awk '{print $3}'`
Wkhtmltopdf.......: `wkhtmltopdf --version | awk '{print $2}'`
Configured Sites..:
`cat /etc/hosts.dnsmasq`
################################################
"
EOF

sed -i "s/@@BOX_VERSION@@/${BOX_VERSION}/g" /etc/profile.d/motd.sh
chmod +x /etc/profile.d/motd.sh

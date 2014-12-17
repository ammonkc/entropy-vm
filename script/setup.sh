#!/bin/bash -eux


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

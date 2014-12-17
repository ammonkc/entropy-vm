#!/bin/bash -eux


echo "==> Netfix"

cat <<EOF > /etc/start_netfix.sh
rm -f /etc/udev/rules.d/70-persistent-net.rules
sed -i '/HWADDR/d' /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i '/UUID/d' /etc/sysconfig/network-scripts/ifcfg-eth0
rm -f /etc/sysconfig/network-scripts/ifcfg-eth1
EOF

sh /etc/start_netfix.sh

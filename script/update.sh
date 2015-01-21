#!/bin/bash -eux
if [[ $UPDATE  =~ true || $UPDATE =~ 1 || $UPDATE =~ yes ]]; then
    echo "==> Applying updates"
    yum -y update
    yum -y install gcc cpp make curl kernel-devel kernel-headers perl

    # reboot
    echo "Rebooting the machine..."
    reboot
    sleep 60
fi

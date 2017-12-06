#!/bin/bash -eux

if [[ $UPDATE  =~ true || $UPDATE =~ 1 || $UPDATE =~ yes ]]; then
    echo "==> Applying updates"
    yum -y update
    yum -y install gcc gcc-c++ cpp make curl kernel-devel kernel-headers perl bzip2

    # reboot
    echo "Rebooting the machine..."
    reboot
    sleep 60
fi

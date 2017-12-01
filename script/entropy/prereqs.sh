#!/bin/bash -eux

echo '==> Installing prerequisites'
yum -y install kernel-headers kernel-devel gcc make perl curl wget bzip2 dkms patch net-tools selinux-policy-devel sudo nfs-utils openssh-clients

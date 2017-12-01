#!/bin/bash -eux

echo '==> Installing utilities'
yum --enablerepo=remi,remi-php71 -y install dkms patch net-tools selinux-policy-devel sudo nfs-utils openssh-clients rpcbind vim screen sendmail postfix git-core zsh

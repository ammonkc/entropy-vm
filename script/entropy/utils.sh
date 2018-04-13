#!/bin/bash -eux

echo '==> Installing utilities'
yum --enablerepo=remi,remi-php72 -y install net-tools sudo nfs-utils rpcbind vim screen sendmail postfix git-core zsh

#!/bin/bash -eux

echo '==> Installing utilities'
yum --enablerepo=remi,remi-php56 -y update
yum --enablerepo=remi,remi-php56 -y install nfs-utils rpcbind vim screen sendmail postfix git-core zsh

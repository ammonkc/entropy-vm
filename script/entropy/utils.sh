#!/bin/bash -eux

echo '==> Installing utilities'
yum --enablerepo=remi,remi-${PHP_VERSION} -y install net-tools sudo nfs-utils rpcbind vim screen sendmail postfix git-core zsh

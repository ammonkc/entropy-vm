#!/bin/bash -eux

echo '==> Installing utilities'
yum --enablerepo=remi,remi-php56 -y install gcc cpp make curl kernel-devel kernel-headers perl nfs-utils rpcbind vim screen sendmail postfix git-core zsh

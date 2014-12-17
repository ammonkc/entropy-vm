#!/bin/bash -eux

echo '==> Installing utilities'
yum --enablerepo=remi -y update
yum --enablerepo=remi -y install nfs-utils rpcbind vim screen sendmail git-core
yum -y clean all

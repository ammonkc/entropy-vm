#!/bin/bash -eux

echo '==> Installing utilities'
yum --enablerepo=remi,remi-php71 -y install cpp rpcbind vim screen sendmail postfix git-core zsh

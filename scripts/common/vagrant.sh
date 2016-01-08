#!/bin/sh -eux

# set a default HOME_DIR environment variable if not set
HOME_DIR="${HOME_DIR:-/home/vagrant}";

pubkey_url="https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub";
mkdir -p $HOME_DIR/.ssh;
if command -v wget >/dev/null 2>&1; then
    wget --no-check-certificate "$pubkey_url" -O $HOME_DIR/.ssh/authorized_keys;
elif command -v curl >/dev/null 2>&1; then
    curl --insecure --location "$pubkey_url" > $HOME_DIR/.ssh/authorized_keys;
elif command -v fetch >/dev/null 2>&1; then
    fetch -am -o $HOME_DIR/.ssh/authorized_keys "$pubkey_url";
else
    echo "Cannot download vagrant public key";
    exit 1;
fi
chown -R vagrant $HOME_DIR/.ssh;
chmod -R go-rwsx $HOME_DIR/.ssh;


# Add vagrant user (if it doesn't already exist)
SSH_USER=${SSH_USERNAME:-vagrant}
SSH_PASS=${SSH_PASSWORD:-vagrant}
if ! id -u $SSH_USER >/dev/null 2>&1; then
    echo '==> Creating ${SSH_USER}'
    /usr/sbin/groupadd $SSH_USER
    /usr/sbin/useradd $SSH_USER -g $SSH_USER -G wheel
    echo '==> Giving ${SSH_USER} sudo powers'
    echo "${SSH_PASS}"|passwd --stdin $SSH_USER
    echo "${SSH_USER}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
fi

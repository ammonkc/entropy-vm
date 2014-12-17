#!/bin/bash -eux


#!/usr/bin/env bash

echo ">>> Installing Beanstalkd"

# Install Beanstalkd
# -y --force-yes
yum --enablerepo=remi -y install beanstalkd

# Set to start on system start
sudo sed -i "s/#START=yes/START=yes/" /etc/default/beanstalkd

# Start Beanstalkd
sudo service beanstalkd start

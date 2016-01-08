#!/bin/sh -eux

mkdir -p /etc;
cp /tmp/entropy-metadata.json /etc/entropy-metadata.json;
chmod 0444 /etc/entropy-metadata.json;
rm -f /tmp/entropy-metadata.json;

#!/bin/sh
# script for handling the ssh keys on container startup
set -e

cp -R /tmp/authorized_keys /root/.ssh
chmod 700 /root/.ssh
chown root:root -R /root/.ssh

exec "$@"

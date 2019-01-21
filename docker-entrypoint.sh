#!/bin/sh
set -e

cp -R /tmp/authorized_keys /root/.ssh
chmod 700 /root/.ssh
chown root:root -R /root/.ssh
# chmod 644 /root/.ssh/id_rsa.pub
# chmod 600 /root/.ssh/id_rsa

exec "$@"

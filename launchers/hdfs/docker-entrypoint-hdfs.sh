#!/bin/bash
if [ -z "${AUTHORIZED_KEYS}" ]; then
  echo "Need your ssh public key as AUTHORIZED_KEYS env variable. Get default public key as authorized_key"
  cp $HOME/.ssh/id_rsa.pub $HOME/.ssh/authorized_keys
else
  echo "Populating $HOME/.ssh/authorized_keys with the value from AUTHORIZED_KEYS env variable ..."
  echo "${AUTHORIZED_KEYS}" > $HOME/.ssh/authorized_keys
fi
sudo /usr/sbin/sshd -D -e &
exec "$@"

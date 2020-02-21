#!/bin/sh

set -o xtrace
set -o errexit

apk add --update --no-cache libvirt libzmq openssh-client
pip install /wheels/*whl
rm -rf /wheels
mkdir /etc/virtualbmc
cat << EOF > /etc/virtualbmc/virtualbmc.conf
[log]
debug = true
EOF


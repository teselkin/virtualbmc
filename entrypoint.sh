#!/bin/sh

set -o errexit

if [ -n "${DEBUG}" ]; then
  set -o xtrace
fi

/vbmc-init.sh &

exec /usr/local/bin/vbmcd --foreground


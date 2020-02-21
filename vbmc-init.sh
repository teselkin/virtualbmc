#!/bin/sh

set -o errexit

if [ -n "${DEBUG}" ]; then
  set -o xtrace
fi

sleep 1

if [ -n "${DOMAIN_NAME}" ]; then
  if [ -n "${ADDRESS}" ]; then
    VBMCARGS="--address ${ADDRESS}"
  else
    VBMCARGS=''
  fi

  if [ -n "${USERNAME}" ] && [ -n "${PASSWORD}" ]; then
    VBMCARGS="${VBMCARGS} --username '${USERNAME}' --password '${PASSWORD}'"
  fi

  if [ -n "${PORT}" ]; then
    VBMCARGS="${VBMCARGS} --port ${PORT}"
  fi

  if [ -n "${LIBVIRT_URI}" ]; then
    if [ -n "${LIBVIRT_URI_KEYFILE}" ]; then
      mkdir ${HOME}/.ssh
      cat << EOF > ${HOME}/.ssh/id_vbmc
${LIBVIRT_URI_KEYFILE}
EOF
      chmod 400 ${HOME}/.ssh/id_vbmc
      cat << EOF > ${HOME}/.ssh/config
Host *
  StrictHostKeyChecking no
EOF
      LIBVIRT_URI="${LIBVIRT_URI}?keyfile=${HOME}/.ssh/id_vbmc"
    fi
    VBMCARGS="${VBMCARGS} --libvirt-uri '${LIBVIRT_URI}'"
  fi

  if [ -n "${LIBVIRT_SASL_USERNAME}" ] && [ -n "${LIBVIRT_SASL_PASSWORD}" ]; then
    VBMCARGS="${VBMCARGS} --libvirt-sasl-username '${LIBVIRT_SASL_USERNAME}' --libvirt-sasl-password '${LIBVIRT_SASL_PASSWORD}'"
  fi

  eval vbmc add ${VBMCARGS} "${DOMAIN_NAME}"
  vbmc start "${DOMAIN_NAME}"
fi

vbmc list


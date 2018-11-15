#!/bin/bash

set -e -o pipefail

BITBUCKET_PROPERTIES="${BITBUCKET_HOME}/shared/bitbucket.properties"

mkdir -p "${BITBUCKET_HOME}/shared"
touch ${BITBUCKET_PROPERTIES}

function add_or_set_property {
  PROPERTY=$1
  VALUE=$2

  if [ $(egrep "^\w*${PROPERTY}\s*=\s*.*" ${BITBUCKET_PROPERTIES}) ]; then
    sed -i "s#\(^\w*${PROPERTY}\s*=\s*\)\(.*\)#\1${VALUE}#g" ${BITBUCKET_PROPERTIES}
  else
    echo -e "\n${PROPERTY}=${VALUE}" >> ${BITBUCKET_PROPERTIES}
  fi
}

if [ -n "${X_CROWD_SSO}" ]; then
  if [ "${X_CROWD_SSO}" == "true" ]; then
    add_or_set_property 'plugin.auth-crowd.sso.enabled' 'true'
  else
    add_or_set_property 'plugin.auth-crowd.sso.enabled' 'false'
  fi
fi

if [ -n "${X_PATH}" ]; then
  add_or_set_property 'server.context-path' "${X_PATH}"
fi

exec "$@"

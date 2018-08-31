#!/bin/bash

set -e -x;

LOCATION=$1
HS2_SERVICE=localhost
HS2_PORT=10001

BEELINE_CONNECTION_URL="jdbc:hive2://${HS2_SERVICE}:${HS2_PORT}/;transportMode=http;httpPath=cliservice"

if [[ -z "${HS2_AUTH_USER}" ]]; then
  echo "HS2_AUTH_USER env is not set. Skipping auth.."
else
  BEELINE_CONNECTION_URL="${BEELINE_CONNECTION_URL};user=${HS2_AUTH_USER}"
fi

if [[ -z "${HS2_AUTH_PASSWORD}" ]]; then
  echo "HS2_AUTH_PASSWORD env is not set. Skipping auth.."
else
  BEELINE_CONNECTION_URL="${BEELINE_CONNECTION_URL};password=${HS2_AUTH_PASSWORD}"
fi

echo "Waiting for ${HS2_SERVICE} to launch on ${HS2_PORT}.."

while ! nc -zv -w 2 ${HS2_SERVICE} ${HS2_PORT}; do
  sleep 5
  echo "Waiting for ${HS2_SERVICE} to launch on ${HS2_PORT}.."
done

echo "Connected to ${HS2_SERVICE} on ${HS2_PORT}! Using beeline url: ${BEELINE_CONNECTION_URL}"

echo "Starting text data load of all airlines data.."
${HIVE_HOME}/bin/beeline -u "${BEELINE_CONNECTION_URL}" -f ddl/text.sql --hivevar location="${LOCATION}";
echo "Starting orc data load of all airlines data.."
${HIVE_HOME}/bin/beeline -u "${BEELINE_CONNECTION_URL}" -f ddl/orc.sql;
echo "All airlines data load completed!"

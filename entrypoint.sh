#!/bin/sh
echo "${TS_PASS}" > "${TS_PASS_FILE}"
chmod 600 "${TS_PASS_FILE}"
"${HOME}/ts3exporter" -remote "${REMOTE}:${PORT}" -user "${TS_USER}" -passwordfile "./${TS_PASS_FILE}" -ignorefloodlimits -enablechannelmetrics
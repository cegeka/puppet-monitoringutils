#!/bin/bash
# Filename: activemq-failover-mon.sh

CURRENT_TIMESTAMP=`date +"%y-%m-%dT%H:%M:%S"`
TODAYS_ACTIVEMQ_ERRORS=`journalctl -u activemq --since today --grep 'no longer able to keep the exclusive lock so giving up being a master'`

echo "${CURRENT_TIMESTAMP} - ${TODAYS_ACTIVEMQ_ERRORS}" >> /var/log/activemq-failover-mon.log

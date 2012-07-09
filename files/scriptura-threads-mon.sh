#!/bin/sh

CURRENT_TIMESTAMP=`date +"%y-%m-%dT%H:%M:%S"`
SCRIPTURA_PROCESS_ID=`ps -ef | grep [S]cripturaStartServer | awk '{ print $2 }'`
CURRRENT_SCRIPTURA_THREADS=`ps uH p ${SCRIPTURA_PROCESS_ID} | wc -l`

echo ${CURRENT_TIMESTAMP} ${CURRRENT_SCRIPTURA_THREADS} >> /var/log/scriptura_threads_mon.log

#!/bin/sh

CURRENT_TIMESTAMP=`date +"%y-%m-%dT%H:%M:%S"`
APPSERVER_PROCESS_ID=`ps -ef | grep appserver | grep domains | awk '{ print $2 }'`
CURRRENT_APPSERVER_THREADS=`ps uH p ${APPSERVER_PROCESS_ID} | wc -l`

echo ${CURRENT_TIMESTAMP} ${CURRRENT_APPSERVER_THREADS} >> /var/log/appserver_threads_mon.log

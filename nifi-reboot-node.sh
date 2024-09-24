#!/bin/bash

NIFI_BIN=/lib/nifi/bin
NIFI_ZK=/lib/nifi/state/zookeeper
NIFI_LOGS=/lib/nifi/logs

$NIFI_BIN/nifi.sh stop
rm $NIFI_LOGS/*
if [ -d "$NIFI_ZK/backup" ]; then
	echo "$NIFI_ZK/backup already exist"
	rm $NIFI_ZK/backup/*
else 
	mkdir $NIFI_ZK/backup
fi

mv $NIFI_ZK/version-2/* $NIFI_ZK/backup
$NIFI_BIN/nifi.sh start

start_time=$(date +%s)
while true; do
 if grep -q "UI is available" $NIFI_LOGS/nifi-app.log; then
	echo "NiFi Started Successfully"
	exit 0
 fi
 current_time=$(date +%s)
 if  (( $current_time - $start_time > 180 )); then
	echo "Error running NiFi"
	exit 1
 fi
 sleep 1
done

#!/bin/bash

SERVER_ID=$(hostname -I | sed -r 's/(.[^ ]+).*/\1/g;s/\.//g')

if [ -z "${ZOOKEEPER_CONNECT}" ];then
	echo "ZOOKEEPER_CONNECT environment variable missing"
	echo "e.g. 127.0.0.1:3000,127.0.0.1:3001,127.0.0.1:3002"
	exit 1
fi

sed -i "s|{{BROKER_ID}}|${SERVER_ID}|g" /kafka/config/server.properties
sed -i "s|{{ADVERTISED_HOST_NAME}}|${HOSTNAME}|g" /kafka/config/server.properties
sed -i "s|{{ZOOKEEPER_CONNECT}}|${ZOOKEEPER_CONNECT}|g" /kafka/config/server.properties

export CLASSPATH=$CLASSPATH:/kafka/lib/slf4j-log4j12.jar
export JMX_PORT=7203

cat /kafka/config/server.properties

echo "Starting kafka"
exec /kafka/bin/kafka-server-start.sh /kafka/config/server.properties

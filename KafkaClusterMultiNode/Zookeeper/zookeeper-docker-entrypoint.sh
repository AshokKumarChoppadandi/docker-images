#!/bin/sh
#set -e

sed -i -e "s/ZOOKEEPER_HOST/$ZOOKEEPER_HOST/" /usr/local/kafka_2.12-2.3.1/config/zookeeper.properties
sed -i -e "s/ZOOKEEPER_PORT/$ZOOKEEPER_PORT/" /usr/local/kafka_2.12-2.3.1/config/zookeeper.properties

echo "Starting Zookeeper on $ZOOKEEPER_HOST:$ZOOKEEPER_PORT"
zookeeper-server-start.sh /usr/local/kafka_2.12-2.3.1/config/zookeeper.properties


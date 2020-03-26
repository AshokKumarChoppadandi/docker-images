#!/bin/sh
#set -e

sed -i -e "s/LISTENER_TYPE/$LISTENER_TYPE/" /usr/local/kafka_2.12-2.3.1/config/server.properties 
sed -i -e "s/BROKER_ID/$BROKER_ID/" /usr/local/kafka_2.12-2.3.1/config/server.properties
sed -i -e "s/BROKER_HOST/$BROKER_HOST/" /usr/local/kafka_2.12-2.3.1/config/server.properties
sed -i -e "s/BROKER_PORT/$BROKER_PORT/" /usr/local/kafka_2.12-2.3.1/config/server.properties
sed -i -e "s/DEFAULT_PARTITIONS/$DEFAULT_PARTITIONS/" /usr/local/kafka_2.12-2.3.1/config/server.properties
sed -i -e "s/ZOOKEEPERS_LIST/$ZOOKEEPERS_LIST/" /usr/local/kafka_2.12-2.3.1/config/server.properties

echo "Starting Kafka Broker on $BROKER_HOST:$BROKER_PORT"
kafka-server-start.sh /usr/local/kafka_2.12-2.3.1/config/server.properties

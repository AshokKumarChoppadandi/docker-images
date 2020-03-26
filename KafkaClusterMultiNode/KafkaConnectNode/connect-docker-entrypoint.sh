#!/bin/sh
#set -e

sed -i -e "s/LISTENER_TYPE/$LISTENER_TYPE/" /usr/local/kafka_2.12-2.3.1/config/connect-distributed.properties
sed -i -e "s/BROKERS_LIST/$BROKERS_LIST/" /usr/local/kafka_2.12-2.3.1/config/connect-distributed.properties
sed -i -e "s/CONNECT_HOST/$CONNECT_HOST/" /usr/local/kafka_2.12-2.3.1/config/connect-distributed.properties
sed -i -e "s/CONNECT_PORT/$CONNECT_PORT/" /usr/local/kafka_2.12-2.3.1/config/connect-distributed.properties
sed -i -e "s/CONNECT_REST_ADVERTISED_HOST/$CONNECT_REST_ADVERTISED_HOST/" /usr/local/kafka_2.12-2.3.1/config/connect-distributed.properties
sed -i -e "s/CONNECT_REST_ADVERTISED_PORT/$CONNECT_REST_ADVERTISED_PORT/" /usr/local/kafka_2.12-2.3.1/config/connect-distributed.properties

echo "Starting Kafka Connect Cluster on $CONNECT_HOST:$CONNECT_PORT"
connect-distributed.sh /usr/local/kafka_2.12-2.3.1/config/connect-distributed.properties

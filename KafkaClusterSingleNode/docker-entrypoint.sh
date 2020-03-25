#!/bin/sh
#set -e

sed -i -e "s/ZOOKEEPER_HOST/$ZOOKEEPER_HOST/" /usr/local/kafka_2.12-2.3.1/config/zookeeper.properties
sed -i -e "s/ZOOKEEPER_PORT/$ZOOKEEPER_PORT/" /usr/local/kafka_2.12-2.3.1/config/zookeeper.properties
sed -i -e "s/BROKER_ID/$BROKER_ID/" /usr/local/kafka_2.12-2.3.1/config/server.properties
sed -i -e "s/BROKER_HOST/$BROKER_HOST/" /usr/local/kafka_2.12-2.3.1/config/server.properties
sed -i -e "s/BROKER_PORT/$BROKER_PORT/" /usr/local/kafka_2.12-2.3.1/config/server.properties
sed -i -e "s/DEFAULT_PARTITIONS/$DEFAULT_PARTITIONS/" /usr/local/kafka_2.12-2.3.1/config/server.properties
sed -i -e "s/ZOOKEEPERS_LIST/$ZOOKEEPERS_LIST/" /usr/local/kafka_2.12-2.3.1/config/server.properties
sed -i -e "s/BROKERS_LIST/$BROKERS_LIST/" /usr/local/kafka_2.12-2.3.1/config/connect-distributed.properties
sed -i -e "s/CONNECT_HOST/$CONNECT_HOST/" /usr/local/kafka_2.12-2.3.1/config/connect-distributed.properties
sed -i -e "s/CONNECT_PORT/$CONNECT_PORT/" /usr/local/kafka_2.12-2.3.1/config/connect-distributed.properties
sed -i -e "s/CONNECT_REST_ADVERTISED_HOST/$CONNECT_REST_ADVERTISED_HOST/" /usr/local/kafka_2.12-2.3.1/config/connect-distributed.properties
sed -i -e "s/CONNECT_REST_ADVERTISED_PORT/$CONNECT_REST_ADVERTISED_PORT/" /usr/local/kafka_2.12-2.3.1/config/connect-distributed.properties


echo "Starting Zookeeper on $ZOOKEEPER_HOST:$ZOOKEEPER_PORT"
zookeeper-server-start.sh /usr/local/kafka_2.12-2.3.1/config/zookeeper.properties &
echo "Zookeeper started...!!!"
echo "sleeping for 5 seconds...!!!"
sleep 5

echo "Starting Kafka Broker on $BROKER_HOST:$BROKER_PORT"
kafka-server-start.sh /usr/local/kafka_2.12-2.3.1/config/server.properties &
echo "Kafka Broker started...!!!"
echo "sleeping for 5 seconds...!!!"
sleep 5

echo "Starting Kafka Connect on $CONNECT_HOST:$CONNECT_PORT"
connect-distributed.sh /usr/local/kafka_2.12-2.3.1/config/connect-distributed.properties &
echo "Kafka Connect started...!!!"
echo "sleeping for 5 seconds...!!!"
sleep 5

exec "$@"

#!/bin/sh
#set -e

sed -i -e "s/ZOOKEEPER_HOST/$ZOOKEEPER_HOST/" /usr/local/confluent-5.3.3/config/zookeeper.properties
sed -i -e "s/ZOOKEEPER_CLIENT_PORT/$ZOOKEEPER_PORT/" /usr/local/confluent-5.3.3/config/zookeeper.properties
sed -i -e "s/ZOOKEEPER_DATA_DIR/$ZOOKEEPER_DATA_DIR/" /usr/local/confluent-5.3.3/config/zookeeper.properties
sed -i -e "s/ZOOKEEPER_TICK_TIME/$ZOOKEEPER_TICK_TIME/" /usr/local/confluent-5.3.3/config/zookeeper.properties

sed -i -e "s/BROKER_ID/$BROKER_ID/" /usr/local/confluent-5.3.3/config/server.properties
sed -i -e "s/KAFKA_LISTENERS/$KAFKA_LISTENERS/" /usr/local/confluent-5.3.3/config/server.properties
sed -i -e "s/KAFKA_ADVERTISED_LISTENERS/$KAFKA_ADVERTISED_LISTENERS/" /usr/local/confluent-5.3.3/config/server.properties
sed -i -e "s/KAFKA_DATA_DIRS/$KAFKA_DATA_DIRS/" /usr/local/confluent-5.3.3/config/server.properties
sed -i -e "s/DEFAULT_KAFKA_TOPIC_PARTITIONS/$DEFAULT_KAFKA_TOPIC_PARTITIONS/" /usr/local/confluent-5.3.3/config/server.properties
sed -i -e "s/ZOOKEEPERS_LIST/$ZOOKEEPERS_LIST/" /usr/local/confluent-5.3.3/config/server.properties
sed -i -e "s/CONFLUENT_METADATA_SERVER_ADVERTISED_LISTENERS/$CONFLUENT_METADATA_SERVER_ADVERTISED_LISTENERS/" /usr/local/confluent-5.3.3/config/server.properties

sed -i -e "s/ZOOKEEPERS_LIST/$ZOOKEEPERS_LIST/" /usr/local/confluent-5.3.3/config/schema-registry.properties
sed -i -e "s/KAFKA_ADVERTISED_LISTENERS/$KAFKA_ADVERTISED_LISTENERS/" /usr/local/confluent-5.3.3/config/schema-registry.properties

sed -i -e "s/KAFKA_ADVERTISED_LISTENERS/$KAFKA_ADVERTISED_LISTENERS/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties
sed -i -e "s/KAFKA_CONNECT_CLUSTER_GROUP_ID/$KAFKA_CONNECT_CLUSTER_GROUP_ID/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties
sed -i -e "s/KAFKA_CONNECT_KEY_CONVERTOR/$KAFKA_CONNECT_KEY_CONVERTOR/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties
sed -i -e "s/KAFKA_CONNECT_VALUE_CONVERTOR/$KAFKA_CONNECT_VALUE_CONVERTOR/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties
sed -i -e "s/SCHEMA_REGISTRY_URL/$SCHEMA_REGISTRY_URL/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties
sed -i -e "s/KAFKA_CONNECT_INTERNAL_KEY_CONVERTER/$KAFKA_CONNECT_INTERNAL_KEY_CONVERTER/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties
sed -i -e "s/KAFKA_CONNECT_INTERNAL_VALUE_CONVERTER/$KAFKA_CONNECT_INTERNAL_VALUE_CONVERTER/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties
sed -i -e "s/KAFKA_CONNECT_KEY_CONVERTER_SCHEMAS_ENABLE/$KAFKA_CONNECT_INTERNAL_KEY_CONVERTER_SCHEMAS_ENABLE/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties
sed -i -e "s/KAFKA_CONNECT_VALUE_CONVERTER_SCHEMAS_ENABLE/$KAFKA_CONNECT_INTERNAL_VALUE_CONVERTER_SCHEMAS_ENABLE/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties
sed -i -e "s/CONNECT_HOST/$CONNECT_HOST/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties
sed -i -e "s/CONNECT_PORT/$CONNECT_PORT/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties


echo "Starting Zookeeper on $ZOOKEEPER_HOST:$ZOOKEEPER_PORT"
zookeeper-server-start /usr/local/confluent-5.3.3/config/zookeeper.properties &
echo "Sleeping 5 seconds"
sleep 5

echo "Starting Kafka Broker on $KAFKA_ADVERTISED_LISTENERS"
kafka-server-start /usr/local/confluent-5.3.3/config/server.properties &
echo "Sleeping 5 seconds"
sleep 5

echo "Starting Schema Registry $HOSTNAME:8081"
schema-registry-start /usr/local/confluent-5.3.3/config/schema-registry.properties &
echo "Sleeping 5 seconds"
sleep 5

echo "Starting Kafka Connect $CONNECT_HOST:CONNECT_PORT"
connect-distributed /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties

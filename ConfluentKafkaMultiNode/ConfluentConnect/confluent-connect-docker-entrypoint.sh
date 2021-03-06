#!/bin/sh
#set -e

PROPERTIES_FILE=$CONFLUENT_HOME/config/connect-avro-distributed.properties
sed -i -e "s/KAFKA_ADVERTISED_LISTENERS/$KAFKA_ADVERTISED_LISTENERS/" $PROPERTIES_FILE
sed -i -e "s/KAFKA_CONNECT_CLUSTER_GROUP_ID/$KAFKA_CONNECT_CLUSTER_GROUP_ID/" $PROPERTIES_FILE
sed -i -e "s/KAFKA_CONNECT_KEY_CONVERTOR/$KAFKA_CONNECT_KEY_CONVERTOR/" $PROPERTIES_FILE
sed -i -e "s/KAFKA_CONNECT_VALUE_CONVERTOR/$KAFKA_CONNECT_VALUE_CONVERTOR/" $PROPERTIES_FILE
sed -i -e "s/SCHEMA_REGISTRY_URL/$SCHEMA_REGISTRY_URL/" $PROPERTIES_FILE
sed -i -e "s/CONNECT_CONFIGS_TOPIC/$CONNECT_CONFIGS_TOPIC/" $PROPERTIES_FILE
sed -i -e "s/CONNECT_OFFSETS_TOPIC/$CONNECT_OFFSETS_TOPIC/" $PROPERTIES_FILE
sed -i -e "s/CONNECT_STATUSES_TOPIC/$CONNECT_STATUSES_TOPIC/" $PROPERTIES_FILE
sed -i -e "s/CONFIG_STORAGE_REPLICATION_FACTOR/$CONFIG_STORAGE_REPLICATION_FACTOR/" $PROPERTIES_FILE
sed -i -e "s/OFFSET_STORAGE_REPLICATION_FACTOR/$OFFSET_STORAGE_REPLICATION_FACTOR/" $PROPERTIES_FILE
sed -i -e "s/STATUS_STORAGE_REPLICATION_FACTOR/$STATUS_STORAGE_REPLICATION_FACTOR/" $PROPERTIES_FILE
sed -i -e "s/CONNECT_HOST/$CONNECT_HOST/" $PROPERTIES_FILE
sed -i -e "s/CONNECT_PORT/$CONNECT_PORT/" $PROPERTIES_FILE


echo "Starting Kafka Connect Cluster on $CONNECT_HOST:$CONNECT_PORT"
connect-distributed $PROPERTIES_FILE

#!/bin/sh
#set -e

PROPERTIES_FILE=$CONFLUENT_HOME/config/schema-registry.properties
sed -i -e "s/ZOOKEEPERS_LIST/$ZOOKEEPERS_LIST/" $PROPERTIES_FILE
sed -i -e "s/KAFKA_ADVERTISED_LISTENERS/$KAFKA_ADVERTISED_LISTENERS/" $PROPERTIES_FILE

echo "Starting CONFLUENT SCHEMA REGISTRY...!!!"
schema-registry-start $PROPERTIES_FILE

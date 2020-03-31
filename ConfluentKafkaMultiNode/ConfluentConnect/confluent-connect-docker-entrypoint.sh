#!/bin/sh
#set -e

sed -i -e "s/KAFKA_ADVERTISED_LISTENERS/$KAFKA_ADVERTISED_LISTENERS/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties
sed -i -e "s/KAFKA_CONNECT_CLUSTER_GROUP_ID/$KAFKA_CONNECT_CLUSTER_GROUP_ID/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties
sed -i -e "s/KAFKA_CONNECT_KEY_CONVERTOR/$KAFKA_CONNECT_KEY_CONVERTOR/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties
sed -i -e "s/KAFKA_CONNECT_VALUE_CONVERTOR/$KAFKA_CONNECT_VALUE_CONVERTOR/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties
sed -i -e "s/SCHEMA_REGISTRY_URL/$SCHEMA_REGISTRY_URL/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties
sed -i -e "s/KAFKA_CONNECT_INTERNAL_KEY_CONVERTER/$KAFKA_CONNECT_INTERNAL_KEY_CONVERTER/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties
sed -i -e "s/KAFKA_CONNECT_INTERNAL_VALUE_CONVERTER/$KAFKA_CONNECT_INTERNAL_VALUE_CONVERTER/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties
#sed -i -e "s/KAFKA_CONNECT_KEY_CONVERTER_SCHEMAS_ENABLE/$KAFKA_CONNECT_INTERNAL_KEY_CONVERTER_SCHEMAS_ENABLE/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties
#sed -i -e "s/KAFKA_CONNECT_VALUE_CONVERTER_SCHEMAS_ENABLE/$KAFKA_CONNECT_INTERNAL_VALUE_CONVERTER_SCHEMAS_ENABLE/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties
sed -i -e "s/CONNECT_HOST/$CONNECT_HOST/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties
sed -i -e "s/CONNECT_PORT/$CONNECT_PORT/" /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties

echo "Starting Kafka Connect Cluster on $CONNECT_HOST:$CONNECT_PORT"
connect-distributed /usr/local/confluent-5.3.3/config/connect-avro-distributed.properties

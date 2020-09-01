#!/bin/sh

TOPICS_LIST=$(kafka-topics --bootstrap-server ${KAFKA_ADVERTISED_LISTENERS} --list)
BOOLEAN1=false
BOOLEAN2=false

for topic in $TOPICS_LIST; do
	if [[ "${INPUT_KAFKA_TOPIC}" == "${topic}" ]]; then
		BOOLEAN1=true
	fi
	if [[ "${OUTPUT_KAFKA_TOPIC}" == "${topic}" ]]; then
		BOOLEAN2=true
	fi
done

if [[ "$BOOLEAN1" == false ]]; then
	kafka-topics --bootstrap-server ${KAFKA_ADVERTISED_LISTENERS} --create --topic ${INPUT_KAFKA_TOPIC} --partitions ${INPUT_TOPIC_PARTITIONS} --replication-factor ${INPUT_TOPIC_REPLICATION_FACTOR}
	echo "TOPIC ${INPUT_KAFKA_TOPIC} CREATED AT [ `date` ] WITH PARTITIONS ${INPUT_TOPIC_PARTITIONS} AND REPLICATION FACTOR ${INPUT_TOPIC_REPLICATION_FACTOR}"
fi
if [[ "$BOOLEAN2" == false ]]; then
	kafka-topics --bootstrap-server ${KAFKA_ADVERTISED_LISTENERS} --create --topic ${OUTPUT_KAFKA_TOPIC} --partitions ${OUTPUT_TOPIC_PARTITIONS} --replication-factor ${OUTPUT_TOPIC_REPLICATION_FACTOR}
	echo "TOPIC ${OUTPUT_KAFKA_TOPIC} CREATED AT [ `date` ] WITH PARTITIONS ${OUTPUT_TOPIC_PARTITIONS} AND REPLICATION FACTOR ${OUTPUT_TOPIC_REPLICATION_FACTOR}"
fi

#java -jar /IdeaProjects/GlobalPlatformChangeLogKafkaStreamsApp/target/GlobalPlatformChangeLogKafkaStreamsApp-1.0-SNAPSHOT.jar
java -cp ${APP_JAR_PATH}${APP_JAR} ${CLASS_NAME} ${ENVIRONMENT} ${STREAMS_APP_CONFIG_ID} ${KAFKA_ADVERTISED_LISTENERS} ${AUTO_OFFSET_RESET_CONFIG} ${INPUT_KAFKA_TOPIC} ${OUTPUT_KAFKA_TOPIC}

FROM ashokkumarchoppadandi/confluent-kafka-base:0.1

LABEL maintainer="Ashok Kumar Choppadandi <ashokkumar98778@gmail.com>"

USER root

WORKDIR /

COPY ./streams-app-docker-entrypoint.sh /
RUN chmod +x /streams-app-docker-entrypoint.sh

ENV HOSTNAME streamsapp
ENV ENVIRONMENT dev
ENV KAFKA_ADVERTISED_LISTENERS localhost:9092
ENV STREAMS_APP_CONFIG_ID add-schema-employee
ENV INPUT_KAFKA_TOPIC employee
ENV INPUT_TOPIC_PARTITIONS 3
ENV INPUT_TOPIC_REPLICATION_FACTOR 1
ENV OUTPUT_KAFKA_TOPIC employee-with-schema
ENV OUTPUT_TOPIC_PARTITIONS 3
ENV OUTPUT_TOPIC_REPLICATION_FACTOR 1
ENV AUTO_OFFSET_RESET_CONFIG earliest
ENV APP_JAR EmployeeKafkaStreamsApp-1.0-SNAPSHOT.jar
ENV APP_JAR_PATH /IdeaProjects/EmployeeKafkaStreamsApp/target/
ENV CLASS_NAME com.bigdata.kafka.streams.AddSchemaToEmployeeJsonPayload

ENTRYPOINT ["/bin/sh", "-c", "/streams-app-docker-entrypoint.sh"]

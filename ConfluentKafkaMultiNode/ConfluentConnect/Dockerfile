FROM ashokkumarchoppadandi/confluent-kafka-base:0.0.1

LABEL maintainer="Ashok Kumar Choppadandi <ashokkumar98778@gmail.com>"

USER root

WORKDIR /

COPY ./confluent-connect-docker-entrypoint.sh /
RUN chmod +x /confluent-connect-docker-entrypoint.sh

ENV BROKER_HOST localhost
ENV BROKER_PORT 9092

ENV CONNECT_HOST localhost
ENV CONNECT_PORT 8083

ENV KAFKA_ADVERTISED_LISTENERS $BROKER_HOST:$BROKER_PORT
ENV KAFKA_CONNECT_CLUSTER_GROUP_ID: connect-cluster
ENV KAFKA_CONNECT_KEY_CONVERTOR: io.confluent.connect.avro.AvroConverter
ENV KAFKA_CONNECT_VALUE_CONVERTOR: io.confluent.connect.avro.AvroConverter
ENV SCHEMA_REGISTRY_URL: http:\/\/localhost:8081
ENV KAFKA_CONNECT_INTERNAL_KEY_CONVERTER: org.apache.kafka.connect.json.JsonConverter
ENV KAFKA_CONNECT_INTERNAL_VALUE_CONVERTER: org.apache.kafka.connect.json.JsonConverter

ENTRYPOINT ["./confluent-connect-docker-entrypoint.sh"]

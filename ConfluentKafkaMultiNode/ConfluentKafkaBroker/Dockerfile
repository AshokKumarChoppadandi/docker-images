FROM ashokkumarchoppadandi/confluent-kafka-base:5.5.3

LABEL maintainer="Ashok Kumar Choppadandi <ashokkumar98778@gmail.com>"

USER root

WORKDIR /

COPY ./confluent-broker-docker-entrypoint.sh /
RUN chmod +x /confluent-broker-docker-entrypoint.sh

ENV HOSTNAME localhost
ENV BROKER_ID 0
ENV KAFKA_LISTENERS PLAINTEXT:\/\/0.0.0.0:9092
ENV KAFKA_ADVERTISED_LISTENERS PLAINTEXT:\/\/localhost:9092
ENV KAFKA_DATA_DIRS "\/usr\/local\/confluent\/data\/kafka-logs"
ENV DEFAULT_KAFKA_TOPIC_PARTITIONS 1
ENV ZOOKEEPERS_LIST localhost:2181
ENV CONFLUENT_METADATA_SERVER_ADVERTISED_LISTENERS http:\/\/localhost:8090

ENTRYPOINT ["./confluent-broker-docker-entrypoint.sh"]

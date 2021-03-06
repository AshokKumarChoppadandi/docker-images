FROM ashokkumarchoppadandi/confluent-kafka-base:5.5.3

LABEL maintainer="Ashok Kumar Choppadandi <ashokkumar98778@gmail.com>"

USER root

WORKDIR /

ENV DB_DRIVER "https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.23/mysql-connector-java-8.0.23.jar"

COPY ./confluent-connect-docker-entrypoint.sh /
COPY lib/jcustenborder-kafka-connect-twitter-0.3.33 $CONFLUENT_HOME/share/java/
COPY lib/confluentinc-kafka-connect-elasticsearch-11.0.3 $CONFLUENT_HOME/share/java/
COPY lib/confluentinc-kafka-connect-hdfs-10.0.2 $CONFLUENT_HOME/share/java/
RUN chmod +x /confluent-connect-docker-entrypoint.sh \
    && yum install wget -y \
    && wget $DB_DRIVER \
    && mv *.jar $CONFLUENT_HOME/share/java/kafka-connect-jdbc/

ENV BROKER_HOST localhost
ENV BROKER_PORT 9092

ENV CONNECT_HOST localhost
ENV CONNECT_PORT 8083

ENV KAFKA_ADVERTISED_LISTENERS $BROKER_HOST:$BROKER_PORT
ENV KAFKA_CONNECT_CLUSTER_GROUP_ID connect-cluster
ENV KAFKA_CONNECT_KEY_CONVERTOR org.apache.kafka.connect.json.JsonConverter
ENV KAFKA_CONNECT_VALUE_CONVERTOR org.apache.kafka.connect.json.JsonConverter
ENV SCHEMA_REGISTRY_URL "http:\/\/localhost:8081"

ENV CONNECT_CONFIGS_TOPIC connect_configs
ENV CONNECT_OFFSETS_TOPIC connect_offsets
ENV CONNECT_STATUSES_TOPIC connect_statuses

ENV CONFIG_STORAGE_REPLICATION_FACTOR 1
ENV OFFSET_STORAGE_REPLICATION_FACTOR 1
ENV STATUS_STORAGE_REPLICATION_FACTOR 1


ENTRYPOINT ["./confluent-connect-docker-entrypoint.sh"]

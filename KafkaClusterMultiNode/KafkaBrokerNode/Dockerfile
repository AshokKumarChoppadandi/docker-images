FROM ashokkumarchoppadandi/apache-kafka-base:0.0.1

LABEL maintainer="Ashok Kumar Choppadandi <ashokkumar98778@gmail.com>"

USER root

WORKDIR /

COPY ./broker-docker-entrypoint.sh /

ENV HOSTNAME localhost
ENV ZOOKEEPERS $HOSTNAME:2181

ENV BROKER_ID 0
ENV LISTENER_TYPE PLAINTEXT
ENV BROKER_HOST $HOSTNAME
ENV BROKER_PORT 9092
ENV DEFAULT_PARTITIONS 3
ENV ZOOKEEPERS_LIST $ZOOKEEPERS

ENTRYPOINT ["./broker-docker-entrypoint.sh"]

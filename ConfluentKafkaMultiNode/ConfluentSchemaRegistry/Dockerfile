FROM ashokkumarchoppadandi/confluent-kafka-base:0.0.1

LABEL maintainer=AshokKumarChoppadandi<ashokkumar98778@gmail.com>

USER root

WORKDIR /

COPY ./schema-registry-docker-entrypoint.sh /
RUN chmod +x /schema-registry-docker-entrypoint.sh

ENV HOSTNAME localhost
ENV ZOOKEEPER_PORT 2181
ENV BROKER_PORT 9092
ENV ZOOKEEPERS_LIST $HOSTNAME:$ZOOKEEPER_PORT
ENV KAFKA_ADVERTISED_LISTENERS $HOSTNAME:$BROKER_PORT

ENTRYPOINT ["./schema-registry-docker-entrypoint.sh"]

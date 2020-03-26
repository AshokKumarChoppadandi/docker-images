FROM ashokkumarchoppadandi/apache-kafka-base:0.0.1

LABEL maintainer="Ashok Kumar Choppadandi <ashokkumar98778@gmail.com>"

USER root

WORKDIR /

COPY ./zookeeper-docker-entrypoint.sh /
RUN chmod +x /zookeeper-docker-entrypoint.sh

ENV HOSTNAME localhost
ENV ZOOKEEPER_HOST $HOSTNAME
ENV ZOOKEEPER_PORT 2181

ENTRYPOINT ["./zookeeper-docker-entrypoint.sh"]

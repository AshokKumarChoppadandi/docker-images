FROM centos:7

LABEL maintainer="Ashok Kumar Choppadandi <ashokkumar98778@gmail.com>"

USER root

WORKDIR /

COPY ./lib/* /

RUN yum update -y
RUN yum install java-1.8.0-openjdk-devel unzip -y
RUN tar -xzvf kafka_2.12-2.3.1.tgz -C /usr/local/

COPY ./config/*.properties usr/local/kafka_2.12-2.3.1/config/

RUN mkdir /usr/local/kafka_2.12-2.3.1/data
RUN mkdir /usr/local/kafka_2.12-2.3.1/libs/connectors
RUN unzip confluentinc-kafka-connect-jdbc-5.3.0.zip
RUN mv confluentinc-kafka-connect-jdbc-5.3.0 /usr/local/kafka_2.12-2.3.1/libs/connectors/
RUN mv mysql-connector-java-8.0.19.jar /usr/local/kafka_2.12-2.3.1/libs/
RUN mv postgresql-42.2.11.jar /usr/local/kafka_2.12-2.3.1/libs/

ENV KAFKA_HOME /usr/local/kafka_2.12-2.3.1
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.242.b08-0.el7_7.x86_64

ENV PATH $KAFKA_HOME/bin:$JAVA_HOME/bin:$PATH

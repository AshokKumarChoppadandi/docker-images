FROM centos:7

LABEL maintainer="Ashok Kumar Choppadandi <ashhokkumar98778@gmail.com>"

USER root

WORKDIR /

ADD ./lib/confluent-5.3.3-2.12.tar /usr/local/

RUN yum update -y
RUN yum install java-1.8.0-openjdk-devel -y
RUN mkdir /usr/local/confluent-5.3.3/config
RUN mkdir /usr/local/confluent-5.3.3/data

COPY ./config/*.properties /usr/local/confluent-5.3.3/config/
RUN ln -s /usr/local/confluent-5.3.3 /usr/local/confluent
ENV CONFLUENT_HOME /usr/local/confluent
ENV JAVA_HOME /usr/lib/jvm/java
ENV PATH $CONFLUENT_HOME/bin:$JAVA_HOME/bin:$PATH

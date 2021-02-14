FROM centos:7

LABEL maintainer="Ashok Kumar Choppadandi <ashhokkumar98778@gmail.com>"

USER root

WORKDIR /

ENV CONFLUENT_DOWNLOAD_URL "https://packages.confluent.io/archive/5.3/confluent-5.3.3-2.12.tar.gz?_ga=2.121363336.101920513.1612884122-1865835482.1584121891"
ENV CONFLUENT_HOME /usr/local/confluent

# ADD ./lib/confluent-5.3.3-2.12.tar /usr/local/

RUN yum update -y \
    && yum install java-1.8.0-openjdk-devel wget -y \
    && wget $CONFLUENT_DOWNLOAD_URL \
    && tar xzvf *.tar.gz* -C /usr/local \
    && ln -s /usr/local/confluent-* $CONFLUENT_HOME \
    && mkdir $CONFLUENT_HOME/config \
    && mkdir $CONFLUENT_HOME/data \
    && rm -rf *tar.gz* 

COPY ./config/*.properties $CONFLUENT_HOME/config/

ENV JAVA_HOME /usr/lib/jvm/java
ENV PATH $CONFLUENT_HOME/bin:$JAVA_HOME/bin:$PATH

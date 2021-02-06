FROM centos:7

EXPOSE 22/tcp
EXPOSE 22/udp

USER root

RUN useradd -m -s /bin/bash hadoop

WORKDIR /home/hadoop

LABEL maintainer="Ashok Kumar Choppadandi <ashokkumar98778@gmail.com>" description="CentOS with Java, Hadoop and Spark installation"

ENV HADOOP_DOWNLOAD_URL https://archive.apache.org/dist/hadoop/common/hadoop-2.7.6/hadoop-2.7.6.tar.gz
ENV SPARK_DOWNLOAD_URL https://downloads.apache.org/spark/spark-2.4.7/spark-2.4.7-bin-hadoop2.7.tgz

RUN yum clean all \
    && rpm --rebuilddb \
    && yum update -y libselinux \
    && yum install -y initscripts curl which tar sudo rsync openssh-server openssh-clients java-1.8.0-openjdk-devel wget \
    && ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa \
    && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
    && /usr/bin/ssh-keygen -A \
    && mkdir /home/hadoop/.ssh \
    && cp ~/.ssh/id_rsa* /home/hadoop/.ssh/ \
    && cat /home/hadoop/.ssh/id_rsa.pub >> /home/hadoop/.ssh/authorized_keys \
    && chown -R hadoop /home/hadoop/.ssh \
    && wget $HADOOP_DOWNLOAD_URL \
    && wget $SPARK_DOWNLOAD_URL \
    && tar -xzvf hadoop-*.tar.gz -C /usr/local/ \
    && tar -xzvf spark*.tgz -C /usr/local/ \
    && ln -s /usr/local/hadoop-* /usr/local/hadoop \
    && ln -s /usr/local/spark* /usr/local/spark \
    && rm -rf /home/hadoop/hadoop*.tar.gz \
    && rm -rf /home/hadoop/spark*.tgz
    

ADD config/ssh-config /home/hadoop/.ssh/config

COPY config/* /usr/local/hadoop/etc/hadoop/
RUN mkdir -p /usr/local/hadoop/data/nameNode /usr/local/hadoop/data/dataNode /usr/local/hadoop/data/namesecondary /usr/local/hadoop/data/tmp /usr/local/hadoop/spark \
    && chown hadoop /usr/local/hadoop/data/nameNode /usr/local/hadoop/data/dataNode /usr/local/hadoop/data/namesecondary /usr/local/hadoop/data/tmp /usr/local/hadoop/spark \
    && echo $JAVA_HOME >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh \
    && echo HDFS_NAMENODE_USER=hadoop >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh \
    && echo HDFS_DATANODE_USER=hadoop >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh \
    && echo HDFS_SECONDARYNAMENODE_USER=hadoop >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh

COPY hadoop-pseudonode-entrypoint.sh /home/hadoop/
RUN chmod +x /home/hadoop/hadoop-pseudonode-entrypoint.sh \
    && chown -R hadoop /home/hadoop/* \
    && chown -R hadoop /usr/local/hadoop*

ENV JAVA_HOME /usr/lib/jvm/java
ENV PATH $PATH:$JAVA_HOME/bin:/usr/local/hadoop/bin:/usr/local/hadoop/sbin:/usr/local/spark/bin
ENV HADOOP_HOME /usr/local/hadoop
ENV HADOOP_CONF_DIR /usr/local/hadoop/etc/hadoop

USER hadoop

ENTRYPOINT ["./hadoop-pseudonode-entrypoint.sh"]

CMD ["sh"]

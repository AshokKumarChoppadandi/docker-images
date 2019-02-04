FROM ashokkumarchoppadandi/hadoopbaseimage:latest

EXPOSE 22/tcp
EXPOSE 22/udp

LABEL maintainer="Ashok Kumar Choppadandi <ashokkumar98778@gmail.com>"

RUN useradd -m -s /bin/bash hadoop

WORKDIR /home/hadoop

COPY deps/hadoop-2.7.7.tar.gz /home/hadoop/

RUN tar -xzf hadoop-2.7.7.tar.gz -C /home/hadoop/
RUN rm -rf hadoop-2.7.7.tar.gz

COPY conf.d/*.xml /home/hadoop/hadoop-2.7.7/etc/hadoop/
COPY conf.d/slaves /home/hadoop/hadoop-2.7.7/etc/hadoop/

RUN mkdir /home/hadoop/.ssh
RUN echo PubkeyAcceptedKeyTypes +ssh-dss >> /home/hadoop/.ssh/config
RUN echo PasswordAuthentication no >> /home/hadoop/.ssh/config

COPY config/id_rsa /home/hadoop/.ssh/id_rsa
COPY config/id_rsa.pub /home/hadoop/.ssh/id_rsa.pub
RUN cat /home/hadoop/.ssh/id_rsa.pub >> /home/hadoop/.ssh/authorized_keys
RUN chown -R hadoop /home/hadoop/.ssh


ENV PATH /home/hadoop/hadoop-2.7.7/bin:/home/hadoop/hadoop-2.7.7/sbin:$PATH
ENV HADOOP_HOME /home/hadoop/hadoop-2.7.7
ENV HADOOP_CONF_DIR /home/hadoop/hadoop-2.7.7/etc/hadoop

RUN echo "export PATH=/home/hadoop/hadoop-2.7.7/bin:/home/hadoop/hadoop-2.7.7/sbin:$PATH" >> /home/hadoop/.profile
RUN echo "export PATH=/home/hadoop/hadoop-2.7.7/bin:/home/hadoop/hadoop-2.7.7/sbin:$PATH" >> /home/hadoop/.bashrc
RUN mkdir -p /home/hadoop/data/nameNode /home/hadoop/data/dataNode /home/hadoop/data/namesecondary /home/hadoop/data/tmp /home/hadoop/spark
RUN chown hadoop /home/hadoop/data/nameNode /home/hadoop/data/dataNode /home/hadoop/data/namesecondary /home/hadoop/data/tmp /home/hadoop/spark

RUN echo "export HADOOP_HOME=/home/hadoop/hadoop-2.7.7" >> /home/hadoop/.bashrc
RUN echo "export HADOOP_HOME=/home/hadoop/hadoop-2.7.7" >> /home/hadoop/.profile
RUN chown hadoop /home/hadoop/.bashrc /home/hadoop/.profile

RUN echo JAVA_HOME=/usr/java/default >> /home/hadoop/hadoop-2.7.7/etc/hadoop/hadoop-env.sh
RUN echo HDFS_NAMENODE_USER=hadoop >> /home/hadoop/hadoop-2.7.7/etc/hadoop/hadoop-env.sh
RUN echo HDFS_DATANODE_USER=hadoop >> /home/hadoop/hadoop-2.7.7/etc/hadoop/hadoop-env.sh
RUN echo HDFS_SECONDARYNAMENODE_USER=hadoop >> /home/hadoop/hadoop-2.7.7/etc/hadoop/hadoop-env.sh
RUN echo "export HADOOP_CONF_DIR=/home/hadoop/hadoop-2.7.7/etc/hadoop" >> /home/hadoop/.bashrc
RUN echo "export HADOOP_CONF_DIR=/home/hadoop/hadoop-2.7.7/etc/hadoop" >> /home/hadoop/.profile

RUN chown -R hadoop /home/hadoop/*

CMD source /home/hadoop/.bashrc && source /home/hadoop/.profile && echo $HADOOP_HOME

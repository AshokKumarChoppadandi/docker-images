FROM ashokkumarchoppadandi/hive:latest

LABEL maintainer="Ashok Kumar Choppadandi <ashokkumar98778@gmail.com>"

WORKDIR /home/hadoop

COPY ./deps/spark-2.3.2-bin-hadoop2.7.tgz /home/hadoop/
RUN tar -xzf spark-2.3.2-bin-hadoop2.7.tgz
RUN rm *.tgz
RUN mv spark-2.3.2-* spark-2.3.2
COPY config/spark-env.sh spark-2.3.2/conf/spark-env.sh

ENV SPARK_HOME /home/hadoop/spark-2.3.2
ENV PATH /home/hadoop/spark-2.3.2/bin:/home/hadoop/spark-2.3.2/sbin:$PATH
ENV HADOOP_CONF_DIR /home/hadoop/hadoop-2.7.7/etc/hadoop
ENV YARN_CONF_DIR /home/hadoop/hadoop-2.7.7/etc/hadoop

RUN echo "export SPARK_HOME=/home/hadoop/spark-2.3.2" >> /home/hadoop/.profile
RUN echo "export SPARK_HOME=/home/hadoop/spark-2.3.2" >> /home/hadoop/.bashrc

RUN echo "export HADOOP_CONF_DIR=/home/hadoop/hadoop-2.7.7/etc/hadoop" >> /home/hadoop/.profile
RUN echo "export HADOOP_CONF_DIR=/home/hadoop/hadoop-2.7.7/etc/hadoop" >> /home/hadoop/.bashrc

RUN echo "export YARN_CONF_DIR=/home/hadoop/hadoop-2.7.7/etc/hadoop" >> /home/hadoop/.profile
RUN echo "export YARN_CONF_DIR=/home/hadoop/hadoop-2.7.7/etc/hadoop" >> /home/hadoop/.bashrc

RUN echo PATH=$PATH:/home/hadoop/spark-2.3.2/bin >> /home/hadoop/.bashrc
RUN echo PATH=$PATH:/home/hadoop/spark-2.3.2/bin >> /home/hadoop/.profile
RUN echo PATH=$PATH:/home/hadoop/spark-2.3.2/sbin >> /home/hadoop/.bashrc
RUN echo PATH=$PATH:/home/hadoop/spark-2.3.2/sbin >> /home/hadoop/.profile

COPY config/workers /home/hadoop/spark-2.3.2/conf/slaves
COPY config/sparkcmd.sh /home/hadoop
COPY config/hive-site.xml /home/hadoop/spark-2.3.2/conf/
COPY deps/mysql-connector-java.jar /home/hadoop/spark-2.3.2/jars/

RUN chown -R hadoop /home/hadoop/*

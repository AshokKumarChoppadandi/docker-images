FROM ashokkumarchoppadandi/hadoop-base:latest

LABEL maintainer="Ashok Kumar Choppadandi <ashokkumar98778@gmail.com>"

WORKDIR /home/hadoop

ENV SPARK_DOWNLOAD_URL "https://downloads.apache.org/spark/spark-2.4.7/spark-2.4.7-bin-hadoop2.7.tgz"
ENV SPARK_HOME /usr/local/spark

COPY hadoop-distributed-spark-slavenode-entrypoint.sh /home/hadoop/
# COPY 
RUN chmod +x /home/hadoop/hadoop-distributed-spark-slavenode-entrypoint.sh \
    && chown -R hadoop /home/hadoop/ \
    && wget $SPARK_DOWNLOAD_URL \
    && tar -xzvf spark*.tgz -C /usr/local/ \
    && ln -s /usr/local/spark* $SPARK_HOME \
    && rm -rf /home/hadoop/spark*.tgz \
    && cp $HADOOP_HOME/etc/hadoop/*-site.xml $SPARK_HOME/conf/

ENV HOSTNAME localhost
ENV NAMENODE_HOST localhost
ENV SECONDARY_NAMENODE_HOST localhost
ENV RESOURCE_MANAGER_HOST localhost

ENV PATH $PATH:$SPARK_HOME/bin

ENTRYPOINT ["./hadoop-distributed-spark-slavenode-entrypoint.sh"]

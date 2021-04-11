FROM ashokkumarchoppadandi/hadoop-base:latest

LABEL maintainer="Ashok Kumar Choppadandi <ashokkumar98778@gmail.com>"

WORKDIR /home/hadoop

ENV SPARK_DOWNLOAD_URL "https://downloads.apache.org/spark/spark-2.4.7/spark-2.4.7-bin-hadoop2.7.tgz"
ENV SPARK_HOME /usr/local/spark
ENV HIVE_DOWNLOAD_URL "https://mirrors.estointernet.in/apache/hive/hive-2.3.8/apache-hive-2.3.8-bin.tar.gz"
ENV MYSQL_CONNECTOR_JAR "https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.23/mysql-connector-java-8.0.23.jar"
ENV HIVE_HOME /usr/local/hive
ENV HIVE_CONF_DIR $HIVE_HOME/conf
ENV METASTORE_HOST localhost

COPY hadoop-distributed-spark-hive-slavenode-entrypoint.sh /home/hadoop/
# COPY 
RUN chmod +x /home/hadoop/hadoop-distributed-spark-hive-slavenode-entrypoint.sh \
    && chown -R hadoop /home/hadoop/ \
    && wget $SPARK_DOWNLOAD_URL \
    && tar -xzvf spark*.tgz -C /usr/local/ \
    && ln -s /usr/local/spark* $SPARK_HOME \
    && rm -rf /home/hadoop/spark*.tgz \
    && cp $HADOOP_HOME/etc/hadoop/*-site.xml $SPARK_HOME/conf/

RUN wget $HIVE_DOWNLOAD_URL \
    && tar -xzvf apache-hive-*.tar.gz -C /usr/local  \
    && rm -rf /home/hadoop/apache-hive-*.tar.gz \
    && ln -s /usr/local/apache-hive-* $HIVE_HOME \
    && wget $MYSQL_CONNECTOR_JAR \
    && mv /home/hadoop/mysql-connector*.jar $HIVE_HOME/lib \
    && chown -R hadoop /home/hadoop/* \
    && chown -R hadoop /usr/local/hive*

COPY config/hive-site.xml $HIVE_HOME/conf/

ENV HOSTNAME localhost
ENV NAMENODE_HOST localhost
ENV SECONDARY_NAMENODE_HOST localhost
ENV RESOURCE_MANAGER_HOST localhost

ENV PATH $PATH:$SPARK_HOME/bin:$HIVE_HOME/bin

ENTRYPOINT ["./hadoop-distributed-spark-hive-slavenode-entrypoint.sh"]

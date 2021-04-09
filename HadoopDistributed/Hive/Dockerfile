FROM ashokkumarchoppadandi/hadoop-base:latest

LABEL maintainer="Ashok Kumar Choppadandi <ashokkumar98778@gmail.com>"

USER root

WORKDIR /home/hadoop

ENV HIVE_DOWNLOAD_URL "https://mirrors.estointernet.in/apache/hive/hive-2.3.8/apache-hive-2.3.8-bin.tar.gz"
ENV MYSQL_CONNECTOR_JAR "https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.23/mysql-connector-java-8.0.23.jar"
ENV HIVE_HOME /usr/local/hive
ENV HIVE_CONF_DIR $HIVE_HOME/conf
ENV METASTORE_HOST localhost
ENV NAMENODE_HOST localhost
ENV RESOURCE_MANAGER_HOST localhost
ENV HISTORY_SERVER_HOST localhost

COPY hadoop-distributed-hive-entrypoint.sh /home/hadoop/

RUN wget $HIVE_DOWNLOAD_URL \
    && tar -xzvf apache-hive-*.tar.gz -C /usr/local  \
    && rm -rf /home/hadoop/apache-hive-*.tar.gz \
    && ln -s /usr/local/apache-hive-* $HIVE_HOME \
    && wget $MYSQL_CONNECTOR_JAR \
    && mv /home/hadoop/mysql-connector*.jar $HIVE_HOME/lib \
    && chown -R hadoop /home/hadoop/* \
    && chown -R hadoop /usr/local/hive* \
    && chmod +x hadoop-distributed-hive-entrypoint.sh

COPY config/hive-site.xml /usr/local/hive/conf/

ENV PATH $HIVE_HOME/bin:$PATH

ENTRYPOINT ["./hadoop-distributed-hive-entrypoint.sh"]



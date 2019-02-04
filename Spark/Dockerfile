FROM ashokkumarchoppadandi/hadoopbaseimage

LABEL maintainer="Ashok Kumar Choppadandi <ashokkumar98778@gmail.com>" description="Apache Spark Docker image on CentOS"

EXPOSE 22/tcp
EXPOSE 22/udp

RUN useradd -m -s /bin/bash hadoop

WORKDIR /home/hadoop
COPY deps/* /home/hadoop/
RUN tar -zxf spark-2.3.2-*.tgz
RUN rm *.tgz
RUN mv spark-2.3.2-* spark-2.3.2
RUN chown -R hadoop spark-2.3.2
COPY config/spark-env.sh spark-2.3.2/conf/spark-env.sh

RUN mkdir /home/hadoop/.ssh 
RUN echo PubkeyAcceptedKeyTypes +ssh-dss >> /home/hadoop/.ssh/config
RUN echo PasswordAuthentication no >> /home/hadoop/.ssh/config

COPY config/id_rsa.pub /home/hadoop/.ssh/id_rsa.pub
COPY config/id_rsa /home/hadoop/.ssh/id_rsa
RUN cat /home/hadoop/.ssh/id_rsa.pub >> /home/hadoop/.ssh/authorized_keys
RUN chown hadoop .ssh -R

#RUN echo "export HADOOP_CONF_DIR=/home/hadoop/hadoop/etc/hadoop" >> /home/hadoop/.bashrc
#RUN echo "export HADOOP_CONF_DIR=/home/hadoop/hadoop/etc/hadoop" >> /home/hadoop/.profile
#RUN echo "export SPARK_DIST_CLASSPATH=\$(hadoop classpath)" >> /home/hadoop/.bashrc
#RUN echo "export SPARK_DIST_CLASSPATH=\$(hadoop classpath)" >> /home/hadoop/.profile
RUN echo "export SPARK_HOME=/home/hadoop/spark-2.3.2" >> /home/hadoop/.profile
RUN echo "export SPARK_HOME=/home/hadoop/spark-2.3.2" >> /home/hadoop/.bashrc

RUN echo PATH=$PATH:/home/hadoop/spark-2.3.2/bin >> /home/hadoop/.bashrc
RUN echo PATH=$PATH:/home/hadoop/spark-2.3.2/bin >> /home/hadoop/.profile

COPY config/workers /home/hadoop/spark/conf/slaves
COPY config/sparkcmd.sh /home/hadoop

RUN chown -R hadoop /home/hadoop/*

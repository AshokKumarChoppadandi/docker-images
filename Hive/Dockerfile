FROM ashokkumarchoppadandi/hadoop

WORKDIR /home/hadoop

COPY ./deps/apache-hive-2.3.4-bin.tar.gz /home/hadoop/
RUN tar -xzf apache-hive-2.3.4-bin.tar.gz -C /home/hadoop/
RUN rm -rf apache-hive-*.tgz
COPY ./conf.d/hive-site.xml /home/hadoop/apache-hive-2.3.4-bin/conf/
COPY ./deps/mysql-connector-java.jar /home/hadoop/apache-hive-2.3.4-bin/lib/
RUN ln -s apache-hive-2.3.4-bin /home/hadoop/hive

ENV HIVE_HOME /home/hadoop/hive
ENV PATH /home/hadoop/hive/bin:$PATH
ENV HIVE_CONF_DIR /home/hadoop/hive/conf

RUN echo "export PATH=/home/hadoop/hive/bin:$PATH" >> /home/hadoop/.profile
RUN echo "export PATH=/home/hadoop/hive/bin:$PATH" >> /home/hadoop/.bashrc

RUN echo "export HIVE_HOME=/home/hadoop/hive" >> /home/hadoop/.profile
RUN echo "export HIVE_HOME=/home/hadoop/hive" >> /home/hadoop/.bashrc

RUN chown hadoop /home/hadoop/.bashrc /home/hadoop/.profile
RUN chown -R hadoop /home/hadoop/*

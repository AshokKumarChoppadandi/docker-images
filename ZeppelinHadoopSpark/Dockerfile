FROM ashokkumarchoppadandi/hadoopspark:latest

LABEL maintainer="Ashok Kumar Choppadandi<ashokkumar98778@gmail.com>" description="Zeppelin Docker image on top of HadoopSpark docker image"

WORKDIR /home/hadoop

COPY ./deps/zeppelin-0.8.1-bin-all.tgz /home/hadoop
RUN tar -xzf zeppelin-0.8.1*.tgz -C /home/hadoop
RUN rm -rf zeppelin-0.8.1*.tgz
RUN mv zeppelin-0.8.1* zeppelin-0.8.1
COPY ./config/* zeppelin-0.8.1/conf/

ENV ZEPPELIN_HOME /home/hadoop/zeppelin-0.8.1
ENV PATH /home/hadoop/zeppelin-0.8.1/bin:$PATH

RUN chown -R hadoop /home/hadoop/*

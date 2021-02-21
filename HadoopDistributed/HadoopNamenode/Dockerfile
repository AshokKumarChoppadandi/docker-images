FROM ashokkumarchoppadandi/hadoop-base:latest

LABEL maintainer="Ashok Kumar Choppadandi <ashokkumar98778@gmail.com>"

WORKDIR /home/hadoop

COPY hadoop-distributed-namenode-entrypoint.sh /home/hadoop/
RUN chmod +x /home/hadoop/hadoop-distributed-namenode-entrypoint.sh \
    && chown -R hadoop /home/hadoop/

ENV HOSTNAME localhost
ENV NAMENODE_HOST localhost
ENV RESOURCE_MANAGER_HOST localhost

ENTRYPOINT ["./hadoop-distributed-namenode-entrypoint.sh"]

FROM centos:latest

USER root

WORKDIR /tmp/

LABEL maintainer="Ashok Kumar Choppadandi <ashokkumar98778@gmail.com>" description="CentOS with Java installed"

RUN yum clean all; \
rpm --rebuilddb; \
yum install -y initscripts curl which tar sudo rsync openssh-server openssh-clients

RUN yum update -y libselinux

ADD config/ssh-config /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN chown root:root /root/.ssh/config

RUN echo "/usr/sbin/sshd" >> ~/.bashrc

RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN /usr/bin/ssh-keygen -A

COPY deps/jdk-8u191-linux-x64.rpm /tmp/
RUN rpm -i jdk-8u191-linux-x64.rpm
RUN rm jdk-8u191-linux-x64.rpm

COPY deps/scala-2.11.8.tgz /tmp/
RUN tar xzf scala-2.11.8.tgz
RUN mv scala-2.11.8 /usr/share/scala
RUN ln -s /usr/share/scala/bin/* /usr/bin
RUN rm scala-2.11.8.tgz

RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm
RUN yum install -y python36u python36u-libs python36u-devel python36u-pip
RUN yum install -y epel-release
RUN yum install -y python-pip

ENV JAVA_HOME /usr/java/default
ENV SCALA_HOME /usr/share/scala
ENV PATH $PATH:$JAVA_HOME/bin:$SCALA_HOME/bin

RUN rm /usr/bin/java && ln -s $JAVA_HOME/bin/java /usr/bin/java

CMD java -version && scala -version

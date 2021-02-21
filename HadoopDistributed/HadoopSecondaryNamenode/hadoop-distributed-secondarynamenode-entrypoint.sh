#!/bin/sh
#set -e

HADOOP_PROPERTIES_FILE=$HADOOP_HOME/etc/hadoop/core-site.xml
sed -i -e "s/HOSTNAME/$NAMENODE_HOST/" $HADOOP_PROPERTIES_FILE

YARN_PROPERTIES_FILE=$HADOOP_HOME/etc/hadoop/yarn-site.xml
sed -i -e "s/HOSTNAME/$RESOURCE_MANAGER_HOST/" $YARN_PROPERTIES_FILE

echo "Starting Secondary Namenode Service."
hadoop-daemon.sh start secondarynamenode

sleep 2
tail -f $HADOOP_HOME/logs/hadoop--secondarynamenode-$(hostname).log

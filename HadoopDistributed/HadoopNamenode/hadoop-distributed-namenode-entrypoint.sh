#!/bin/sh
#set -e

HADOOP_PROPERTIES_FILE=$HADOOP_HOME/etc/hadoop/core-site.xml
sed -i -e "s/HOSTNAME/$NAMENODE_HOST/" $HADOOP_PROPERTIES_FILE

YARN_PROPERTIES_FILE=$HADOOP_HOME/etc/hadoop/yarn-site.xml
sed -i -e "s/HOSTNAME/$RESOURCE_MANAGER_HOST/" $YARN_PROPERTIES_FILE

echo "Formatting Namenodes..."
hdfs namenode -format
sleep 2

echo "Starting Namenode Service."
hadoop-daemon.sh start namenode

sleep 2
tail -f $HADOOP_HOME/logs/hadoop--namenode-$(hostname).log

#!/bin/sh
#set -e

HADOOP_PROPERTIES_FILE=$HADOOP_HOME/etc/hadoop/core-site.xml
sed -i -e "s/HOSTNAME/$NAMENODE_HOST/" $HADOOP_PROPERTIES_FILE
sed -i -e "s/HOSTNAME/$NAMENODE_HOST/" $HADOOP_PROPERTIES_FILE

YARN_PROPERTIES_FILE=$HADOOP_HOME/etc/hadoop/yarn-site.xml
sed -i -e "s/HOSTNAME/$RESOURCE_MANAGER_HOST/" $YARN_PROPERTIES_FILE

MAPRED_PROPERTIES_FILE=$HADOOP_HOME/etc/hadoop/mapred-site.xml
sed -i -e "s/HOSTNAME/$MR_HISTORYSERVER_HOST/" $MAPRED_PROPERTIES_FILE

cp $HADOOP_HOME/etc/hadoop/*-site.xml $SPARK_HOME/conf/

echo "Starting Datanode..."
hadoop-daemon.sh start datanode

sleep 2
echo "Starting Node Manager..."
yarn-daemon.sh start nodemanager

sleep 2
tail -f $HADOOP_HOME/logs/yarn--nodemanager-$(hostname).log


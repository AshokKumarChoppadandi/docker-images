#!/bin/sh
#set -e


YARN_PROPERTIES_FILE=$HADOOP_HOME/etc/hadoop/yarn-site.xml
sed -i -e "s/HOSTNAME/$RESOURCE_MANAGER_HOST/" $YARN_PROPERTIES_FILE

HADOOP_PROPERTIES_FILE=$HADOOP_HOME/etc/hadoop/core-site.xml
sed -i -e "s/HOSTNAME/$NAMENODE_HOST/" $HADOOP_PROPERTIES_FILE

MAPRED_PROPERTIES_FILE=$HADOOP_HOME/etc/hadoop/mapred-site.xml
sed -i -e "s/HOSTNAME/$MR_HISTORYSERVER_HOST/" $MAPRED_PROPERTIES_FILE

echo "Starting MR History Server Service..."
mr-jobhistory-daemon.sh start historyserver

sleep 2
tail -f $HADOOP_HOME/logs/mapred--historyserver-$(hostname).log

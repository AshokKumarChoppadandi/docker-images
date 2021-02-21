#!/bin/sh
#set -e


YARN_PROPERTIES_FILE=$HADOOP_HOME/etc/hadoop/yarn-site.xml
sed -i -e "s/HOSTNAME/$RESOURCE_MANAGER_HOST/" $YARN_PROPERTIES_FILE

HADOOP_PROPERTIES_FILE=$HADOOP_HOME/etc/hadoop/core-site.xml
sed -i -e "s/HOSTNAME/$NAMENODE_HOST/" $HADOOP_PROPERTIES_FILE

echo "Starting Resource Manager Service."
yarn-daemon.sh start resourcemanager

sleep 2
tail -f $HADOOP_HOME/logs/yarn--resourcemanager-$(hostname).log

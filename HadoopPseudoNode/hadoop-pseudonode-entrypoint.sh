#!/bin/sh
#set -e

sed -i -e "s/HOSTNAME/$HOSTNAME/" $HADOOP_HOME/etc/hadoop/core-site.xml
sed -i -e "s/HOSTNAME/$HOSTNAME/" $HADOOP_HOME/etc/hadoop/yarn-site.xml
sed -i -e "s/HOSTNAME/$HOSTNAME/" $HADOOP_HOME/etc/hadoop/slaves

echo "Formatting Namenodes..."
hdfs namenode -format
sleep 2

echo "\nStarting HDFS Services."
echo "Starting Namenode..."
nohup hadoop-daemon.sh start namenode >> namenode-start.log 2>&1 &
sleep 2


echo "Starting Secondary Namenode..."
nohup hadoop-daemon.sh start secondarynamenode >> secondary-namenode-start.log 2>&1 &
sleep 2


echo "Starting Datanode..."
nohup hadoop-daemon.sh start datanode >> datanode-start.log 2>&1 &
sleep 2


echo "\nStarting YARN Services."
echo "Starting RESOURCE MANAGER..."
nohup yarn-daemon.sh start resourcemanager >> resourcemanager-start.log 2>&1 &

echo "Starting NODEMANAGER..."
nohup yarn-daemon.sh start nodemanager >> nodemanager-start.log 2>&1 &

echo "Starting JOB HISTORY SERVER..."
nohup mr-jobhistory-daemon.sh start historyserver >> historyserver-start.log 2>&1 &

exec "$@"

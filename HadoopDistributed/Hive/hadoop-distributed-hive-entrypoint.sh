#!/bin/sh
#set -e

HADOOP_PROPERTIES_FILE=$HADOOP_HOME/etc/hadoop/core-site.xml
sed -i -e "s/HOSTNAME/$NAMENODE_HOST/" $HADOOP_PROPERTIES_FILE

YARN_PROPERTIES_FILE=$HADOOP_HOME/etc/hadoop/yarn-site.xml
sed -i -e "s/HOSTNAME/$RESOURCE_MANAGER_HOST/" $YARN_PROPERTIES_FILE

MAPRED_PROEPRTIES_FILE=$HADOOP_HOME/etc/hadoop/mapred-site.xml
sed -i -e "s/HOSTNAME/$HISTORY_SERVER_HOST/" $MAPRED_PROEPRTIES_FILE

HIVE_PROPERTIES_FILE=$HIVE_HOME/conf/hive-site.xml
sed -i -e "s/METASTORE_HOST/$METASTORE_HOST/" $HIVE_PROPERTIES_FILE

echo "Starting Datanode..."
hadoop-daemon.sh start datanode

sleep 2
echo "Starting Node Manager..."
yarn-daemon.sh start nodemanager

sleep 2

hdfs dfs -mkdir -p /user/hive/warehouse
hdfs dfs -chmod g+w /user/hive/warehouse
hdfs dfs -mkdir /tmp
hdfs dfs -chmod g+w /tmp

echo "Sleeping started at" + $(date)
sleep 120
echo "Sleeping completed at" + $(date)

schematool -dbType mysql -initSchema --verbose

# --hiveconf hive.server2.thrift.port=10000
# hive --service hiveserver2 --hiveconf hive.root.logger=INFO,console

tail -f /dev/null

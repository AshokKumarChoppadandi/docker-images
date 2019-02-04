#!/bin/bash

# Starting the services
function upDaemons {
  docker start mysql-metastore nodemaster node2 node3 node4
  sleep 5
  echo "Staring HDFS ...!!!"
  docker exec -u hadoop -it nodemaster start-dfs.sh
  sleep 5
  echo "Starting YARN ...!!!"
  docker exec -u hadoop -it nodemaster start-yarn.sh
  sleep 5
  echo "Starting MAP REDUCE HISTORY SERVER"
  docker exec -u hadoop -it nodemaster mr-jobhistory-daemon.sh start historyserver
  sleep 5
  # Creating default Hive HDFS warehouse directory
  docker exec -u hadoop -it nodemaster hdfs dfs -mkdir -p /tmp
  docker exec -u hadoop -it nodemaster hdfs dfs -mkdir -p /user/hive/warehouse
  docker exec -u hadoop -it nodemaster hdfs dfs -chmod g+w /tmp
  docker exec -u hadoop -it nodemaster hdfs dfs -chmod g+w /user/hive/warehouse
  
  # Setting Hive Metastore to MYSQL database
  docker exec -u hadoop -it nodemaster schematool -dbType mysql -initSchema
  
  echo "Namenode is running @ nodemaster: http://172.18.1.1:50070"
  echo "Resource Manager is running @ nodemaster: http://172.18.1.1:8088"
  echo "Mapreduce History Server is running @ nodemaster: http://172.18.1.1:19888"
  echo "Hive Server2 is running @ nodemaster: http://172.18.1.1:10000"
}

if [[ $1 = "start" ]]; then
  echo "Starting the Hadoop Services...!!!"
  upDaemons
  exit
fi

if [[ $1 = "stop" ]]; then
  echo "Stopping the Hadoop Services...!!!"
  docker stop nodemaster node2 node3 node4
  exit
fi

if [[ $1 = "deploy" ]]; then
  docker rm -f `docker ps -aq`
  docker network rm hadoop_network
  docker network create --subnet=172.18.0.0/16 hadoop_network

  echo "Deploying MySQL database as Hive Metastore"
  docker run  -d --net hadoop_network --ip 172.18.1.11 --hostname mysql-metastore -p 3306:3306 --add-host nodemaster:172.18.1.1 --add-host node2:172.18.1.2 --add-host node3:172.18.1.3 --add-host node4:172.18.1.4 --name mysql-metastore -e MYSQL_ROOT_PASSWORD=123456 ashokkumarchoppadandi/mysql

  echo "Deploying Hadoop Master Node"
  docker run -d --net hadoop_network --ip 172.18.1.1 --hostname nodemaster --add-host mysql-metastore:172.18.1.11 --add-host node2:172.18.1.2 --add-host node3:172.18.1.3 --add-host node4:172.18.1.4 -p 50070:50070 -p   8032:8032 -p 8020:8020 -p 50030:50030 -p 19888:19888 -p 8088:8088 --link mysql-metastore --name nodemaster -it ashokkumarchoppadandi/hive bash

  echo "Deploying Hadoop Worker Nodes"
  docker run -d --net hadoop_network --ip 172.18.1.2 --hostname node2 --add-host mysql-metastore:172.18.1.11 --add-host nodemaster:172.18.1.1 --add-host node3:172.18.1.3 --add-host node4:172.18.1.4 --link nodemaster --link mysql-metastore --name node2 -it ashokkumarchoppadandi/hive bash
  docker run -d --net hadoop_network --ip 172.18.1.3 --hostname node3 --add-host mysql-metastore:172.18.1.11 --add-host nodemaster:172.18.1.1 --add-host node2:172.18.1.2 --add-host node4:172.18.1.4 --link nodemaster --link mysql-metastore --name node3 -it ashokkumarchoppadandi/hive bash
  docker run -d --net hadoop_network --ip 172.18.1.4 --hostname node4 --add-host mysql-metastore:172.18.1.11 --add-host nodemaster:172.18.1.1 --add-host node2:172.18.1.2 --add-host node3:172.18.1.3 --link nodemaster --link mysql-metastore --name node4 -it ashokkumarchoppadandi/hive bash
  
  echo "Formatting Namenode on Hadoop Master Node...!!!"
  docker exec -u hadoop -it nodemaster hdfs namenode -format

  echo "Starting the Hadoop Daemons...!!!"
  upDaemons
  exit
fi


echo "Usage: hadoop_cluster.sh deploy|start|stop"
echo "    deploy - Deploy a new cluster"
echo "    start - Start the containers of existing Hadoop Clustere"
echo "    stop - Stop the Hadoop Cluster"




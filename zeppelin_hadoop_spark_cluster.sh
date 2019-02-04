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
  
  # Starting the Spark Master and Worker Daemons
  docker exec -u hadoop -it nodemaster spark-2.3.2/sbin/start-master.sh
  docker exec -u hadoop -it node2 spark-2.3.2/sbin/start-slave.sh nodemaster:7077
  docker exec -u hadoop -it node3 spark-2.3.2/sbin/start-slave.sh nodemaster:7077
  docker exec -u hadoop -it node4 spark-2.3.2/sbin/start-slave.sh nodemaster:7077
  
  # Starting the Zeppelin Daemon
  docker exec -u hadoop -it nodemaster zeppelin-daemon.sh start
  
  echo "Namenode is running @ nodemaster: http://172.18.1.1:50070"
  echo "Resource Manager is running @ nodemaster: http://172.18.1.1:8088"
  echo "Mapreduce History Server is running @ nodemaster: http://172.18.1.1:19888"
  echo "Hive Server2 is running @ nodemaster: http://172.18.1.1:10000"
  echo "Spark Master is running @ nodemaster: http://172.18.1.1:8080"
  echo "Zeppelin is running @ nodemaster: http://172.18.1.1:9090"
}

if [[ $1 = "start" ]]; then
  echo "Starting Hadoop & Spark Services with Zeppelin...!!!"
  upDaemons
  exit
fi

if [[ $1 = "stop" ]]; then
  echo "Stopping the Hadoop, Spark and Zeppelin Services...!!!"
  docker stop nodemaster node2 node3 node4 mysql-metastore
  exit
fi

if [[ $1 = "deploy" ]]; then
  docker rm -f `docker ps -aq`
  docker network rm hadoop_network
  docker network create --subnet=172.18.0.0/16 hadoop_network

  echo "Deploying MySQL database as Hive Metastore"
  docker run  -d --net hadoop_network --ip 172.18.1.11 --hostname mysql-metastore -p 3306:3306 --add-host nodemaster:172.18.1.1 --add-host node2:172.18.1.2 --add-host node3:172.18.1.3 --add-host node4:172.18.1.4 --name mysql-metastore -e MYSQL_ROOT_PASSWORD=123456 ashokkumarchoppadandi/mysql

  # Setting Hive Metastore to MYSQL database
  # docker exec -u hadoop -it nodemaster schematool -dbType mysql -initSchema

  echo "Deploying Hadoop & Spark Master Node with Zeppelin"
  docker run -d --net hadoop_network --ip 172.18.1.1 --hostname nodemaster --add-host mysql-metastore:172.18.1.11 --add-host node2:172.18.1.2 --add-host node3:172.18.1.3 --add-host node4:172.18.1.4 -p 50070:50070 -p 8032:8032 -p 8020:8020 -p 50030:50030 -p 19888:19888 -p 8088:8088 -p 8080:8080 -p 4040:4040 -p 9090:9090 --mount "src=/home/vagrant/ZeppelinNotebooks/,target=/home/hadoop/zeppelin-0.8.1/notebook/,type=bind" --link mysql-metastore --name nodemaster -it ashokkumarchoppadandi/zeppelin bash

  echo "Deploying Hadoop & Spark Worker Nodes"
  docker run -d --net hadoop_network --ip 172.18.1.2 --hostname node2 --add-host mysql-metastore:172.18.1.11 --add-host nodemaster:172.18.1.1 --add-host node3:172.18.1.3 --add-host node4:172.18.1.4 --link nodemaster --link mysql-metastore --name node2 -it ashokkumarchoppadandi/zeppelin bash
  docker run -d --net hadoop_network --ip 172.18.1.3 --hostname node3 --add-host mysql-metastore:172.18.1.11 --add-host nodemaster:172.18.1.1 --add-host node2:172.18.1.2 --add-host node4:172.18.1.4 --link nodemaster --link mysql-metastore --name node3 -it ashokkumarchoppadandi/zeppelin bash
  docker run -d --net hadoop_network --ip 172.18.1.4 --hostname node4 --add-host mysql-metastore:172.18.1.11 --add-host nodemaster:172.18.1.1 --add-host node2:172.18.1.2 --add-host node3:172.18.1.3 --link nodemaster --link mysql-metastore --name node4 -it ashokkumarchoppadandi/zeppelin bash
  
  echo "Formatting Namenode on Hadoop Master Node...!!!"
  docker exec -u hadoop -it nodemaster hdfs namenode -format

  echo "Starting Hadoop & Spark Daemons...!!!"
  upDaemons
  exit
fi


echo "Usage: hadoop_spark_cluster.sh deploy|start|stop"
echo "    deploy - Deploy a new cluster"
echo "    start - Start the containers of existing Hadoop & Spark Cluster"
echo "    stop - Stop Hadoop & Spark Cluster"




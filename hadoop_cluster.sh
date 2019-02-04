#!/bin/bash

# Starting the services
function upDaemons {
  docker start nodemaster node2 node3 node4
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
  echo "Namenode is running @ nodemaster: http://172.18.1.1:50070"
  echo "Resource Manager is running @ nodemaster: http://172.18.1.1:8088"
  echo "Mapreduce History Server is running @ nodemaster: http://172.18.1.1:19888"
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

  echo "Deploying Hadoop Master Node"
  docker run -d --net hadoop_network --ip 172.18.1.1 --hostname nodemaster --add-host node2:172.18.1.2 --add-host node3:172.18.1.3 --add-host node4:172.18.1.4 -p 50070:50070 -p   8032:8032 -p 8020:8020 -p 50030:50030 -p 19888:19888 -p 8088:8088 --name nodemaster -it ashokkumarchoppadandi/hadoop:latest bash

  echo "Deploying Hadoop Worker Nodes"
  docker run -d --net hadoop_network --ip 172.18.1.2 --hostname node2  --add-host nodemaster:172.18.1.1 --add-host node3:172.18.1.3 --add-host node4:172.18.1.4 --link nodemaster --name node2 -it ashokkumarchoppadandi/hadoop:latest bash
  docker run -d --net hadoop_network --ip 172.18.1.3 --hostname node3  --add-host nodemaster:172.18.1.1 --add-host node2:172.18.1.2 --add-host node4:172.18.1.4 --link nodemaster --name node3 -it ashokkumarchoppadandi/hadoop:latest bash
  docker run -d --net hadoop_network --ip 172.18.1.4 --hostname node4  --add-host nodemaster:172.18.1.1 --add-host node2:172.18.1.2 --add-host node3:172.18.1.3 --link nodemaster --name node4 -it ashokkumarchoppadandi/hadoop:latest bash
  
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



